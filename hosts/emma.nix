{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware/emma.nix
      ./modules/common.nix
      ./modules/gnome.nix
    ];

  networking.hostName = "emma";

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  environment.systemPackages = with pkgs; [
    prusa-slicer
  ];
}
