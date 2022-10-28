// Separated from Bottom.v to make it easier to scroll through the source.

module RegsBuses ( CLK5, CLK6, w, x, DL, IR, abus, bbus, cbus, dbus, ebus, fbus, Aout );

	input CLK5;
	input CLK6;
	input [40:0] w;
	input [68:0] x;
	inout [7:0] DL;
	output [7:0] IR;
	inout [7:0] abus;
	inout [7:0] bbus;
	inout [7:0] cbus;
	inout [7:0] dbus;
	inout [7:0] ebus;
	inout [7:0] fbus;
	output [7:0] Aout; 			// Reg A output for bq logic

	// Regs output

	wire [7:0] r1q;		// A
	wire [7:0] r2q;		// L
	wire [7:0] r3q;		// H
	wire [7:0] r4q;		// E
	wire [7:0] r5q;		// D
	wire [7:0] r6q;		// C
	wire [7:0] r7q;		// B

	regbit RegIR [7:0] ( .clk({8{CLK6}}), .cclk({8{CLK5}}), .d(DL), .ld({8{w[26]}}), .q(IR) );

	regbit RegA [7:0] ( .clk({8{CLK6}}), .cclk({8{CLK5}}), .d(fbus), .ld({8{x[38]}}), .q(r1q) );
	regbit RegL [7:0] ( .clk({8{CLK6}}), .cclk({8{CLK5}}), .d(ebus), .ld({8{x[40]}}), .q(r2q) );
	regbit RegH [7:0] ( .clk({8{CLK6}}), .cclk({8{CLK5}}), .d(fbus), .ld({8{x[39]}}), .q(r3q) );
	regbit RegE [7:0] ( .clk({8{CLK6}}), .cclk({8{CLK5}}), .d(ebus), .ld({8{x[50]}}), .q(r4q) );
	regbit RegD [7:0] ( .clk({8{CLK6}}), .cclk({8{CLK5}}), .d(fbus), .ld({8{x[48]}}), .q(r5q) );
	regbit RegC [7:0] ( .clk({8{CLK6}}), .cclk({8{CLK5}}), .d(ebus), .ld({8{x[51]}}), .q(r6q) );
	regbit RegB [7:0] ( .clk({8{CLK6}}), .cclk({8{CLK5}}), .d(fbus), .ld({8{x[49]}}), .q(r7q) );

	assign abus = w[3] ? ~r1q : 8'bzzzzzzzz;
	assign bbus = x[35] ? ~r1q : 8'bzzzzzzzz;
	assign cbus = x[42] ? ~r2q : 8'bzzzzzzzz;
	assign abus = w[15] ? ~r2q : 8'bzzzzzzzz;
	assign bbus = x[44] ? ~r2q : 8'bzzzzzzzz;
	assign abus = w[19] ? ~r3q : 8'bzzzzzzzz;
	assign bbus = x[43] ? ~r3q : 8'bzzzzzzzz;
	assign dbus = x[42] ? ~r3q : 8'bzzzzzzzz;
	assign cbus = x[45] ? ~r4q : 8'bzzzzzzzz;
	assign bbus = x[47] ? ~r4q : 8'bzzzzzzzz;
	assign bbus = x[46] ? ~r5q : 8'bzzzzzzzz;
	assign dbus = x[45] ? ~r5q : 8'bzzzzzzzz;
	assign dbus = w[29] ? 8'b00000000 : 8'bzzzzzzzz;
	assign dbus = w[17] ? 8'b00000000 : 8'bzzzzzzzz;
	assign cbus = x[52] ? ~r6q : 8'bzzzzzzzz;
	assign bbus = x[54] ? ~r6q : 8'bzzzzzzzz;
	assign bbus = x[53] ? ~r7q : 8'bzzzzzzzz;
	assign dbus = x[52] ? ~r7q : 8'bzzzzzzzz;

	assign Aout = r1q;

endmodule // RegsBuses

