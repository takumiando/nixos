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
      ./modules/usbcan.nix
    ];

  networking.hostName = "hazzard";

  services.usbSlcan.enable = true;

  environment.systemPackages = with pkgs; [
    libreoffice-qt
    pandoc
    zola
    antora
    asciidoctor
  ];
}
