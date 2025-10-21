{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware/emma.nix
      ./modules/common.nix
    ];

  networking.hostName = "emma";

  environment.systemPackages = with pkgs; [
    prusa-slicer
  ];
}
