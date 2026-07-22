{ ... }:

{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
      ../modules/common.nix
      ../modules/gnome.nix
      ../modules/swapfile.nix
    ];

  networking.hostName = "nixos";
}
