module counter(SW, KEY, HEX0, HEX1, out);
	input [1:0]SW; //Will only use SW[0] as clear_b, SW[1] as enable
	input [0:0]KEY; //Will only use KEY[0] as clock

	wire [7:0] cable; // Transmitting between counters
	wire [3:0]l_b, h_b; //The most and least significant bits
	
	output [6:0]HEX0, HEX1;
	output [7:0] out;
	
	
	tFlip zero(.T(SW[1]), .clock(KEY[0]), .clear_b(SW[0]), .Q(out[0]));
	assign cable[0] = SW[1] & out[0];
	
	tFlip one(.T(cable[0]), .clock(KEY[0]), .clear_b(SW[0]), .Q(out[1]));
	assign cable[1] = cable[0] & out[1];
	
	tFlip two(.T(cable[1]), .clock(KEY[0]), .clear_b(SW[0]), .Q(out[2]));
	assign cable[2] = cable[1] & out[2];
	
	tFlip three(.T(cable[2]), .clock(KEY[0]),	.clear_b(SW[0]), .Q(out[3]));
	assign cable[3] = cable[2] & out[3];
		
	tFlip four(.T(cable[3]), .clock(KEY[0]), .clear_b(SW[0]), .Q(out[4]));
	assign cable[4] = cable[3] & out[4];
		
	tFlip five(.T(cable[4]), .clock(KEY[0]), .clear_b(SW[0]), .Q(out[5]));
	assign cable[5] = cable[4] & out[5];
		
	tFlip six(.T(cable[5]), .clock(KEY[0]), .clear_b(SW[0]), .Q(out[6]));
	assign cable[6] = cable[5] & out[6];
		
	tFlip seven(.T(cable[6]), .clock(KEY[0]), .clear_b(SW[0]), .Q(out[7]));
	
	assign l_b[3:0] = {out[3], out[2], out[1], out[0]};
	assign h_b[3:0] = {out[7], out[6], out[5], out[4]};
	
	//DISPLAYING
	DECODER H1(.in(l_b[3:0]), .hex_out(HEX0[6:0]));	
	DECODER H0(.in(h_b[3:0]), .hex_out(HEX1[6:0]));
	

endmodule

module tFlip(T, clock, clear_b, Q);
	input clock, clear_b, T;
	output reg Q;
	always @(posedge clock, negedge clear_b)
	begin
		if (clear_b == 1'b0)
			Q <= 1'b0;
		else if (T == 1'b1)
			Q <= ~Q;
	end
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