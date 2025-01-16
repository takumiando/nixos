{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware/hazzard.nix
    ];

  networking.hostName = "hazzard";
}
