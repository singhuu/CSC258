module clock(HEX0, SW, CLOCK_50);
	input [3:0] SW;
	input CLOCK_50;

	output [6:0] HEX0;
	
	wire [27:0] load;
	wire en;
	wire [3:0] out;
	
	fre sf(.select(SW[1:0]), .frequency(load));
	RD rd(.load(load), .enable(SW[2]), .clock(CLOCK_50), .reset(SW[3]), .q(en));
	DisC dc(.enable(en), .Clock(CLOCK_50), .reset_n(SW[3]), .disp(out));
	DECODER sh(.in(out), .hex_out(HEX0));
endmodule

module fre(select, frequency);
	input [1:0] select;
	output reg [27:0] frequency;
		
	always @(*)
	begin
		case(select[1:0])
			2'b00: frequency = 28'd0;
			2'b01: frequency = 28'd49_999_999;
			2'b10: frequency = 28'd99_999_999;
			2'b11: frequency = 28'd199_999_999;
			default: frequency = 28'd0;
		endcase
	end
endmodule

module DisC(Clock, disp, reset_n, enable);
	input Clock, enable, reset_n;
	output reg [3:0] disp;

	always @(posedge Clock)
	begin
		if(reset_n == 1'b0)
			disp <= 4'b0000;
		else if(enable == 1'b1)
			begin
				if(disp == 4'b1111)
					disp <= 4'b0000;
				else
					disp <= disp + 1'b1;
			end
	end
endmodule

module RD(load, enable, clock, reset, q);
	input [27:0] load;
	input enable, clock, reset;
	output q;
	
	reg [27:0] out;
	
	always @(posedge clock)
	begin
		if(reset == 1'b0)
			out <= load[27:0];
		else if(enable == 1'b1)
		begin
			if(out == 28'd0)
				out <= load;
			else
				out = out - 1'b1;
		end
	end
	
	assign q = (out == 28'd0) ? 1 : 0;
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
