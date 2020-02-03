module SHIFT_REG(SWITCH, KEY, LEDR);
	input [3:0] KEY;
	input [9:0] SWITCH;
	
	output [7:0] LEDR;
	
	wire cable_ASR;
	wire [7:0] cable;
	
	Arith_Shifter a0(.asr(KEY[3]), .first(SWITCH[7]), .m(cable_ASR));
	shifterBit s0(
		.in(cable_ASR), .shift(KEY[2]), .in_val(SWITCH[7]), .in_n(KEY[1]), .clock(KEY[0]), .reset(SWITCH[9]), .out(cable[7])
			);
	shifterBit s1(
		.in(cable[7]), .shift(KEY[2]), .in_val(SWITCH[6]), .in_n(KEY[1]), .clock(KEY[0]), .reset(SWITCH[9]), .out(cable[6])
			);
	shifterBit s2(
		.in(cable[6]), .shift(KEY[2]), .in_val(SWITCH[5]), .in_n(KEY[1]), .clock(KEY[0]), .reset(SWITCH[9]), .out(cable[5])
			);
	shifterBit s3(
		.in(cable[5]), .shift(KEY[2]), .in_val(SWITCH[4]), .in_n(KEY[1]), .clock(KEY[0]), .reset(SWITCH[9]), .out(cable[4])
			);
	shifterBit s4(
		.in(cable[4]), .shift(KEY[2]), .in_val(SWITCH[3]), .in_n(KEY[1]), .clock(KEY[0]), .reset(SWITCH[9]), .out(cable[3])
			);
	shifterBit s5(
		.in(cable[3]), .shift(KEY[2]), .in_val(SWITCH[2]), .in_n(KEY[1]), .clock(KEY[0]), .reset(SWITCH[9]), .out(cable[2])
			);
	shifterBit s6(
		.in(cable[2]), .shift(KEY[2]), .in_val(SWITCH[1]), .in_n(KEY[1]), .clock(KEY[0]), .reset(SWITCH[9]), .out(cable[1])
			);
	shifterBit s7(
		.in(cable[1]), .shift(KEY[2]), .in_val(SWITCH[0]), .in_n(KEY[1]), .clock(KEY[0]), .reset(SWITCH[9]), .out(cable[0])
			);
	
	assign LEDR[7:0] = cable[7:0];
endmodule

module Arith_Shifter(asr, first, m);
	input asr, first;
	output m;
	
	reg m;
	always @(*)
	begin
		if(asr == 1'b1)
			m <= first;
		else
			m <= 1'b0;
	end
endmodule

module shifterBit(in, shift, in_val, in_n, clock, reset, out);
	input in, shift, in_val, in_n, clock, reset;
	output out;
	wire cable_out, cable0, cable1;
	assign cable_out = out;
	FlipFlop f0(.d(cable1), .CLK(clock), .reset(reset), .q(out));
	mux2to1 m1(.x(cable_out), .y(in), .s(shift), .m(cable0));
	mux2to1 m2(.x(in_val), .y(cable0), .s(in_n), .m(cable1));
endmodule

// Taken from Part II of this lab with some minor changes
module FlipFlop(d, CLK, reset, q);
	input [7:0] d;
	input CLK;
	input reset;
	
	output [7:0] q;
	
	reg [7:0] q;
	
	always @(posedge CLK)
	begin
		if (reset == 1'b0)
			q <= 1'd0;
		else
			q <= d;
	end
endmodule
// Code Taken from Lab 2 Part I
module mux2to1(x, y, s, m);
    input x; //selected when s is 0
    input y; //selected when s is 1
    input s; //select signal
    output m; //output
  
    assign m = s & y | ~s & x;
    // OR
    // assign m = s ? y : x;

endmodule