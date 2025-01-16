{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware/zooey.nix
    ];

  networking.hostName = "zooey";
}
