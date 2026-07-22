{ ... }:

{
  services.udev.extraRules = ''
    # Microsemi FlashPro Series
    KERNEL=="*", SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTR{idVendor}=="1514", MODE="0660", GROUP="plugdev", TAG+="uaccess", TAG+="cyusb_dev"
  '';
}
