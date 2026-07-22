{ config, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
      ../modules/common.nix
      ../modules/gnome.nix
    ];

  networking.hostName = "nixos";
}
