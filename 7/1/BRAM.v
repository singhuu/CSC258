module BRAM (KEY,SW,HEX0,HEX2,HEX4,HEX5);
	input [9:0] SW;
	input [0:0] KEY;
	output [6:0] HEX0, HEX2, HEX4, HEX5;
	wire [3:0] q;
	
	ram32x4 ram_one(
		.address(SW[8:4]),
		.clock(~KEY[0]),
		.data(SW[3:0]),
		.wren(SW[9]),
		.q(q)
	);
	
	DECODER one(
		.in(SW[8]),
		.hex_out(HEX5)
		);
	
	DECODER two(
		.in(SW[7:4]),
		.hex_out(HEX4)
		);
	
	DECODER three(
		.in(SW[3:0]),
		.hex_out(HEX2)
		);
		
	DECODER four(
		.in(q),
		.hex_out(HEX0)
		);

endmodule

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