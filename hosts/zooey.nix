{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware/zooey.nix
      ./modules/common.nix
      ./modules/tpkbd.nix
      ./modules/noctalia.nix
    ];

  networking.hostName = "zooey";

  # Enable fingerprint reader
  services.fprintd.enable = true;
}
