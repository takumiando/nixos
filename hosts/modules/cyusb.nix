{ config, pkgs, ... }:

{
  services.udev.extraRules = ''
    # Microsemi FlashPro Series
    KERNEL=="*", SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTR{idVendor}=="1514", MODE="666", GROUP="plugdev", TAG="cyusb_dev"
  '';
}
