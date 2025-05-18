{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware/ramona.nix
      ./options/tpkbd.nix
    ];

  networking.hostName = "ramona";

  # Enable fingerprint reader
  services.fprintd.enable = true;
}
