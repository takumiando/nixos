{ config, pkgs, ... }:

{
  imports =
    [
      ./modules/common.nix
      ./modules/nix-on-droid.nix
    ];

  networking.hostName = "machu";
}
