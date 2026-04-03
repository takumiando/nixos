{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware/zooey.nix
      ./modules/common.nix
      ./modules/laptop.nix
      ./modules/tpkbd.nix
    ];

  networking.hostName = "zooey";

  # Enable fingerprint reader
  services.fprintd.enable = true;
}
