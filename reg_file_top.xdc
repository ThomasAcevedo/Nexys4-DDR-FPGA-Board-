## Clock Signal (100 MHz System Clock)
set_property -dict { PACKAGE_PIN E3    IOSTANDARD LVCMOS33 } [get_ports { clk }];
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports { clk }];

## CPU Reset Button (Asynchronous Active-Low Reset)
set_property -dict { PACKAGE_PIN C12   IOSTANDARD LVCMOS33 } [get_ports { rst }];

## Write Enable Button (BTNL - Left Pushbutton)
set_property -dict { PACKAGE_PIN N17   IOSTANDARD LVCMOS33 } [get_ports { we }];

## Address Input Switches (Switches 15 downto 13)
set_property -dict { PACKAGE_PIN V10   IOSTANDARD LVCMOS33 } [get_ports { addr[2] }]; # SW15
set_property -dict { PACKAGE_PIN U11   IOSTANDARD LVCMOS33 } [get_ports { addr[1] }]; # SW14
set_property -dict { PACKAGE_PIN U12   IOSTANDARD LVCMOS33 } [get_ports { addr[0] }]; # SW13

## Data Input Switches (Switches 3 downto 0)
set_property -dict { PACKAGE_PIN R15   IOSTANDARD LVCMOS33 } [get_ports { din[3] }];  # SW3
set_property -dict { PACKAGE_PIN M13   IOSTANDARD LVCMOS33 } [get_ports { din[2] }];  # SW2
set_property -dict { PACKAGE_PIN L16   IOSTANDARD LVCMOS33 } [get_ports { din[1] }];  # SW1
set_property -dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports { din[0] }];  # SW0

## Data Output LEDs (LEDs 3 downto 0)
set_property -dict { PACKAGE_PIN N14   IOSTANDARD LVCMOS33 } [get_ports { dout[3] }]; # LED3
set_property -dict { PACKAGE_PIN J13   IOSTANDARD LVCMOS33 } [get_ports { dout[2] }]; # LED2
set_property -dict { PACKAGE_PIN K15   IOSTANDARD LVCMOS33 } [get_ports { dout[1] }]; # LED1
set_property -dict { PACKAGE_PIN H17   IOSTANDARD LVCMOS33 } [get_ports { dout[0] }]; # LED0
