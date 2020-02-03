// DISCLAIMER: A lot of the code is taken from ALU.v 

module ALU_REG(SWITCH, KEY, LEDR, OUT_0, OUT_4, OUT_5);
	input [9:0] SWITCH;
	input [3:0] KEY;
	
	output [7:0] LEDR;
	output [6:0] OUT_0; // NOTE TO YOURSELF : Displays A
	output [6:0] OUT_4;
	output [6:0] OUT_5;
	
	wire [4:0] cable1; // The size is bigger (ie. 5 BITS) because it may or may not have to carry the carry-over bit (Just a precaution)
	wire [4:0] cable2;
	wire [4:0] cable3;
	wire [7:0] out_of_ALU; // Stores the output of the ALU
	wire [7:0] out_of_REG; // Stores the Register output
	
	reg [7:0] out;
	reg [3:0] a, b; //Temporary output variables, 4 bits each, will combine to make 8 bit output
	reg [7:0] out_0, out_1, out_5, out_6, out_7; 
	
	assign LEDR[7:0] = out_of_ALU[7:0]; // Initializing the two above and assigning them here

	// Case 0 : Do A + 1
	Adder4 A4_1(
		.X(SWITCH[7:4]), .Y(4'b0001), .out(cable1)); // Input from X and 1 are combined and sent through cable1
	
	// Case 1 : Do A + B
	Adder4 A4_2(
		.X(SWITCH[7:4]), .Y(SWITCH[3:0]), .out(cable2)); // Input from X and Y are added and sent through cable2
	
	// Case 2 : Do A + B using Verilog + Operator. Creating another Module for this. BRB.
	VerilogPlus caseone(
		.x(SWITCH[7:4]), .y(SWITCH[3:0]), .sum(cable3)); // Similar to Case 1. Input from X and Y is taken and added and sent through cable3
	
	always @(*)
	begin
		case (SWITCH[7:5])
	// NOTE: This weird method is done because the instructions state an 8 BIT Output
			3'b000: 
			begin // Case 0: Performs A+1. 
				out_0 = SWITCH[3:0] + 4'b0001;
				// Stores the output in a. Allocating 0 to b because this takes only 1 value
				a = out_0[7:4];
				b = 4'b0000;
			end			
			3'b001:
			begin // Case 1: Performs A + B 
				out_1 = SWITCH[3:0] + out_of_REG[3:0];
				a = out_1[7:4];
				b = out_1[3:0];
			end		
			3'b010: 
			begin // Case 2: Performs A+B using + in Verilog
				out_1 = SWITCH[3:0] + out_of_REG[3:0];
				a = out_1[7:4];
				b = out_1[3:0];
			end	
			3'b011: 
			begin // Case 3: A XOR B in the lower 4 bits | A OR B in the upper four bits
				b = SWITCH[3:0] ^ out_of_REG[3:0];
				a = SWITCH[3:0] | out_of_REG[3:0];
			end	
			3'b100: 
			begin //Case 4: Output is the input
				a = 4'b0000;
				b = {3'b000,| {SWITCH[3:0], out_of_REG[3:0]}};
			end	
			3'b101: 
			begin //Case 5 : Left Shift b by a bits
				out_5 = out_of_REG[3:0] << SWITCH[3:0];
				a = out_5[7:4];
				b = out_5[3:0];			
			end		
			3'b110: 
			begin //Case 6 : Right Shift B by A bits
				out_6 = (out_of_REG[3:0] >> SWITCH[3:0]);
				a = out_6[7:4];
				b = out_6[3:0];
			end		
			3'b111: 
			begin //Case 7 : Multlplier using * operator
				out_7[7:0] = (SWITCH[3:0] * out_of_REG[3:0]);
				a = out_7[7:4];
				b = out_7[3:0];
			end
			default: 
			begin
				a = 4'b0000; 
				b = 4'b0000;
			end
		endcase
	end
	
	// Combining the a and b outputs in a single 8Bit output
	assign out_of_ALU[7:0] = {a[3:0], b[3:0]};
	// Create a register object. This a new Addition to this code
	D_Flip_Flop d0(.d(out_of_ALU[7:0]), .CLK(KEY[0]), .reset(SWITCH[9]), .q(out_of_REG[7:0]));
	
	// Defining Seven HEX decoder here. BRB creating the module.
	// Code below performs the calculations and displays A and B and Outputs.
	DECODER one(
			.in(SWITCH[3:0]), .hex_out(OUT_0[6:0]));

	DECODER five(
			.in(out_of_REG[3:0]), .hex_out(OUT_4[6:0]));
		
	DECODER six(
			.in(out_of_REG[7:4]), .hex_out(OUT_5[6:0]));	
			
endmodule

// Flip Flock Module that emulates a D Flip Flop Regsiter
module D_Flip_Flop(d, CLK, reset, q);
	input [7:0] d;
	input CLK;
	input reset;
	
	output [7:0] q;
	
	reg [7:0] q;
	
	always @(posedge CLK)
	begin
		if (reset == 1'b0)
			q <= 8'd0;
		else
			q <= d;
	end
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
