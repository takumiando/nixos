{ ... }:

{
  services.udev.extraHwdb = ''
    # Swap left Alt and Super on the ThinkPad keyboard
    evdev:input:b*
      ID_BUS==i8042
      ID_PATH==platform-i8042-serio-0*
      KEYBOARD_KEY_38=leftmeta
      KEYBOARD_KEY_db=leftalt
  '';
}
