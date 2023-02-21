# Kopflos Computer

Kopflos is a headless FPGA computer designed by Lone Dynamics Corporation.

This repo contains schematics, pinouts, a 3D-printable case, example gateware and documentation.

Find more information on the [Kopflos product page](https://machdyne.com/product/kopflos-computer/).

## Programming Kopflos

Kopflos has a JTAG interface and ships with a [DFU bootloader](https://github.com/machdyne/tinydfu-bootloader) that allows the included flash [MMOD](https://machdyne.com/product/mmod) to be programmed over the USB-C port.

### DFU

The DFU bootloader is available for 5 seconds after power-on, issuing a DFU command during this period will stop the boot process until the DFU device is detached. If no command is received the boot process will continue and the user gateware will be loaded.

Install [dfu-util](http://dfu-util.sourceforge.net) (Debian/Ubuntu):

```
$ sudo apt install dfu-util
```

Update the user gateware on the flash MMOD:

```
$ sudo dfu-util -a 0 -D image.bit
```

Detach the DFU device and continue the boot process:

```
$ sudo dfu-util -a 0 -e
```

It is possible to update the bootloader itself using DFU but you shouldn't attempt this unless you have a JTAG programmer (or another method to program the MMOD) available, in case you need to restore the bootloader.

### JTAG

These examples assume you're using a "USB Blaster" JTAG cable, see the header pinout below. You will need to have [openFPGALoader](https://github.com/trabucayre/openFPGALoader) installed.

Program the configuration SRAM:

```
openFPGALoader -c usb-blaster image.bit
```

Program the flash MMOD:

```
openFPGALoader -f -c usb-blaster images/bootloader/tinydfu_kopflos.bit
```

## Blinky 

Building the blinky example requires [Yosys](https://github.com/YosysHQ/yosys), [nextpnr-ecp5](https://github.com/YosysHQ/nextpnr) and [Project Trellis](https://github.com/YosysHQ/prjtrellis).

Assuming they are installed, you can simply type `make` to build the gateware, which will be written to output/blinky.bin. You can then use [openFPGALoader](https://github.com/trabucayre/openFPGALoader) or dfu-util to write the gateware to the device.

## Linux

See the [Kakao Linux](https://github.com/machdyne/kakao) repo for detailed installation instructions.

## JTAG Header

The 3.3V JTAG header can be used to program the FPGA SRAM as well as the MMOD flash memory.

```
2 4 6
1 3 5
```

| Pin | Signal |
| --- | ------ |
| 1 | TCK |
| 2 | TDI |
| 3 | TDO |
| 4 | TMS |
| 5 | 3V3 (out) |
| 6 | GND |

## Board Revisions

| Revision | Notes |
| -------- | ----- |
| V0 | Initial version |
