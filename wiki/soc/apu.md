# APU

> [!WARNING]  
> The research has gained critical mass, the netlist is verified but not annotated. Signal table is missing. Further research is required.

![locator_apu](/imgstore/soc/locator_apu.jpg)

|![apu](/imgstore/soc/apu.jpg)|![apu_netlist](/imgstore/soc/apu_netlist.png)|
|---|---|

It also contains a piece of arbitration for `a[7:0]`. [^1] 

[^1]: The chip is topologically arranged so that the address bus arbitration is divided into three parts: in [arb](arb.md), in [mmio](mmio.md), and in [apu](apu.md), to equalize wire lengths.

## Signals

![apu_ports](/imgstore/soc/apu_ports.png)

| Signal Name            | Direction | From / Where To             | Description |
|------------------------|-----------|-----------------------------|-------------|
| CONST0                 | Bidir     | Global                      | Constant 0 signal [^2] |
| \[7:0\] a              | Bidir     |                             |  |
| addr_latch             | Input     |                             |  |
| cclk                   | Input     |                             |  |
| clk2                   | Input     |                             |  |
| clk4                   | Input     |                             |  |
| clk6                   | Input     |                             |  |
| clk7                   | Input     |                             |  |
| clk9                   | Input     |                             |  |
| \[7:0\] d              | Bidir     |                             |  |
| \[7:0\] dma_a          | Input     |                             |  |
| dma_addr_ext           | Input     |                             |  |
| ffxx                   | Input     |                             |  |
| lfo_512Hz              | Input     |                             |  |
| \[7:0\] n_INPUT_a      | Input     |                             |  |
| n_ext_addr_en          | Input     |                             |  |
| n_p10                  | Input     |                             |  |
| n_p11                  | Input     |                             |  |
| n_p12                  | Input     |                             |  |
| n_p13                  | Input     |                             |  |
| n_reset2               | Input     |                             |  |
| sck_dir                | Input     |                             |  |
| ser_out                | Input     |                             |  |
| serial_tick            | Input     |                             |  |
| soc_rd                 | Input     |                             |  |
| soc_wr                 | Input     |                             |  |
| test_1                 | Input     |                             |  |
| test_2                 | Input     |                             |  |
| \[7:0\] wave_rd        | Input     |                             |  |
| \[7:0\] DRV_LOW_a      | Output    |                             |  |
| DRV_LOW_p10            | Output    |                             |  |
| DRV_LOW_p11            | Output    |                             |  |
| DRV_LOW_p12            | Output    |                             |  |
| DRV_LOW_p13            | Output    |                             |  |
| DRV_LOW_p14            | Output    |                             |  |
| DRV_LOW_p15            | Output    |                             |  |
| DRV_LOW_sck            | Output    |                             |  |
| DRV_LOW_sin            | Output    |                             |  |
| FF60_D1                | Output    |                             |  |
| \[3:0\] ch1_out        | Output    |                             |  |
| \[3:0\] ch2_out        | Output    |                             |  |
| ch3_active             | Output    |                             |  |
| \[3:0\] ch3_out        | Output    |                             |  |
| \[3:0\] ch4_out        | Output    |                             |  |
| cpu_wakeup             | Output    |                             |  |
| int_jp                 | Output    |                             |  |
| l_vin_en               | Output    |                             |  |
| \[3:0\] lmixer         | Output    |                             |  |
| \[7:0\] n_DRV_HIGH_a   | Output    |                             |  |
| n_DRV_HIGH_p10         | Output    |                             |  |
| n_DRV_HIGH_p11         | Output    |                             |  |
| n_DRV_HIGH_p12         | Output    |                             |  |
| n_DRV_HIGH_p13         | Output    |                             |  |
| n_DRV_HIGH_p14         | Output    |                             |  |
| n_DRV_HIGH_p15         | Output    |                             |  |
| n_DRV_HIGH_sck         | Output    |                             |  |
| n_DRV_HIGH_sin         | Output    |                             |  |
| n_ENA_PU_sin           | Output    |                             |  |
| n_ch1_amp_en           | Output    |                             |  |
| n_ch2_amp_en           | Output    |                             |  |
| n_ch3_amp_en           | Output    |                             |  |
| n_ch4_amp_en           | Output    |                             |  |
| \[2:0\] n_lvolume      | Output    |                             |  |
| \[2:0\] n_rvolume      | Output    |                             |  |
| n_sout_topad           | Output    |                             |  |
| n_wave_rd              | Output    |                             |  |
| n_wave_wr              | Output    |                             |  |
| r_vin_en               | Output    |                             |  |
| \[3:0\] rmixer         | Output    |                             |  |
| \[3:0\] wave_a         | Output    |                             |  |
| wave_bl_pch            | Output    |                             |  |

