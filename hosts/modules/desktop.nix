{ config, lib, pkgs, ... }:

{
  # Desktop applications and integration bits shared by both GNOME Shell and
  # niri/noctalia sessions. Session-specific display/login settings belong in
  # gnome.nix or noctalia.nix.

  # GNOME-adjacent services used by Nautilus and many GTK/GNOME apps even when
  # the actual session is niri/noctalia.
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.gnome.gnome-keyring.enable = true;

  # Bluetooth GUI for non-GNOME sessions such as niri/noctalia.
  services.blueman.enable = true;

  # Firefox is a desktop application, so keep it with the desktop profile.
  programs.firefox.enable = true;

  # Enable to use Saleae Logic 2
  hardware.saleae-logic.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

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
    loupe
    mpv
    papers
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
