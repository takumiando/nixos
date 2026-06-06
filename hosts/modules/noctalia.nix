{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    noctalia-shell

    xwayland-satellite
    brightnessctl
    pavucontrol
    wl-clipboard
    grim
    slurp
    hyprpicker

    adwaita-icon-theme
  ];

  programs.niri = {
    enable = true;
    useNautilus = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];

    config = {
      niri = {
        default = [ "gnome" "gtk" ];
      };
    };
  };

  services.displayManager.gdm.enable = lib.mkForce false;
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        user = "greeter";
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd ${pkgs.niri}/bin/niri-session";
      };
    };
  };

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;
}
