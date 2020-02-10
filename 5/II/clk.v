module clk(SW, CLOCK_50, HEX0, LEDR);	
	input [2:0] SW;
	input CLOCK_50;		
	output [6:0] HEX0; 
	output [3:0] LEDR; 
	wire en;   
	reg [27:0] freq;    
	always @(*)
	begin
		case (SW[1:0])
			2'b00: freq[27:0] = 28'd0;
			2'b01: freq[27:0] = 28'd49_999_999;
			2'b10: freq[27:0] = 28'd99_999_999;
			2'b11: freq[27:0] = 28'd199_999_999;
			default: freq[27:0] = 28'd0;
		endcase
	end

	RD rd(.Clock(CLOCK_50), .reset_n(SW[2]), .enable(en), .in(freq[27:0]));
	DisC dc(.Clock(CLOCK_50), .enable(en), .reset_n(SW[2]), .Q(LEDR[3:0]));
	DECODER hex(.in(LEDR[3:0]), .hex_out(HEX0[6:0]));
endmodule

module DisC(Clock, enable, reset_n, Q);
	input Clock, enable, reset_n;
	output [3:0] Q;
	reg [3:0] temp;

	always @(posedge Clock)
	begin
		if (reset_n == 0)
			temp <= 4'b0000;
		else if (enable == 1)
			begin
				if (temp == 4'b1111)
					temp <= 4'b0000;
				else
					temp <= temp + 4'b0001;
			end
	end
	assign Q[3:0] = temp[3:0];
endmodule

module RD(Clock, reset_n, enable, in);
	input [27:0] in;
	input reset_n;
	input Clock;
	output enable;
	reg [27:0] RD_temp;

	always @(posedge Clock)
	begin
		if (reset_n == 0)
			RD_temp <= in;
		else if (RD_temp == 28'd0)
			RD_temp <= in;
		else
			RD_temp <= RD_temp - 28'd1;
	end
	assign enable = (RD_temp == 0) ? 1 : 0;
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
