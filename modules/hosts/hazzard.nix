{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware/hazzard.nix
      ./options/tpkbd.nix
      ./options/zephyr-sdk-openocd-udev-rules.nix
    ];

  networking.hostName = "hazzard";

  environment.systemPackages = with pkgs; [
    google-chrome
    libreoffice-qt
    pandoc
    zola
    antora
    asciidoctor
  ];

  services.printing.drivers = with pkgs; [
    epson-escpr2
  ];

  hardware.printers = {
    ensurePrinters = [
      {
        name = "PX-S6710T_Main_Printer";
        location = "Office";
        deviceUri = "https://10.30.0.101:631/ipp/print";
        model = "epson-inkjet-printer-escpr2/Epson-PX-S6710T_Series-epson-escpr2-en.ppd";
        ppdOptions = {
          PageSize = "A4";
        };
      }
      {
        name = "PX-M5080F_Sub_Printer";
        location = "Office";
        deviceUri = "https://10.30.0.100:631/ipp/print";
        model = "epson-inkjet-printer-escpr2/Epson-PX-M5080F_Series-epson-escpr2-en.ppd";
        ppdOptions = {
          PageSize = "A4";
        };
      }
    ];
    ensureDefaultPrinter = "PX-S6710T_Main_Printer";
  };
}
