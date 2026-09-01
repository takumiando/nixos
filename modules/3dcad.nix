{ lib, pkgs, ... }:

let
  mayo = pkgs.mayo.overrideAttrs (_old: {
    desktopItems = [
      (pkgs.makeDesktopItem {
        name = "mayo";
        desktopName = "Mayo";
        exec = "mayo %F";
        icon = "mayo";
        comment = "3D CAD viewer and converter";
        categories = [
          "Graphics"
          "3DGraphics"
          "Engineering"
        ];
        mimeTypes = [
          "model/step"
          "model/stl"
        ];
      })
    ];
  });

  f3d-isometric = pkgs.writeText "f3d-isometric.txt" ''
    set_camera isometric
  '';

  gl-library-path = lib.makeLibraryPath [
    pkgs.libglvnd
    pkgs.mesa
  ];

  cad-thumbnailer = pkgs.writeShellApplication {
    name = "cad-thumbnailer";

    runtimeInputs = [
      pkgs.coreutils
      pkgs.f3d
      pkgs.libglvnd
      pkgs.mesa
      pkgs.xorg-server
    ];

    text = ''
      input="$1"
      output="$2"
      size="$3"
      xvfb_pid=

      # shellcheck disable=SC2329
      cleanup()
      {
          if [ -n "$xvfb_pid" ]; then
              kill "$xvfb_pid" 2>/dev/null || true
              wait "$xvfb_pid" 2>/dev/null || true
          fi
      }

      trap cleanup EXIT INT TERM

      export LD_LIBRARY_PATH=${gl-library-path}
      export LIBGL_DRIVERS_PATH=${pkgs.mesa}/lib/dri
      export __GLX_VENDOR_LIBRARY_NAME=mesa
      export LIBGL_ALWAYS_SOFTWARE=1
      export GALLIUM_DRIVER=llvmpipe

      mkdir -p /tmp/.X11-unix

      Xvfb :99 \
        -screen 0 "''${size}x''${size}x24" \
        -nolisten tcp \
        -ac \
        +extension GLX \
        +render \
        -noreset \
        >/dev/null 2>&1 &

      xvfb_pid=$!

      i=0
      while [ ! -S /tmp/.X11-unix/X99 ]; do
          if ! kill -0 "$xvfb_pid" 2>/dev/null; then
              exit 1
          fi

          i=$((i + 1))
          if [ "$i" -ge 100 ]; then
              exit 1
          fi

          sleep 0.05
      done

      common=(
        --no-config
        --rendering-backend=glx
        --resolution="$size,$size"
        --output="$output"
        --up=+Z
        --camera-orthographic
        --command-script=${f3d-isometric}
        --anti-aliasing=ssaa
        --hdri-ambient
        --no-background
        --tone-mapping
        --blending=ddp
      )

      run_f3d()
      {
          env \
            -u WAYLAND_DISPLAY \
            DISPLAY=:99 \
            HOME=/tmp \
            XDG_CACHE_HOME=/tmp \
            timeout --kill-after=1s 20s \
            f3d "$@"
      }

      case "$input" in
        *.step|*.stp)
          run_f3d \
            "''${common[@]}" \
            -DSTEP.read_wire=0 \
            "$input"
          ;;

        *.stl)
          run_f3d \
            "''${common[@]}" \
            "$input"
          ;;

        *)
          exit 1
          ;;
      esac
    '';
  };

  cad-thumbnailer-data = pkgs.writeTextFile {
    name = "cad-thumbnailer-data";
    destination = "/share/thumbnailers/cad.thumbnailer";

    text = ''
      [Thumbnailer Entry]
      TryExec=${cad-thumbnailer}/bin/cad-thumbnailer
      Exec=${cad-thumbnailer}/bin/cad-thumbnailer %i %o %s
      MimeType=model/step;model/stl;
    '';
  };

  step-mime = pkgs.writeTextFile {
    name = "step-mime";
    destination = "/share/mime/packages/step.xml";

    text = ''
      <?xml version="1.0" encoding="UTF-8"?>
      <mime-info xmlns="http://www.freedesktop.org/standards/shared-mime-info">
        <mime-type type="model/step">
          <comment>STEP 3D model</comment>
          <glob pattern="*.step"/>
          <glob pattern="*.stp"/>
          <magic>
            <match
              type="string"
              value="ISO-10303-21;"
              offset="0"
            />
          </magic>
        </mime-type>
      </mime-info>
    '';
  };
in
{
  xdg.mime = {
    enable = true;

    addedAssociations = {
      "model/step" = "mayo.desktop";
      "model/stl" = "mayo.desktop";
    };

    defaultApplications = {
      "model/step" = "mayo.desktop";
      "model/stl" = "mayo.desktop";
    };
  };

  environment.systemPackages = [
    mayo
    pkgs.f3d
    cad-thumbnailer
    cad-thumbnailer-data
    step-mime
  ];

  environment.pathsToLink = [
    "/share/applications"
    "/share/thumbnailers"
    "/share/mime"
  ];
}
