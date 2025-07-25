{ config, pkgs, ... }:

{
  services.udev.extraHwdb = ''
    ACTION!="add|change", GOTO="openocd_rules_end"

    SUBSYSTEM=="gpio", MODE="0660", GROUP="plugdev", TAG+="uaccess"

    SUBSYSTEM!="usb|tty|hidraw", GOTO="openocd_rules_end"

    # Please keep this list sorted by VID:PID

    # opendous and estick
    ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="204f", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # Original FT232/FT245 VID:PID
    ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6001", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # Original FT2232 VID:PID
    ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6010", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # Original FT4232 VID:PID
    ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6011", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # Original FT232H VID:PID
    ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6014", MODE="660", GROUP="plugdev", TAG+="uaccess"
    # Original FT231XQ VID:PID
    ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6015", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # DISTORTEC JTAG-lock-pick Tiny 2
    ATTRS{idVendor}=="0403", ATTRS{idProduct}=="8220", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # TUMPA, TUMPA Lite
    ATTRS{idVendor}=="0403", ATTRS{idProduct}=="8a98", MODE="660", GROUP="plugdev", TAG+="uaccess"
    ATTRS{idVendor}=="0403", ATTRS{idProduct}=="8a99", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # Marvell OpenRD JTAGKey FT2232D B
    ATTRS{idVendor}=="0403", ATTRS{idProduct}=="9e90", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # XDS100v2
    ATTRS{idVendor}=="0403", ATTRS{idProduct}=="a6d0", MODE="660", GROUP="plugdev", TAG+="uaccess"
    # XDS100v3
    ATTRS{idVendor}=="0403", ATTRS{idProduct}=="a6d1", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # OOCDLink
    ATTRS{idVendor}=="0403", ATTRS{idProduct}=="baf8", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # Kristech KT-Link
    ATTRS{idVendor}=="0403", ATTRS{idProduct}=="bbe2", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # Xverve Signalyzer Tool (DT-USB-ST), Signalyzer LITE (DT-USB-SLITE)
    ATTRS{idVendor}=="0403", ATTRS{idProduct}=="bca0", MODE="660", GROUP="plugdev", TAG+="uaccess"
    ATTRS{idVendor}=="0403", ATTRS{idProduct}=="bca1", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # TI/Luminary Stellaris Evaluation Board FTDI (several)
    ATTRS{idVendor}=="0403", ATTRS{idProduct}=="bcd9", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # TI/Luminary Stellaris In-Circuit Debug Interface FTDI (ICDI) Board
    ATTRS{idVendor}=="0403", ATTRS{idProduct}=="bcda", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # egnite Turtelizer 2
    ATTRS{idVendor}=="0403", ATTRS{idProduct}=="bdc8", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # Section5 ICEbear
    ATTRS{idVendor}=="0403", ATTRS{idProduct}=="c140", MODE="660", GROUP="plugdev", TAG+="uaccess"
    ATTRS{idVendor}=="0403", ATTRS{idProduct}=="c141", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # Amontec JTAGkey and JTAGkey-tiny
    ATTRS{idVendor}=="0403", ATTRS{idProduct}=="cff8", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # ASIX Presto programmer
    ATTRS{idVendor}=="0403", ATTRS{idProduct}=="f1a0", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # Nuvoton NuLink
    ATTRS{idVendor}=="0416", ATTRS{idProduct}=="511b", MODE="660", GROUP="plugdev", TAG+="uaccess"
    ATTRS{idVendor}=="0416", ATTRS{idProduct}=="511c", MODE="660", GROUP="plugdev", TAG+="uaccess"
    ATTRS{idVendor}=="0416", ATTRS{idProduct}=="511d", MODE="660", GROUP="plugdev", TAG+="uaccess"
    ATTRS{idVendor}=="0416", ATTRS{idProduct}=="5200", MODE="660", GROUP="plugdev", TAG+="uaccess"
    ATTRS{idVendor}=="0416", ATTRS{idProduct}=="5201", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # TI ICDI
    ATTRS{idVendor}=="0451", ATTRS{idProduct}=="c32a", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # STMicroelectronics ST-LINK V1
    ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3744", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # STMicroelectronics ST-LINK/V2
    ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3748", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # STMicroelectronics ST-LINK/V2.1
    ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374b", MODE="660", GROUP="plugdev", TAG+="uaccess"
    ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3752", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # STMicroelectronics STLINK-V3
    ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374d", MODE="660", GROUP="plugdev", TAG+="uaccess"
    ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374e", MODE="660", GROUP="plugdev", TAG+="uaccess"
    ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374f", MODE="660", GROUP="plugdev", TAG+="uaccess"
    ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3753", MODE="660", GROUP="plugdev", TAG+="uaccess"
    ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3754", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # Cypress SuperSpeed Explorer Kit
    ATTRS{idVendor}=="04b4", ATTRS{idProduct}=="0007", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # Cypress KitProg in KitProg mode
    ATTRS{idVendor}=="04b4", ATTRS{idProduct}=="f139", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # Cypress KitProg in CMSIS-DAP mode
    ATTRS{idVendor}=="04b4", ATTRS{idProduct}=="f138", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # Infineon DAP miniWiggler v3
    ATTRS{idVendor}=="058b", ATTRS{idProduct}=="0043", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # Hitex LPC1768-Stick
    ATTRS{idVendor}=="0640", ATTRS{idProduct}=="0026", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # Hilscher NXHX Boards
    ATTRS{idVendor}=="0640", ATTRS{idProduct}=="0028", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # Hitex STR9-comStick
    ATTRS{idVendor}=="0640", ATTRS{idProduct}=="002c", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # Hitex STM32-PerformanceStick
    ATTRS{idVendor}=="0640", ATTRS{idProduct}=="002d", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # Hitex Cortino
    ATTRS{idVendor}=="0640", ATTRS{idProduct}=="0032", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # Altera USB Blaster
    ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6001", MODE="660", GROUP="plugdev", TAG+="uaccess"
    # Altera USB Blaster2
    ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6010", MODE="660", GROUP="plugdev", TAG+="uaccess"
    ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6810", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # Ashling Opella-LD
    ATTRS{idVendor}=="0B6B", ATTRS{idProduct}=="0040", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # Amontec JTAGkey-HiSpeed
    ATTRS{idVendor}=="0fbb", ATTRS{idProduct}=="1000", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # SEGGER J-Link
    ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0101", MODE="660", GROUP="plugdev", TAG+="uaccess"
    ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0102", MODE="660", GROUP="plugdev", TAG+="uaccess"
    ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0103", MODE="660", GROUP="plugdev", TAG+="uaccess"
    ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0104", MODE="660", GROUP="plugdev", TAG+="uaccess"
    ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0105", MODE="660", GROUP="plugdev", TAG+="uaccess"
    ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0107", MODE="660", GROUP="plugdev", TAG+="uaccess"
    ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0108", MODE="660", GROUP="plugdev", TAG+="uaccess"
    ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1010", MODE="660", GROUP="plugdev", TAG+="uaccess"
    ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1011", MODE="660", GROUP="plugdev", TAG+="uaccess"
    ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1012", MODE="660", GROUP="plugdev", TAG+="uaccess"
    ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1013", MODE="660", GROUP="plugdev", TAG+="uaccess"
    ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1014", MODE="660", GROUP="plugdev", TAG+="uaccess"
    ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1015", MODE="660", GROUP="plugdev", TAG+="uaccess"
    ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1016", MODE="660", GROUP="plugdev", TAG+="uaccess"
    ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1017", MODE="660", GROUP="plugdev", TAG+="uaccess"
    ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1018", MODE="660", GROUP="plugdev", TAG+="uaccess"
    ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1020", MODE="660", GROUP="plugdev", TAG+="uaccess"
    ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1051", MODE="660", GROUP="plugdev", TAG+="uaccess"
    ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1055", MODE="660", GROUP="plugdev", TAG+="uaccess"
    ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1061", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # Raisonance RLink
    ATTRS{idVendor}=="138e", ATTRS{idProduct}=="9000", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # Debug Board for Neo1973
    ATTRS{idVendor}=="1457", ATTRS{idProduct}=="5118", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # OSBDM
    ATTRS{idVendor}=="15a2", ATTRS{idProduct}=="0042", MODE="660", GROUP="plugdev", TAG+="uaccess"
    ATTRS{idVendor}=="15a2", ATTRS{idProduct}=="0058", MODE="660", GROUP="plugdev", TAG+="uaccess"
    ATTRS{idVendor}=="15a2", ATTRS{idProduct}=="005e", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # Olimex ARM-USB-OCD
    ATTRS{idVendor}=="15ba", ATTRS{idProduct}=="0003", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # Olimex ARM-USB-OCD-TINY
    ATTRS{idVendor}=="15ba", ATTRS{idProduct}=="0004", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # Olimex ARM-JTAG-EW
    ATTRS{idVendor}=="15ba", ATTRS{idProduct}=="001e", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # Olimex ARM-USB-OCD-TINY-H
    ATTRS{idVendor}=="15ba", ATTRS{idProduct}=="002a", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # Olimex ARM-USB-OCD-H
    ATTRS{idVendor}=="15ba", ATTRS{idProduct}=="002b", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # ixo-usb-jtag - Emulation of a Altera Bus Blaster I on a Cypress FX2 IC
    ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="06ad", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # USBprog with OpenOCD firmware
    ATTRS{idVendor}=="1781", ATTRS{idProduct}=="0c63", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # TI/Luminary Stellaris In-Circuit Debug Interface (ICDI) Board
    ATTRS{idVendor}=="1cbe", ATTRS{idProduct}=="00fd", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # TI XDS110 Debug Probe (Launchpads and Standalone)
    ATTRS{idVendor}=="0451", ATTRS{idProduct}=="bef3", MODE="660", GROUP="plugdev", TAG+="uaccess"
    ATTRS{idVendor}=="0451", ATTRS{idProduct}=="bef4", MODE="660", GROUP="plugdev", TAG+="uaccess"
    ATTRS{idVendor}=="1cbe", ATTRS{idProduct}=="02a5", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # TI Tiva-based ICDI and XDS110 probes in DFU mode
    ATTRS{idVendor}=="1cbe", ATTRS{idProduct}=="00ff", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # isodebug v1
    ATTRS{idVendor}=="22b7", ATTRS{idProduct}=="150d", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # PLS USB/JTAG Adapter for SPC5xxx
    ATTRS{idVendor}=="263d", ATTRS{idProduct}=="4001", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # Numato Mimas A7 - Artix 7 FPGA Board
    ATTRS{idVendor}=="2a19", ATTRS{idProduct}=="1009", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # Ambiq Micro EVK and Debug boards.
    ATTRS{idVendor}=="2aec", ATTRS{idProduct}=="6010", MODE="660", GROUP="plugdev", TAG+="uaccess"
    ATTRS{idVendor}=="2aec", ATTRS{idProduct}=="6011", MODE="660", GROUP="plugdev", TAG+="uaccess"
    ATTRS{idVendor}=="2aec", ATTRS{idProduct}=="1106", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # Espressif USB JTAG/serial debug units
    ATTRS{idVendor}=="303a", ATTRS{idProduct}=="1001", MODE="660", GROUP="plugdev", TAG+="uaccess"
    ATTRS{idVendor}=="303a", ATTRS{idProduct}=="1002", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # Marvell Sheevaplug
    ATTRS{idVendor}=="9e88", ATTRS{idProduct}=="9e8f", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # Keil Software, Inc. ULink
    ATTRS{idVendor}=="c251", ATTRS{idProduct}=="2710", MODE="660", GROUP="plugdev", TAG+="uaccess"
    ATTRS{idVendor}=="c251", ATTRS{idProduct}=="2750", MODE="660", GROUP="plugdev", TAG+="uaccess"

    # CMSIS-DAP compatible adapters
    ATTRS{product}=="*CMSIS-DAP*", MODE="660", GROUP="plugdev", TAG+="uaccess"

    LABEL="openocd_rules_end"
  '';
}
