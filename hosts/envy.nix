{ pkgs, ... }:

{
  imports =
    [
      ./hardware/envy.nix
      ../modules/common.nix
      ../modules/tpkbd.nix
      ../modules/noctalia.nix
    ];

  networking.hostName = "envy";

  environment.systemPackages = with pkgs; [
    prusa-slicer
  ];
}
