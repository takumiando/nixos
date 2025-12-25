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
      ./modules/alientek.nix
      ./modules/sdwire.nix
    ];

  networking.hostName = "hazzard";

  environment.systemPackages = with pkgs; [
    libreoffice-qt
    pandoc
    zola
    antora
    asciidoctor
  ];
}
