{ config, pkgs, home-manager, ... }:

{
  # Imports
  imports = [
    home-manager.nixosModules.home-manager
  ];

  # Enable Home Manager as part of nixos-rebuild, so system and user
  # generations are switched atomically.
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.takumi.imports = [
    ../../home/takumi.nix
    ../../home/gnome.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 8;

  # Latest Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Kernel parameters
  boot.kernelParams = [
    "zswap.enabled=1"
    "zswap.compressor=zstd"
    "zswap.max_pool_percent=20"
    "zswap.shrinker_enabled=1"
  ];

  # Swaps
  swapDevices = [
    # "size" is specified in MB to be set up in /etc/fstab
    {
      device = "/swapfile";
      size = 16*1024;
    }
  ];

  # Enable support for running aarch64-linux binaries via qemu
  boot.binfmt= {
    emulatedSystems = [ "aarch64-linux" ];
    preferStaticEmulators = true;
  };

  # Enable networking
  networking.networkmanager.enable = true;

  # Use DNS from Cloudflare
  networking.nameservers = [
    "1.1.1.1"
    "1.0.0.1"
  ];

  # Disable EDNS
  networking.resolvconf.dnsExtensionMechanism = false;

  # Enable Bluetooth. GNOME used to enable this implicitly; keep it
  # explicit so niri/noctalia machines keep working without GNOME Shell.
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable fcitx5-mozc
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";

    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
      ];
    };
  };

  # Fonts
  fonts = {
    packages = with pkgs; [
      dejavu_fonts
      adwaita-fonts
      noto-fonts
      noto-fonts-cjk-serif
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      nerd-fonts.jetbrains-mono
      mplus-outline-fonts.githubRelease
    ];

    fontDir.enable = true;

    fontconfig = {
      defaultFonts = {
        sansSerif = [
          "DejaVu Sans"
          "Noto Sans CJK JP"
        ];
        serif = [
          "DejaVu Serif"
          "Noto Serif CJK JP"
        ];
        monospace = [
          "JetBrainsMono Nerd Font"
          "DejaVu Sans Mono"
          "Noto Sans Mono CJK JP"
        ];
        emoji = [
          "Noto Color Emoji"
        ];
      };

      aliases."Adwaita Sans" = {
        binding = "strong";
        accept = [
          "Noto Sans CJK JP"
        ];
      };
    };
  };

  # Use CapsLock as Left Ctrl
  services.udev.extraHwdb = ''
    evdev:input:b*
      KEYBOARD_KEY_3a=leftctrl
  '';

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Groups
  users.groups.plugdev = {};

  # User
  users.users.takumi = {
    isNormalUser = true;
    description = "Takumi Ando";
    extraGroups = [
      "wheel"
      "dialout"
      "networkmanager"
      "libvirtd"
      "plugdev"
      "video"
    ];
    shell = pkgs.zsh;
  };

  # Make /opt symlink to /home/takumi/opt
  systemd.tmpfiles.rules = [
    "d /home/takumi/opt 0755 takumi users -"
    "L+ /opt - - - - /home/takumi/opt"
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable to use non-nix executables
  programs.nix-ld = {
    enable = true;
    libraries = [];
  };

  # Enable zsh
  programs.zsh.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  boot.supportedFilesystems = [ "ntfs" ];

  # Enable podman
  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # Enable libvirt
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      runAsRoot = true;
      swtpm.enable = true;
    };
  };

  # Enable USB accesses in VMs
  virtualisation.spiceUSBRedirection.enable = true;

  # Enable UPower
  services.upower.enable = true;

  # Use TLP instead of power-profile-daemon
  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 60;

      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";

      DISK_IDLE_SECS_ON_AC = "0";
      DISK_IDLE_SECS_ON_BAT = "2";

      NVME_APST_ON_AC = 1;
      NVME_APST_ON_BAT = 1;

      USB_AUTOSUSPEND = 1;

      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "on";

      SOUND_POWER_SAVE_ON_AC = 0;
      SOUND_POWER_SAVE_ON_BAT = 1;

      START_CHARGE_THRESH_BAT0=85;
      STOP_CHARGE_THRESH_BAT0=90;
    };
  };

  # Enable tailscale
  services.tailscale.enable = true;

  # Enable fwupd
  services.fwupd.enable = true;

  # Packages
  environment.systemPackages = with pkgs; [
    # Common utils
    binutils
    moreutils
    gnumake
    gcc
    cmake
    neovim
    vim
    tmux
    gitFull
    git-lfs
    htop
    btop
    fzf
    bc
    file
    starship
    restic
    global
    killall
    tree

    # Alternative shell utils
    eza
    bat
    ripgrep
    fd
    dust

    # Archive utils
    zip
    unzip
    unrar
    zstd
    unar

    # Programming
    python3
    julia
    nodejs
    uv

    # Networking
    iw
    tailscale

    # Development tools
    gh
    chafa
    silver-searcher-ng
    shellcheck
    imagemagick
    minicom
    tio
    just
    libfaketime
    yazi
    binwalk
    jq
    aria2
    docutils

    # Multimedia
    ffmpeg-full
    yt-dlp

    # Sound effector

    # Hardware utils
    usbutils
    pciutils
    powertop

    # Virtualization
    distrobox
    qemu-utils

    # Non-free apps

    # Etc
    fastfetch
    pfetch

    # Messaging

    # Nix utils
    home-manager
  ];

  # Nix settings
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 90d";
    };
  };

  system.stateVersion = "25.11";
}
