{ pkgs, ... }:

{
  imports =
    [
      ./hardware/ramona.nix
      ../modules/common.nix
      ../modules/keyboard.nix
      ../modules/noctalia.nix
      ../modules/linux-ptl.nix
      ../modules/numworks.nix
    ];

  networking.hostName = "ramona";

  environment.systemPackages = with pkgs; [
    prusa-slicer
  ];
}
