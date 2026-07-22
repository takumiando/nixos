{ pkgs, ... }:

{
  imports = [ ./desktop.nix ];

  # GNOME Shell session and GDM. Shared GNOME applications live in desktop.nix.
  environment.systemPackages = with pkgs; [
    gnome-tweaks
    gnomeExtensions.blur-my-shell
    gnomeExtensions.tailscale-qs
    gnomeExtensions.kimpanel
    gnomeExtensions.color-picker
    gnomeExtensions.gsconnect
  ];

  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gnome
  ];
}
