{ pkgs, ... }:

{
  imports =
    [
      ./hardware/ramona.nix
      ../modules/common.nix
      ../modules/tpkbd.nix
      ../modules/noctalia.nix
      ../modules/linux-ptl.nix
    ];

  networking.hostName = "ramona";

  environment.systemPackages = with pkgs; [
    prusa-slicer
  ];
}
