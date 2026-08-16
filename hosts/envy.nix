{ pkgs, ... }:

{
  imports =
    [
      ./hardware/envy.nix
      ../modules/common.nix
      ../modules/keyboard.nix
      ../modules/noctalia.nix
    ];

  networking.hostName = "envy";

  environment.systemPackages = with pkgs; [
    prusa-slicer
  ];
}
