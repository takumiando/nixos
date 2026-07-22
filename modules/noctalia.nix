{ pkgs, noctalia, ... }:

{
  imports = [ ./desktop.nix ];

  # niri/noctalia session. Shared GNOME applications such as Nautilus live in
  # desktop.nix so they are available here without enabling GNOME Shell/GDM.
  environment.systemPackages = with pkgs; [
    noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default

    xwayland-satellite
    brightnessctl
    pavucontrol
    grim
    slurp
    hyprpicker
  ];

  programs.niri.enable = true;

  xdg.portal.config = {
    niri = {
      default = [ "gnome" "gtk" ];
    };
  };

  # Bluetooth GUI for non-GNOME sessions such as niri/noctalia.
  services.blueman.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        user = "greeter";
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd ${pkgs.niri}/bin/niri-session";
      };
    };
  };

  security.pam.services.greetd.enableGnomeKeyring = true;
}