module TempRegsBuses ( CLK4, CLK5, CLK6, d60, w, x, DL, ebus, fbus, zbus, wbus, Res, adl, adh );

	input CLK4;
	input CLK5;
	input CLK6;
	input d60;
	input [40:0] w;
	input [68:0] x;
	inout [7:0] DL;
	inout [7:0] ebus;
	inout [7:0] fbus;
	inout [7:0] zbus;
	inout [7:0] wbus;
	input [7:0] Res;
	inout [7:0] adl;
	inout [7:0] adh;

	wire [7:0] Z_in;
	wire [7:0] W_in;
	wire d60w8;

	regbit Z [7:0]( .clk({8{CLK6}}), .cclk({8{CLK5}}), .d(Z_in), .ld({8{x[60]}}), .q(zbus) );
	regbit W [7:0]( .clk({8{CLK6}}), .cclk({8{CLK5}}), .d(W_in), .ld({8{x[59]}}), .q(wbus) );

	assign cbus = w[17] ? ~zbus : 8'bzzzzzzzz;
	assign cbus = w[1] ? ~zbus : 8'bzzzzzzzz;
	assign cbus = w[2] ? ~zbus : 8'bzzzzzzzz;
	assign bbus = x[58] ? ~zbus : 8'bzzzzzzzz;
	assign dbus = w[2] ? ~wbus : 8'bzzzzzzzz;
	assign dbus = w[1] ? ~wbus : 8'bzzzzzzzz;

	assign fbus = ~(CLK4 ? ~(({8{x[55]}}&adh) | ({8{x[56]}}&wbus) | ({8{x[57]}}&Res)) : 8'b11111111);
	assign ebus = ~(CLK4 ? ~(({8{x[55]}}&adl) | ({8{x[56]}}&zbus) | ({8{x[57]}}&Res)) : 8'b11111111);

	assign d60w8 = ~(d60 | w[8]);
	assign Z_in = ~(({8{d60}}&adl) | ({8{~d60}}&DL));
	assign W_in = ~(({8{~d60w8}}&adh) | ({8{d60w8}}&DL));

endmodule // TempRegsBuses

module SP ( CLK5, CLK6, CLK7, IR4, IR5, d60, d66, w, x, DL, abus, bbus, cbus, dbus, zbus, wbus, adl, adh );

	input CLK5;
	input CLK6;
	input CLK7;
	input IR4;
	input IR5;
	input d60;
	input d66;
	input [40:0] w;
	input [68:0] x;
	inout [7:0] DL;			// Internal databus
	inout [7:0] abus;
	inout [7:0] bbus;
	inout [7:0] cbus;
	inout [7:0] dbus;
	inout [7:0] zbus;
	inout [7:0] wbus;
	inout [7:0] adl;
	inout [7:0] adh;

	wire [7:0] spl_d;		// SPL input
	wire [7:0] spl_q;		// SPL output
	wire [7:0] spl_nq;		// SPL output (complement)
	wire [7:0] sph_d;		// SPH input
	wire [7:0] sph_q;		// SPH output 
	wire [7:0] sph_nq;		// SPH output (complement)

	regbit SPL [7:0] ( .clk({8{CLK6}}), .cclk({8{CLK5}}), .d(spl_d), .ld({8{x[61]}}), .q(spl_q), .nq(spl_nq) );
	regbit SPH [7:0] ( .clk({8{CLK6}}), .cclk({8{CLK5}}), .d(sph_d), .ld({8{x[61]}}), .q(sph_q), .nq(sph_nq) );

	// SP vs Buses

	assign spl_d = CLK6 ? (~((adl & {8{x[62]}}) | (zbus & {8{x[63]}}))) : (CLK7 ? 8'bzzzzzzzz : 8'b11111111);
	assign sph_d = CLK6 ? (~((adh & {8{x[62]}}) | (wbus & {8{x[63]}}))) : (CLK7 ? 8'bzzzzzzzz : 8'b11111111);

	assign DL = d60 ? ~spl_q : 8'bzzzzzzzz;
	assign abus = w[23] ? ~spl_nq : 8'bzzzzzzzz;
	assign bbus = (w[15] & IR4 & IR5) ? ~spl_nq : 8'bzzzzzzzz;
	assign cbus = x[65] ? ~spl_nq : 8'bzzzzzzzz;

	assign DL = d66 ? ~sph_q : 8'bzzzzzzzz;
	assign abus = w[9] ? ~sph_nq : 8'bzzzzzzzz;
	assign bbus = (w[19] & IR4 & IR5) ? ~sph_nq : 8'bzzzzzzzz;
	assign dbus = x[65] ? ~sph_nq : 8'bzzzzzzzz;

endmodule // SP

module PC ( CLK5, CLK6, CLK7, d92,
	load_pc,
	idu_to_pc,
	zwbus_to_pc,
	pcl_to_databus,
	pch_to_databus,
	pc_to_cdbus,
	pc_to_adbus,
	zero_to_abus,
	DL, abus, cbus, dbus, zbus, wbus, adl, adh, IR, bro );

	input CLK5;
	input CLK6;
	input CLK7;
	input d92;
	input load_pc; 			// x68
	input idu_to_pc; 		// x67
	input zwbus_to_pc; 		// w36
	input pcl_to_databus;	// w34
	input pch_to_databus; 	// w28
	input pc_to_cdbus; 		// w25
	input pc_to_adbus; 		// w8
	input zero_to_abus;		// x33
	inout [7:0] DL;			// Internal databus
	inout [7:0] abus;
	inout [7:0] cbus;
	inout [7:0] dbus;
	inout [7:0] zbus;
	inout [7:0] wbus;
	inout [7:0] adl;
	inout [7:0] adh;
	input [7:0] IR;			// Current opcode
	input [7:3] bro;		// Interrupt address

	wire [7:0] pcl_d;		// PCL input
	wire [7:0] pcl_q;		// PCL output
	wire [7:0] pcl_nq;		// PCL output (complement)
	wire [7:0] pch_d;		// PCH input
	wire [7:0] pch_q;		// PCH output
	wire [7:0] pch_nq;		// PCH output (complement)

	regbit PCL [7:0] ( .clk({8{CLK6}}), .cclk({8{CLK5}}), .d(pcl_d), .ld({8{load_pc}}), .q(pcl_q), .nq(pcl_nq) );
	regbit PCH [7:0] ( .clk({8{CLK6}}), .cclk({8{CLK5}}), .d(pch_d), .ld({8{load_pc}}), .q(pch_q), .nq(pch_nq) );

	// PC vs Buses

	assign pcl_d[2:0] = CLK6 ? (~((adl[2:0] & {3{idu_to_pc}}) | (zbus[2:0] & {3{zwbus_to_pc}}))) : (CLK7 ? 3'bzzz : 3'b111);
	assign pcl_d[5:3] = CLK6 ? (~((adl[5:3] & {3{idu_to_pc}}) | (zbus[5:3] & {3{zwbus_to_pc}}) | ({3{d92}} & IR[5:3]) | bro[5:3])) : (CLK7 ? 3'bzzz : 3'b111);
	assign pcl_d[7:6] = CLK6 ? (~((adl[7:6] & {2{idu_to_pc}}) | (zbus[7:6] & {2{zwbus_to_pc}}) | bro[7:6])) : (CLK7 ? 2'bzz : 2'b11);
	assign pch_d = CLK6 ? (~((adh & {8{idu_to_pc}}) | (wbus & {8{zwbus_to_pc}}))) : (CLK7 ? 8'bzzzzzzzz : 8'b11111111);

	assign DL = pcl_to_databus ? ~pcl_q : 8'bzzzzzzzz;
	assign cbus = pc_to_cdbus ? ~pcl_nq : 8'bzzzzzzzz;
	assign abus = pc_to_adbus ? ~pcl_nq : 8'bzzzzzzzz;
	assign abus = zero_to_abus ? 8'b00000000 : 8'bzzzzzzzz;

	assign DL = pch_to_databus ? ~pch_q : 8'bzzzzzzzz;
	assign dbus = pc_to_cdbus ? ~pch_nq : 8'bzzzzzzzz;
	assign dbus = pc_to_adbus ? ~pch_nq : 8'bzzzzzzzz;

endmodule // PC

module regbit ( clk, cclk, d, ld, q, nq );

	input clk;
	input cclk;
	input d;
	input ld;
	output q;
	output nq;

	// Latch with complementary set enable, complementary CLK.

	reg val_in;
	reg val_out;
	initial val_in <= 1'bx;
	initial val_out <= 1'bx;

	always @(*) begin
		if (clk && ld)
			val_in <= d;
	end

	always @(negedge ld) begin
		val_out <= val_in;
	end

	assign q = val_out;
	assign nq = ~q;

endmodule // regbit

module regbit_res ( clk, cclk, d, ld, res, q, nq );

	input clk;
	input cclk;
	input d;
	input ld;
	input res;
	output q;
	output nq;

	// Latch with complementary set enable, complementary CLK, active-high reset

	reg val_in;
	reg val_out;
	initial val_in <= 1'bx;
	initial val_out <= 1'bx;

	always @(*) begin
		if (clk && ld)
			val_in <= d;
		if (res)
			val_in <= 1'b0;
	end

	always @(negedge ld) begin
		val_out <= val_in;
	end

	assign q = val_out;
	assign nq = ~q;

endmodule // regbit_res