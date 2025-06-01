{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware/hazzard.nix
    ];

  networking.hostName = "hazzard";

  environment.systemPackages = with pkgs; [
    google-chrome
    libreoffice-qt
  ];
}