[^2]: The constant 0 is globally scattered throughout the chip. Each large module with cells has a `const` cell whose output 0 is globally connected between all modules (so the input is marked as Bidir).

## Annotated Design

TBD.

![apu](/HDL/soc/design/apu.png)

## Map

|Row|Cells|
|---|---|
|1|not, dffr, not, not, dffr, dffr, mux, mux, bufif0, nor, mux, not, bufif0, bufif0, not, bufif0, cnt, not, not, mux, not, not3, not, not, not, dffr, not2, not2, not, not2, nor, not3, not, latch, mux, nand, not6, mux, mux, not3, latch, latch, mux, latch, not, not, mux, latch, latch, latch, latch, mux, mux, or4, or, not, dffr, not, or4, not, nand4, not, not, dffr, and, dffr, dffr, dffr, nand5, not, mux, nor6, and, latch, not, and, nand4, and4, not6, not2, nor, and, and, and, and, and, and, nand, and, and, and, and, nor, dffsr, notif0, notif0, notif0, notif0, not2, notif0, notif0, and, nor, and, nor, and, or, not, nor, dffsr, not3, latchr_comp, not3, latchr_comp, latchr_comp, nor, not, not4, not2, latchr_comp, notif0, notif0, notif0, not, notif0, notif0, notif0, notif0, not2, nor, not, notif0, dffr, dffr, not2, not2, notif0, notif0, not2, notif0, notif0, latchr_comp, latchr_comp, notif0, latchr_comp, not2, latchr_comp, notif0, latchr_comp, notif0, and, and|
|2|not, not, not, mux, not, not, not, not2, nor, dffr, not, dffr, not, nand_latch, bufif0, not2, nand, not, not, latchr_comp, latchr_comp, and, not, notif1, cnt, latchr_comp, latchr_comp, notif1, not, notif1, and, mux, and, nor3, and, not6, dffr, not, not, notif1, not, notif1, nand, nor, or3, not, and, bufif0, not, latchr_comp, latchr_comp, nand, dffr, bufif0, nand, nor, and, nand, nor, nand, not6, not, not, nand, not, notif0, not, not, nand, not2, or, nor, not2, nor, not, not, cnt, cnt, not, not3, not, dffr, dffr, not, not6, nand, not, not, latchr_comp, not, or, not, not, or, nand, nand, notif0, nor, not, not, or4, nand, nor, and, not, not, not, nor, nand, not, nand, or, not, const, not3, not, not, notif0, not2, notif0, mux, and, nor, not, not2, nand, mux, dffsr, not3, nand, and, nor, and3, and, nand, nor, dffr, and3, latchr_comp, latchr_comp, latchr_comp, dffr, nand3, dffr, not2, dffr, cnt, nand, not, nand, not, not, not, latchr_comp, latchr_comp, latchr_comp, latchr_comp, latchr_comp, latchr_comp, notif0, notif0, latchr_comp, latchr_comp, latchr_comp, not2, not2, not2, latchr_comp, notif0, and, and|
|3|not, dffr, not, dffr, not, not, not, dffr, nor, not, nand, nor, not2, not, latchr_comp, latchr_comp, muxi, latchr_comp, latchr_comp, muxi, not, not, cnt, not, not, not, nor, nand, not, not, cnt, dffr, nor, cnt, cnt, nor, nand, not3, nor, notif0, not, notif0, dffr, dffrnq_comp, mux, not, nor, nor, not, cnt, not, and, notif0, nor, nor, nor, nor, latchr_comp, nor, not, not, nor, cnt, cnt, not, and, nor3, dffr, not, not, not, nor3, notif0, cnt, not, and, not, notif0, cnt, dffr, cnt, and, nor_latch, dffr, not, and, not, not, not, nand, cnt, not, fa, not, not, not, xor, xor, cnt, and3, cnt, not, cnt, not, not3, not, not, not, dffr, dffr, and3, not, cnt, cnt, not, notif0, not, dffr, notif0, notif0, not, notif0, notif0, notif0, notif0, not, and, and, notif0, notif0, not, not, latchr_comp, latchr_comp, not, and, or, nand5|
|4|nor_latch, not4, nor, not, dffr, nor, dffr, not, cnt, dffr, muxi, cnt, muxi, aon22, and, notif1, not, notif1, and, notif1, not, not2, not2, not2, nand4, and4, nand4, nand4, nand4, nand4, nand4, nand4, nand4, nand4, nand4, not2, nor, nand4, nand4, not2, nand, nor, nor, nand, nor, nor, not, not, nor, nor, not, nor, nor, not, and, and, not, dffrnq_comp, dffr, nor, nand, nor, nor, not, dffrnq_comp, aon2222, not, latchr_comp, nor, not, nor, not, not, nor3, and, not, dffr, not, nor_latch, nand, not2, not, not, nor, not, nor, and, not, nand, nand, latchr_comp, notif0, cnt, nand, or, not, not, notif0, notif0, nand, notif0, and, not2, not, dffsr, cnt, cnt, not, dffr_comp, nand, dffr_comp, dffr_comp, dffr_comp, fa, xor, dffr_comp, dffr_comp, xor, fa, nor, not, not, and, nor3, nor, nor, dffr, not, dffr, dffr, dffr, nor3, nor3, aon2222, dffr, nand, dffr, dffr, dffr, not2, dffr, and, or, not, nor5|
|5|dffr, nor, dffr, dffr, dffr, dffr, dffr, aon222, aon222, cnt, not2, nand, not, latchr_comp, not, not, not, not, cnt, nand4, and4, and, and, and, nand4, nand4, nand4, nand4, nand4, nor, nor, not6, not2, and, nand, aon22, and, aon2222, and, and, nor, nand5, nor5, nand, cnt, and, and, dffrnq_comp, not, dffr, nand, and, nor, nor, and, nand, latchr_comp, or3, dffr, notif0, latchr_comp, latchr_comp, latchr_comp, and, nor, and3, not2, cnt, nor, cnt, not, cnt, nor, not, dffsr, dffsr, nand, not, dffr_comp, fa, dffsr, dffsr, dffr_comp, dffr_comp, nor, and, not3, dffr_comp, nor, nor, nor, nor, not, cnt, not3, dffr, dffr, not2, aon222222, nor3, nor3, nor3, nor3, nor, or, nor_latch, dffr, nor3, nor3, aon2222, and, aon22, or, dffr, aon22, aon22, mux, or|
|6|not, and, dffr, not, nor, notif0, and, notif0, notif0, notif0, notif0, dffr, nor, not, notif0, notif0, notif0, notif0, latchr_comp, latchr_comp, latchr_comp, latchr_comp, latchr_comp, cnt, nor, notif0, or, nor, not, not2, not, not, nand, latchr_comp, cnt, not, aon22, cnt, nor5, latchr_comp, cnt, not, aon22, cnt, not, nand, nor_latch, or3, cnt, nand, cnt, not, cnt, dffr, cnt, not, not, nor3, nor_latch, dffr, notif0, cnt, and, dffr, not, notif0, dffr, and, and, nor, cnt, nor, dffsr, dffr_comp, fa, dffsr, dffsr, not, xor, dffsr, not, dffr, nand_latch, cnt, not3, nor, nand, not, nand, not, not, dffr, mux, latchr_comp, latchr_comp, nor3, or3, not, not2, dffr, aon22, cnt, or3, cnt, cnt, cnt|
|7|nand_latch, nor3, not, nor3, dffr, not, dffr, dffr, not, not, nor_latch, not, latchr_comp, not, nor3, not, dffr, nor, nor, nor, not, not, notif0, cnt, cnt, not, not, cnt, latchr_comp, latchr_comp, latchr_comp, nor, nand4, nor, nor, not, latchr_comp, latchr_comp, not, latchr_comp, latchr_comp, notif0, notif0, notif0, or, and, aon22, notif0, not, or, not, or, not, not, nand, notif0, not, not, not, nor3, not, and, not, and, notif0, cnt, and, nor3, not, cnt, cnt, cnt, not, not, not, latchr_comp, notif0, notif0, not, dffr, nand, nor, notif0, cnt, nand, nor, nor, not, nand, and, nand, not, nand_latch, not, not, not, dffr_comp, dffr_comp, fa, dffr_comp, xor, fa, nand, mux, xor, xor, xor, not, dffsr, nor4, dffr, not, not, not, nor, dffr, not, dffr, nor3, or, and, latchr_comp, not2, latchr_comp, notif0, notif0, notif0, latchr_comp, latchr_comp, latchr_comp, notif0, latchr_comp, nor5, latchr_comp, not2, not, notif0, nor_latch, not, nor, nor, and, dffr|
|8|nor, or, nor, not, and, nor, not, dffr, notif0, dffr, not, or3, nor4, nor, nor, cnt, cnt, notif0, cnt, and, not, notif0, notif0, latchr_comp, latchr_comp, and, nand, not2, notif0, notif0, notif0, latchr_comp, latchr_comp, not, latchr_comp, and3, notif0, notif0, or, notif0, notif0, not, nand, dffr, not, not, not, or, and, dffsr, notif0, notif0, notif0, or, nand, latchr_comp, not2, notif0, dffsr, notif0, nor5, notif0, aon22, cnt, cnt, aon22, cnt, cnt, aon22, cnt, cnt, dffsr, nand5, nor5, fa, not, dffsr, not, dffsr, fa, dffr_comp, nand, xor, nand, nand, dffr_comp, not, dffr_comp, nor, not3, not, nor_latch, nor, not, not, nor, latchr_comp, dffr, not4, dffr, not, nor, notif0, dffr, not2, and, notif0, notif0, or, nand, nor, not, dffr, notif0, or, dffr, xnor, not, and3, dffr|
|9|not, not, cnt, notif0, notif0, nor_latch, latchr_comp, latchr_comp, latchr_comp, notif0, dffr, not, notif0, notif0, notif0, notif0, notif0, latchr_comp, latchr_comp, latchr_comp, cnt, cnt, cnt, nor3, and, not, not, latchr_comp, latchr_comp, not, and, latchr_comp, latchr_comp, not, latchr_comp, dffr, latchr_comp, not, latchr_comp, latchr_comp, notif0, notif0, notif0, nand, not, cnt, latchr_comp, latchr_comp, latchr_comp, latchr_comp, latchr_comp, notif0, or, aon22, not, not, not, dffr, dffr, notif0, cnt, dffsr, cnt, fa, fa, dffr_comp, not, nor, dffr_comp, dffr_comp, or, dffr_comp, dffsr, not, dffsr, dffsr, dffr, dffr, and, and, dffr, dffr, dffr, nand_latch, latchr_comp, latchr_comp, latchr_comp, not, dffr, latchr_comp, nand, cnt, cnt, not, cnt|
|10|cnt, cnt, not, not, not, not, cnt, notif0, cnt, not, cnt, cnt, notif0, not, not, cnt, and3, cnt, notif0, notif0, cnt, cnt, latchr_comp, and, not, not2, not, latchr_comp, not, latchr_comp, not, not, bufif0, not, not, and, not, not, dffr, nor3, not, cnt, not, and3, cnt, not2, muxi, dffr, dffr, dffr, nand, nor, and, nor, nand, dffr, nand, nor, nand, nor, or, notif0, notif0, latch, not, not, notif0, notif0, cnt, dffr, nor, nand, nor, not, nand, nand, nor, nor, dffr, nand, nor, and, dffr_comp, not, or4, nor4, or3, nand, nor, not, nand, nor, xor, not, nor_latch, dffr, nand, nor, nor, not, not, and, not, and, nor, nor, or, latch, notif0, not2, or, not3, latch, notif0, not, not6, latch, notif0, not, dffr, or, not, dffr, not, dffr, dffr, not, aon22, not, notif0, dffr, notif0, not, or, not, nand, notif0, notif0, not, not, notif0|