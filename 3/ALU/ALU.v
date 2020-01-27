module ALU(SWITCH, KEY, LEDR, OUT_0, OUT_1, OUT_2, OUT_3, OUT_4, OUT_5);
	input [7:0] SWITCH;
	input [2:0] KEY;
	
	output [7:0] LEDR;
	output [6:0] OUT_0; // NOTE TO YOURSELF : Displays A
	output [6:0] OUT_1; // Displays B
	output [6:0] OUT_2;
	output [6:0] OUT_3;
	output [6:0] OUT_4;
	output [6:0] OUT_5;
	
	reg [7:0] out;
	
	assign LEDR[7:0] = out[7:0]; // Initializing the two above and assigning them here
	
	wire [4:0] cable1; // The size is bigger (ie. 5 BITS) because it may or may not have to carry the carry-over bit (Just a precaution)
	wire [4:0] cable2;
	wire [4:0] cable3;
	
	// Case 0 : Do A + 1
	Adder4 A4_1(
		.X(SWITCH[7:4]), .Y(4'b0001), .out(cable1)); // Input from X and 1 are combined and sent through cable1
	
	// Case 1 : Do A + B
	Adder4 A4_2(
		.X(SWITCH[7:4]), .Y(SWITCH[3:0]), .out(cable2)); // Input from X and Y are added and sent through cable2
	
	// Case 2 : Do A + B using Verilog + Operator. Creating another Module for this. BRB.
	VerilogPlus caseone(
		.x(SWITCH[7:4]), .y(SWITCH[3:0]), .sum(cable3)); // Similar to Case 1. Input from X and Y is taken and added and sent through cable3
	
	// Rest of the cases have to be taken care with the HEX
	// We are also connecting the wires from Case 0, 1 and 2 to here.
	always @(*)
	begin
		case(KEY[2:0]) // 3 Bit Key that specifies which  we case we are taking
			3'b000: out = {3'b000, cable1[4:0]}; // Case 0
			3'b001: out = {3'b000, cable2[4:0]}; // Case 1
			3'b010: out = {3'b000, cable3[4:0]}; // Case 2
			3'b011: out = {SWITCH[3:0] | SWITCH[7:4], SWITCH[3:0] ^ SWITCH[7:4]}; // A XOR B; Case 3, [3:0] is the first input, [7:4] is the second
			3'b100: out = SWITCH[3:0] | SWITCH[7:4]; // Case 4: A OR B
			3'b101: out = {SWITCH[3:0], SWITCH[7:4]}; // Case 5: Output is the input
			default : out = 8'b11111111; // default error case
		endcase
	end
	// Defining Seven HEX decoder here. BRB creating the module.
	// Code below performs the calculations and displays A and B and Outputs.
	DECODER one(
			.in(SWITCH[3:0]), .hex_out(OUT_0[6:0]));
			
	DECODER two(
			.in(SWITCH[7:4]), .hex_out(OUT_1[6:0]));

	DECODER three(
			.in(4'b0000), .hex_out(OUT_2[6:0]));
		
	DECODER four(
			.in(4'b0000), .hex_out(OUT_3[6:0]));

	DECODER five(
			.in(out[3:0]), .hex_out(OUT_4[6:0]));
		
	DECODER six(
			.in(out[7:4]), .hex_out(OUT_5[6:0]));	
			
endmodule

// Module Same as Part II
module fullAdder4(x, y, c_in, sum, c_out);
	input x, y, c_in;
	output c_out, sum;
	
	assign sum = x ^ y ^ c_in;
	assign c_out = (x & y) | (c_in & (x^y));

endmodule

// Module Same as Part II
module Adder4(X, Y, out);
	input [3:0] X;
	input [3:0] Y;
	output [4:0]out;
	
	wire [2:0] wre;

	fullAdder4 Adder_1(
		.x(X[0]), .y(Y[0]), .c_in(1'b0), .sum(out[0]),.c_out(wre[0])
	);

	fullAdder4 Adder_2(
		.x(X[1]), .y(Y[1]), .c_in(wre[0]), .sum(out[1]), .c_out(wre[1])
	);

	fullAdder4 FA3(
		.x(X[2]), .y(Y[2]), .c_in(wre[1]), .sum(out[2]), .c_out(wre[2])
	);

	fullAdder4 FA4(
		.x(X[3]), .y(Y[3]), .c_in(wre[2]), .sum(out[3]), .c_out(out[4])
	);
endmodule

// Verilog Module for Case 2
module VerilogPlus(x, y, sum);

		// Standard Inputs of 4 BITS
		input [3:0] x;
		input [3:0] y;
		
		// Standard Output of 4 BITS
		output [4:0] sum;
		
		assign sum[4:0] = x + y; // Where the magic happens

endmodule

// Seven HEX Decoder Module Defined here
module DECODER(in, hex_out);
	input [3:0]in;
	output [6:0]hex_out;
	
	// Hoping I typed everthing out correctly
	assign hex_out[0] = (~in[3] & ~in[2] & ~in[1] & in[0])| (in[3] & ~in[2] & in[1] & in[0]) 
	| (~in[3] & in[2] & ~in[1] & ~in[0]) | (in[3] & in[2] & ~in[1] & in[0]);
	
	assign hex_out[1] = (in[3] & in[1] & in[0]) | (in[2] & in[1] & ~in[0]) | 
	(~in[3] & in[2] & ~in[1] & in[0]) | (in[3] & in[2] & ~in[1] & ~in[0]);
	
	assign hex_out[2] = (in[3] & in[2] & ~in[1] & ~in[0])|(in[3] & in[2] & in[1]) 
	| (~in[3] & ~in[2] & in[1] & ~in[0]);
	
	assign hex_out[3] = (~in[2] & ~in[1] & in[0]) | (in[2] & in[1] & in[0]) 
	| (in[3] & ~in[2] & in[1] & ~in[0]);
	
	assign hex_out[4] = (~in[2] & ~in[1] & in[0]) | (~in[3] & in[2] & ~in[1])
	| (~in[3] & in[1] & in[0]);
	
	assign hex_out[5] = (~in[3] & ~in[2] & in[0]) | (in[3] & in[2] & ~in[1] & in[0])
	| (~in[3] & ~in[2] & in[1]) | (~in[3] & in[1] & in[0]);
	
	assign hex_out[6] = (in[3] & in[2] & ~in[1] & ~in[0]) | (~in[3] & ~in[2] & ~in[1])
	| (~in[3] & in[2] & in[1] & in[0]);
		
endmodule
