{ config, lib, pkgs, ... }:

let
  cfg = config.services.slcand;
in
{
  options.services.slcand = {
    enable = lib.mkEnableOption "Auto-attach USB-CAN converter";
  };

  config = lib.mkIf cfg.enable {
    services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="tty", KERNEL=="ttyACM*", \
        ENV{ID_VENDOR_ID}=="16d0", ENV{ID_MODEL_ID}=="117e", \
        TAG+="systemd", ENV{SYSTEMD_WANTS}+="slcand@%k.service"

      ACTION=="remove", SUBSYSTEM=="tty", KERNEL=="ttyACM*", \
        ENV{ID_VENDOR_ID}=="16d0", ENV{ID_MODEL_ID}=="117e", \
        RUN+="${pkgs.systemd}/bin/systemctl stop slcand@%k.service"
    '';

    systemd.services."slcand@" = {
      description = "Serial CAN daemon on %I";
      serviceConfig = {
        Type = "forking";
        ExecStart = "${pkgs.can-utils}/bin/slcand -o -c -f -s0 /dev/%I can-%I";
        ExecStartPost = "${pkgs.iproute2}/bin/ip link set can-%I up type can bitrate 1000000";
        ExecStopPost = "-${pkgs.iproute2}/bin/ip link set can-%I down";
      };
    };
  };
}
