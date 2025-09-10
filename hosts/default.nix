{ config, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
      ./modules/common.nix
    ];

  networking.hostName = "nixos";
}
