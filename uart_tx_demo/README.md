# UART Transmitter on DE10-Nano

Parameterized UART TX in Verilog (5-state FSM, 8N1) with a demo that
sends "Hello, DE10!" about every 1.3 s at 115200 baud from the 50 MHz clock.
LEDs show a binary count of messages sent.

- Board: Terasic DE10-Nano (Cyclone V SoC 5CSEBA6U23I7)
- Tools: Quartus Prime Lite 21.1
- Pins: clock PIN_V11, LEDs per the DE10-Nano manual, UART_TX on PIN_V12
  (GPIO_0[0], JP1 header pin 1)

## Hardware setup
3.3 V FTDI USB-serial cable: yellow (RXD) to JP1 pin 1, black (GND) to
JP1 pin 12. Leave other wires unconnected.

## Run
1. Open uart_demo_top.qpf in Quartus and compile.
2. Program output_files/uart_demo_top.sof via Tools > Programmer
   (remove the microSD card so the HPS Linux doesn't overwrite the FPGA).
3. Open a terminal at 115200 8N1: screen /dev/ttyUSB0 115200
