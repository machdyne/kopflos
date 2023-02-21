blinky_kopflos:
	mkdir -p output
	yosys -q -p "synth_ecp5 -top blinky -json output/blinky_kopflos.json" rtl/blinky_kopflos.v
	nextpnr-ecp5 --12k --package CABGA256 --lpf kopflos_v0.lpf --json output/blinky_kopflos.json --textcfg output/kopflos_blinky_out.config
	ecppack -v --compress --freq 2.4 output/kopflos_blinky_out.config --bit output/kopflos.bit

prog:
	openFPGALoader -c usb-blaster output/kopflos.bit
