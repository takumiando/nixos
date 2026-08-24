{ pkgs, ... }:

{
  imports =
    [
      ./hardware/hazzard.nix
      ../modules/common.nix
      ../modules/noctalia.nix
      ../modules/sc-printers.nix
      ../modules/keyboard.nix
      ../modules/xilinx.nix
      ../modules/zephyr.nix
      ../modules/alientek.nix
      ../modules/sdwire.nix
      ../modules/usbcan.nix
      ../modules/cyusb.nix
      ../modules/debug.nix
      ../modules/swapfile.nix
    ];

  networking.hostName = "hazzard";

  services.slcand.enable = true;

  environment.systemPackages = with pkgs; [
    libreoffice-qt
    pandoc
    zola
    antora
    asciidoctor
  ];

  # Hazzard has the broken CPU core 5(CPU10 and 11).
  # Use the kernel parameter `maxcpus=1` to limit the number of CPUs used by the system to 1 at boot time.
  boot.kernelParams = [
    "maxcpus=1"
  ];

  # After boot, enable the remaining good CPUs (1 to 9, 12 to 15) to be used by
  # the system.
  systemd.services.enable-good-cpus = {
    description = "Enable good CPUs";

    wantedBy = [ "sysinit.target" ];
    before = [ "sysinit.target" ];

    unitConfig.DefaultDependencies = false;

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };

    script = ''
      for num in 1 2 3 4 5 6 7 8 9 12 13 14 15; do
        echo 1 > /sys/devices/system/cpu/cpu$num/online
      done
    '';
  };
}
