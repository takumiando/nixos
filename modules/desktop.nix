{ pkgs, ... }:

{
  # Desktop applications and integration bits shared by both GNOME Shell and
  # niri/noctalia sessions. Session-specific display/login settings belong in
  # gnome.nix or noctalia.nix.

  # GNOME-adjacent services used by Nautilus and many GTK/GNOME apps even when
  # the actual session is niri/noctalia.
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.gnome.gnome-keyring.enable = true;

  # EasyEffects 8 stores these global stream-routing flags in KConfig.
  # Keep input processing disabled so browser calls connect directly to
  # Bluetooth headset microphones and WirePlumber can autoswitch to HFP/mSBC.
  # The [$i] marker makes only these keys immutable via KConfig kiosk support,
  # while leaving the rest of EasyEffects' user-writable config alone.
  environment.etc."xdg/easyeffects/db/easyeffectsrc".text = ''
    [EffectsPipelines]
    processAllInputs[$i]=false
    processAllOutputs[$i]=true
  '';

  # Switch A2DP/LDAC to HFP/HSP profiles automatically when mic is used
  services.pipewire.wireplumber.extraConfig = {
    "10-bluez-msbc" = {
      "monitor.bluez.properties" = {
        "bluez5.enable-msbc" = true;
        "bluez5.hfphsp-backend" = "native";
        "bluez5.a2dp.ldac.quality" = "auto";
      };
    };

    "11-bluetooth-autoswitch" = {
      "wireplumber.settings" = {
        "bluetooth.autoswitch-to-headset-profile" = true;
      };
    };
  };

  # Firefox is a desktop application, so keep it with the desktop profile.
  programs.firefox.enable = true;

  # Enable to use Saleae Logic 2
  hardware.saleae-logic.enable = true;

  xdg.portal.enable = true;

  environment.systemPackages = with pkgs; [
    # Terminal / desktop shell utilities
    ghostty
    waypipe
    wl-clipboard
    xsel

    # GNOME/GTK apps and integration bits shared by both desktop sessions
    nautilus
    loupe
    papers
    showtime
    gnome-calculator
    gnome-font-viewer
    gnome-boxes
    ffmpegthumbnailer
    dconf2nix
    adwaita-icon-theme

    # Multimedia / creative desktop apps
    mpv
    gimp3
    inkscape
    transmission_4-gtk
    fstl
    easyeffects

    # Virtualization frontends
    virt-manager

    # Development tools
    saleae-logic-2

    # Non-free desktop apps
    vivaldi
    spotify
    discord
    steam
    google-chrome

    # Messaging
    signal-desktop
  ];
}
