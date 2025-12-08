{ config, pkgs, ... }:

{
  services.udev.extraRules = ''
    # ALIENTEK DP100
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="2e3c", ATTRS{idProduct}=="af01", MODE="0666", GROUP="plugdev"
  '';
}
