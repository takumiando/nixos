{ config, ... }:

{
  assertions = [
    {
      assertion = builtins.length config.swapDevices == 1;
      message = "swapfile.nix must only be imported on hosts without another swap device";
    }
  ];

  swapDevices = [
    # "size" is specified in MB to be set up in /etc/fstab
    {
      device = "/swapfile";
      size = 16 * 1024;
    }
  ];
}
