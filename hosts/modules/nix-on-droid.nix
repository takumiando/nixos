{ config, pkgs, home-manager, ... }:

{
  android-integration.termux-open.enable = true;
  android-integration.termux-open-url.enable = true;
  android-integration.termux-reload-settings.enable = true;
  android-integration.termux-setup-storage.enable = true;
}
