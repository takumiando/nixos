{ config, pkgs, ... }:

{
  services.udev.extraRules = ''
    # rules for SDWire3
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0bda", ATTRS{idProduct}=="0316", MODE="0660", GROUP="plugdev", TAG+="uaccess"
  '';
}
