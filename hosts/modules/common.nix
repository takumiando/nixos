{ config, pkgs, home-manager, ... }:

{
  # Imports
  imports = [ home-manager.nixosModules.home-manager ];

  # Enable Home Manager
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 8;

  # Enable support for running aarch64-linux binaries via qemu
  boot.binfmt= {
    emulatedSystems = [ "aarch64-linux" ];
    preferStaticEmulators = true;
  };

  # Enable networking
  networking.networkmanager.enable = true;

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
      fcitx5.addons = [ pkgs.fcitx5-mozc ];
  };

  # Japanese fonts
  fonts = {
    packages = with pkgs; [
      noto-fonts-cjk-serif
      noto-fonts-cjk-sans
      noto-fonts-emoji
      nerd-fonts.jetbrains-mono
    ];
    fontDir.enable = true;
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
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

  # Install firefox.
  programs.firefox = {
    enable = true;
    nativeMessagingHosts.packages = with pkgs; [ vdhcoapp ];
  };

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
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [(pkgs.OVMF.override {
          secureBoot = true;
          tpmSupport = true;
        }).fd];
      };
    };
  };

  # Enable USB accesses in VMs
  virtualisation.spiceUSBRedirection.enable = true;

  # Enable tailscale
  services.tailscale.enable = true;

  # Enable fwupd
  services.fwupd.enable = true;

  # Enable to use Saleae Logic 2
  hardware.saleae-logic.enable = true;

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
    git
    git-lfs
    htop
    btop
    fzf
    bc
    file
    xsel
    starship
    restic
    global
    waypipe
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
    tailscale

    # Development tools
    gh
    ghostty
    chafa
    silver-searcher
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
    saleae-logic-2

    # Multimedia
    ffmpeg
    mpv
    gimp3
    inkscape
    yt-dlp
    transmission_4-gtk
    fstl

    # Sound effector
    easyeffects

    # Hardware utils
    usbutils
    pciutils

    # Virtualization
    distrobox
    qemu_full
    qemu-utils
    virt-manager
    gnome-boxes

    # Non-free apps
    vivaldi
    spotify
    discord
    steam
    google-chrome

    # GNOME utils and extensions
    gnome-tweaks
    dconf2nix
    gnomeExtensions.blur-my-shell
    gnomeExtensions.tailscale-qs
    gnomeExtensions.kimpanel
    gnomeExtensions.color-picker
    gnomeExtensions.gsconnect

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
