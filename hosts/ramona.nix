{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware/ramona.nix
      ./modules/common.nix
      ./modules/tpkbd.nix
    ];

  networking.hostName = "ramona";

  environment.systemPackages = with pkgs; [
    prusa-slicer
  ];

  # Enable fingerprint reader
  services.fprintd.enable = true;
}
