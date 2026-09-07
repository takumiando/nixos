{ ... }:

{
  services.udev.extraRules = ''
    # NumWorks calculators
    SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="a291", GROUP="plugdev"
    SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="df11", GROUP="plugdev"
    SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="a51a", GROUP="plugdev"
  '';
}
