  module morse(KEY, SW, LEDR, CLOCK_50);
	input [1:0] KEY;
	input [2:0] SW;
	input CLOCK_50;
	output [0:0] LEDR;
	reg [13:0] data;
	wire en;

	always @(*)
	begin
		case(SW)
			3'b000: data = 14'b10101000000000;
			3'b001: data = 14'b11100000000000;
			3'b010: data = 14'b10101110000000;
			3'b011: data = 14'b10101011100000;
			3'b100: data = 14'b10111011100000;
			3'b101: data = 14'b11101010111000;
			3'b110: data = 14'b11101011101110;
			3'b111: data = 14'b11101110101000;
			default: data = 14'b00000000000000;
		endcase
	end
	RD rd(.clock(CLOCK_50), .start(KEY[1]), .q(en));
	Shift_Reg sr(.load(data), .enable(en), .start(KEY[1]), .clock(CLOCK_50), .reset_n(KEY[0]), .out(LEDR[0]));
endmodule

module Shift_Reg(enable, load, start, reset_n, clock, out);
	input enable, start, reset_n, clock;
	input [13:0] load;
	output reg out;
	
	reg [13:0] temp;
	
	always @(posedge clock, negedge reset_n)
	begin
		if (reset_n == 0)
			begin
				out <= 0;
				temp <= 14'b0;
			end
		else if (start == 1)
			begin
				out <= 0;
				temp <= load;
			end
		else if (enable == 1)
			begin
				out <= temp[13];
				temp = temp << 1'b1;
			end
	end

endmodule

module RD(clock, start, q);
	input clock, start;
	output q;
	
	reg [24:0] out;
	
	always @(posedge clock)
	begin
		if (start == 1'b0)
			out <= 25'd24_999_999;
		else 
		begin
			if(out == 25'd0)
				out <= 25'd24_999_999;
			else
				out <= out - 1'b1;
		end
	end
	
	assign q = (out == 25'd0) ? 1 : 0;
endmodule
