{ config, pkgs, lib, ... }:

let
  powerSourceSwitch = pkgs.writeShellScript "power-source-switch" ''
    set -euo pipefail

    PATH=${lib.makeBinPath [
      pkgs.coreutils
      pkgs.findutils
      pkgs.gnugrep
      pkgs.gawk
      pkgs.power-profiles-daemon
      pkgs.powertop
    ]}

    on_ac=0

    sleep 3

    for d in /sys/class/power_supply/*; do
      [ -d "$d" ] || continue

      if [ -r "$d/type" ] && [ -r "$d/online" ]; then
        if [ "$(cat "$d/type")" = "Mains" ] && [ "$(cat "$d/online")" = "1" ]; then
          on_ac=1
          break
        fi
      fi
    done

    if [ "$on_ac" -eq 1 ]; then
      echo "[power] AC online -> performance"
      powerprofilesctl set performance || true

      if [ -w /sys/module/pcie_aspm/parameters/policy ]; then
        echo performance > /sys/module/pcie_aspm/parameters/policy || true
      fi
    else
      echo "[power] Battery -> power-saver + powertop auto-tune"
      powerprofilesctl set power-saver || true

      if [ -w /sys/module/pcie_aspm/parameters/policy ]; then
        echo powersupersave > /sys/module/pcie_aspm/parameters/policy || true
      fi

      ${pkgs.powertop}/bin/powertop --auto-tune || true
    fi
  '';
in
{
  services.power-profiles-daemon.enable = true;

  boot.kernelParams = [
    "pcie_aspm=force"
    "nmi_watchdog=0"
  ];

  boot.extraModprobeConfig = ''
    options snd_hda_intel power_save=1
  '';

  networking.networkmanager.wifi.powersave = true;

  systemd.services.power-source-switch = {
    description = "Switch power settings based on AC state";
    after = [ "power-profiles-daemon.service" ];
    wants = [ "power-profiles-daemon.service" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = powerSourceSwitch;
    };
  };

  systemd.services.power-source-switch-startup = {
    description = "Apply power settings at boot";
    wantedBy = [ "multi-user.target" ];
    after = [ "power-profiles-daemon.service" ];
    wants = [ "power-profiles-daemon.service" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.systemd}/bin/systemctl start power-source-switch.service";
    };
  };

  services.udev.extraRules = ''
    ACTION=="change", SUBSYSTEM=="power_supply", TAG+="systemd", ENV{SYSTEMD_WANTS}+="power-source-switch.service"
  '';
}
