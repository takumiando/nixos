{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware/vm.nix
    ];

  networking.hostName = "vm";
}
