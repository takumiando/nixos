{ config, pkgs, ... }:

{
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="03fd", MODE="0664", GROUP="plugdev"
  '';
}
