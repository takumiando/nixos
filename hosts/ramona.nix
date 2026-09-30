{ pkgs, ... }:

{
  imports =
    [
      ./hardware/ramona.nix
      ../modules/common.nix
      ../modules/keyboard.nix
      ../modules/noctalia.nix
      ../modules/numworks.nix
    ];

  networking.hostName = "ramona";

  boot.kernelParams = [
    "xe.enable_psr=2"
  ];

  environment.systemPackages = with pkgs; [
    prusa-slicer
  ];
}
