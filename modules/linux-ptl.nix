{ config, lib, pkgs, ... }:

let
  linuxPtlPatchDir = ./patches/linux-ptl;
  linuxPtlPatch = name: linuxPtlPatchDir + "/${name}";
in
{
  # Use Linux Kernel v7.1
  boot.kernelPackages =
    pkgs.linuxPackagesFor pkgs.linuxKernel.kernels.linux_7_1;

  # Apply linux-ptl patches from omarchy-pkgs
  boot.kernelPatches = lib.mkAfter [
    {
      name = "ASoC-SDCA-Fix-NULL-pointer-dereference-in-sdca_jack";
      patch = linuxPtlPatch "0017-ASoC-SDCA-Fix-NULL-pointer-dereference-in-sdca_jack_.patch";
    }
    {
      name = "drm-i915-psr-accept-early-transport-for-psr2";
      patch = linuxPtlPatch "0019-drm-i915-psr-accept-early-transport-for-psr2.patch";
    }
    {
      name = "drm-i915-alpm-limit-pr-alpm-to-panel-replay";
      patch = linuxPtlPatch "0020-drm-i915-alpm-limit-pr-alpm-to-panel-replay.patch";
    }
    {
      name = "drm-i915-psr-allow-psr-with-vrr-on-ptl";
      patch = linuxPtlPatch "0022-drm-i915-psr-allow-psr-with-vrr-on-ptl.patch";
    }
    {
      name = "drm-edid-populate-monitor-range-from-displayid-adaptive-sync";
      patch = linuxPtlPatch "0029-drm-edid-populate-monitor-range-from-displayid-adaptive-sync.patch";
    }
  ];

  # Force enable PSR in Intel Xe graphics
  boot.kernelParams = [
    "xe.enable_psr=1"
  ];
}
