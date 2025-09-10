{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware/hazzard.nix
      ./modules/common.nix
      ./modules/sc-printers.nix
      ./modules/tpkbd.nix
      ./modules/xilinx.nix
      ./modules/zephyr.nix
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
