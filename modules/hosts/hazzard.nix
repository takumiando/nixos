{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware/hazzard.nix
      ./options/tpkbd.nix
      ./options/zephyr-sdk-openocd-udev-rules.nix
    ];

  networking.hostName = "hazzard";

  environment.systemPackages = with pkgs; [
    google-chrome
    libreoffice-qt
    pandoc
    zola
    antora
    asciidoctor
  ];
}
