{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware/ramona.nix
    ];

  networking.hostName = "ramona";
}
