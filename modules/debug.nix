{ config, pkgs, ... }:

{
  systemd.coredump.settings.Coredump = {
    Storage = "external";
    Compress = true;

    ProcessSizeMax = "4G";
    ExternalSizeMax = "4G";

    MaxUse = "8G";
    KeepFree = "20G";
  };
}
