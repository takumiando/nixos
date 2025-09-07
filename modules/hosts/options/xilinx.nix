{ config, pkgs, ... }:

{
  services.udev.extraRules = ''
    # AMD(Xilinx) Platform Cable USB II
    SUBSYSTEM=="usb", ATTR{idVendor}=="03fd", MODE="0664", GROUP="plugdev"
  '';
}
