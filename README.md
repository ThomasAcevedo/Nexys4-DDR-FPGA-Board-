# Lab 2: 8 × 4 Register File (Nexys 4 DDR)

## Project files

- `reg_module.vhd`: parameterized n-bit register with rising-edge writes and asynchronous active-low reset.
- `decoder_3to8.vhd`: enabled one-hot write decoder.
- `mux_8to1.vhd`: combinational 8-to-1 read multiplexer, n bits wide.
- `reg_file.vhd`: top-level 8-register, 4-bit register file.
- `tb_reg_file.vhd`: self-checking simulation testbench. It uses the values supplied in `sim.txt` and checks each register after initial reset, after writing/reading, and after reset is asserted again.
- `reg_file_top.xdc`: Nexys 4 DDR FPGA pin assignments and the 100 MHz E3 input clock constraint.

The decoder's `110` case selects output bit 6. The write-enable port is assigned to BTNL (P17), matching the lab handout. The CPU reset is active low, so pressing it asserts reset.

## Vivado: create and simulate the project

1. Launch Vivado and choose **Create Project**. Give the project a name and location, select **RTL Project**, and leave **Do not specify sources at this time** unchecked.
2. Add the four design files as **Design Sources**: `reg_module.vhd`, `decoder_3to8.vhd`, `mux_8to1.vhd`, and `reg_file.vhd`.
3. Add `reg_file_top.xdc` under **Constraints**.
4. Add `tb_reg_file.vhd` as a **Simulation Source** (choose **Add or create simulation sources** in the wizard). Finish the wizard.
5. In **Sources**, expand **Simulation Sources**, right-click `tb_reg_file`, and choose **Set as Top**. If Vivado asks to refresh compile order, allow it.
6. Select **Run Simulation → Run Behavioral Simulation**. The testbench runs automatically. Check the Tcl console for `All register-file checks passed.` and check that no assertion reports an error. In the waveform, `addr` selects which register is shown on `dout`.

## Vivado: build and program the board

1. In **Sources → Hierarchy**, right-click `reg_file` and choose **Set as Top**. Do not use `tb_reg_file` as the synthesis top.
2. In **Project Settings → General**, confirm the selected part is the Nexys 4 DDR FPGA (`xc7a100tcsg324-1`) or select the **Nexys 4 DDR** board if the board is available in Vivado.
3. Confirm `reg_file_top.xdc` is enabled under **Constraints**. Its `create_clock` line constrains `clk` on E3 to a 10 ns period (100 MHz). Keep this input-clock constraint; there is no Z signal or Z-clock output in this lab.
4. Click **Run Synthesis** and wait for it to finish. Click **Run Implementation** and wait for it to finish. Click **Generate Bitstream**.
5. Connect and power the Nexys 4 DDR board over USB. In Vivado, choose **Open Hardware Manager → Open Target → Auto Connect**.
6. Select **Program Device**, choose the generated `.bit` file if Vivado does not select it automatically, and click **Program**.

## Board demonstration

1. Press and hold **CPU RESET** to clear all eight registers, then release it. The reset is asynchronous and active low.
2. Set switches **15–13** to select an address from 0 through 7. Set switches **3–0** to the 4-bit data value you want to store.
3. Press **BTNL** briefly to write. The 100 MHz clock writes the selected register on a rising edge while BTNL is held. Release BTNL after the write.
4. The selected register's contents appear on **LEDs 3–0**. Change address switches 15–13 to inspect other registers.
5. Press CPU RESET again and verify the selected register reads as `0000`; move through all eight addresses to demonstrate that they were cleared.

The handout says not to collect timing results for this lab. Synthesis and implementation are still needed to produce a bitstream for the board demo.
