{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware/zooey.nix
    ];

  networking.hostName = "zooey";

  # Enable fingerprint reader
  services.fprintd.enable = true;
}
