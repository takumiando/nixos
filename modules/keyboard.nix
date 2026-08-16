{ ... }:

{
  services.udev.extraHwdb = ''
    # Swap left Alt and Super on the ThinkPad keyboard
    evdev:input:b*
      ID_BUS==i8042
      ID_PATH==platform-i8042-serio-0*
      KEYBOARD_KEY_38=leftmeta
      KEYBOARD_KEY_db=leftalt

    # Swap left Alt and Super on the USB-HID Keyboard (04d9:0532)
    evdev:input:b0003v04D9p0532*
      KEYBOARD_KEY_700e2=leftmeta
      KEYBOARD_KEY_700e3=leftalt
  '';
}
