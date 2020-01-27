module sevento1(SW, LEDR);
	
	// Inputs and Outputs
	input [9:0] SW;
	output [0:0] LEDR;
	
	// Register variable
	reg O;
	
	// Main body of the code begins here
	always @(*)
	begin
		case(SW[9:7]) // Since 3-Bits are enough to consider all cases
			3'b000: O = SW[0];
			3'b001: O = SW[1];
			3'b010: O = SW[2];
			3'b011: O = SW[3];
			3'b100: O = SW[4];
			3'b101: O = SW[5];
			3'b110: O = SW[6];
			default: O = SW[0];
		endcase
	end
	
	//Assigning the output to LEDR
	assign LEDR[0] = O;

endmodule