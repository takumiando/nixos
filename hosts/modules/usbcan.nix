{ config, lib, pkgs, ... }:

let
  cfg = config.services.usbSlcan;
in
{
  options.services.usbSlcan = {
    enable = lib.mkEnableOption "Auto-attach USB SLCAN (slcand) via udev + systemd";

    idVendor = lib.mkOption {
      type = lib.types.str;
      default = "16d0";
      description = "USB idVendor";
    };

    idProduct = lib.mkOption {
      type = lib.types.str;
      default = "117e";
      description = "USB idProduct";
    };

    ttyKernelPattern = lib.mkOption {
      type = lib.types.str;
      default = "ttyACM*";
      description = "Kernel name pattern for the tty device";
    };

    canIfName = lib.mkOption {
      type = lib.types.str;
      default = "can0";
      description = "CAN netdev name to create";
    };

    slcanSpeed = lib.mkOption {
      type = lib.types.str;
      default = "0";
      description = "slcand -sX speed index (string)";
    };

    bitrate = lib.mkOption {
      type = lib.types.int;
      default = 1000000;
      description = "CAN bitrate for ip link";
    };

    stopOnRemove = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Stop slcand and bring CAN down on USB device removal";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      can-utils
    ];

    services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="tty", KERNEL=="${cfg.ttyKernelPattern}", \
        ATTRS{idVendor}=="${cfg.idVendor}", ATTRS{idProduct}=="${cfg.idProduct}", \
        TAG+="systemd", ENV{SYSTEMD_WANTS}+="slcan@%k.service"
    '';

    systemd.services."slcan@" = {
      description = "Attach SLCAN interface to %I";

      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;

        ExecStart = [
          "${pkgs.can-utils}/bin/slcand -o -c -s${cfg.slcanSpeed} /dev/%I ${cfg.canIfName}"
          "${pkgs.iproute2}/bin/ip link set ${cfg.canIfName} up type can bitrate ${toString cfg.bitrate}"
        ];

        ExecStop = [
          "${pkgs.iproute2}/bin/ip link set ${cfg.canIfName} down"
          "${pkgs.procps}/bin/pkill -f '^slcand .* /dev/%I ${cfg.canIfName}$'"
        ];

        TimeoutStartSec = 10;
      };
    };

    systemd.services."slcan-stop@" = lib.mkIf cfg.stopOnRemove {
      description = "Stop SLCAN for %I";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.systemd}/bin/systemctl stop slcan@%I.service";
      };
    };
  };
}
