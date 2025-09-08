{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware/ramona.nix
      ../options/tpkbd.nix
    ];

  networking.hostName = "ramona";

  environment.systemPackages = with pkgs; [
    prusa-slicer
  ];

  # Enable fingerprint reader
  services.fprintd.enable = true;
}
