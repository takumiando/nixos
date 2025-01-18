{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware/zooey.nix
      ./options/tpkbd.nix
    ];

  networking.hostName = "zooey";

  # Enable fingerprint reader
  services.fprintd.enable = true;
}
