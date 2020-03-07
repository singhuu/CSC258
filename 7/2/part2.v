// Part 2 skeleton

module part2
	(
		CLOCK_50,						//	On Board 50 MHz
		// Your inputs and outputs here
        KEY,
        SW,
		// The ports below are for the VGA output.  Do not change.
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK_N,						//	VGA BLANK
		VGA_SYNC_N,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B   						//	VGA Blue[9:0]
	);

	input			CLOCK_50;				//	50 MHz
	input   [9:0]   SW;
	input   [3:0]   KEY;

	// Declare your inputs and outputs here
	// Do not change the following outputs
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[9:0]	VGA_R;   				//	VGA Red[9:0]
	output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[9:0]	VGA_B;   				//	VGA Blue[9:0]
	
	wire reset_n;
	assign reset_n = KEY[0];
	
	// Create the colour, x, y and writeEn wires that are inputs to the controller.
	wire [2:0] colour;
	wire [7:0] x;
	wire [6:0] y;
	wire writeEn, ld_x, ld_y, ld_color;
	
	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(reset_n),
			.clock(CLOCK_50),
			.colour(colour),
			.x(x),
			.y(y),
			.plot(writeEn),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "black.mif";
			
	// Put your code here. Your code should produce signals x,y,colour and writeEn/plot
	// for the VGA controller, in addition to any other functionality your design may require.
    // Instansiate datapath
	 
	datapath d(.pos(SW[6:0]), .rgb(SW[9:7]), .clock(CLOCK_50), .reset_n(reset_n), .x_a(ld_x), .y_a(ld_y), .c(ld_c), .x_out(x), .y_out(y), .rgb_out(colour)
		);

    // Instansiate FSM control
	control c(.in(!KEY[3]), .reset_n(reset_n), .clock(CLOCK_50), .d(!KEY[1]), .LOAD_X(ld_x), .LOAD_Y(ld_y), .LOAD_C(ld_c), .plot(writeEn)
		);
    
endmodule

module joined(go, clock, resetN, draw, colour_in, location_in, x_out, y_out, colour_out);
	input clock, resetN, go, draw;
	input [2:0] colour_in;
	input [6:0] location_in;
	output [7:0] x_out;
	output [6:0] y_out;
	output [2:0] colour_out;
	
	wire ld_x, ld_y, ld_c, plot;
	
	control c(.in(go), .reset_n(resetN), .clock(clock), .d(draw), .LOAD_X(ld_x), .LOAD_Y(ld_y), .LOAD_C(ld_c), .plot(plot)
	);
	
	datapath d(.pos(location_in), .rgb(colour_in), .clock(clock), .reset_n(resetN), .x_a(ld_x), .y_a(ld_y), .c(ld_c), .x_out(x_out), .y_out(y_out), .rgb_out(colour_out)
	);
	
endmodule

module datapath(pos, rgb, clock, reset_n, x_a, y_a, c, x_out, y_out, rgb_out);
	input [6:0] pos;
	input [2:0] rgb;
	input clock, reset_n, x_a, y_a, c;
	
	reg [7:0] x;
	reg [6:0] y;
	reg [2:0] colour;
	reg [3:0] count;
	
	output [7:0] x_out; 
	output [6:0] y_out;
	output [2:0] rgb_out;

	
	always @(posedge clock) 
	begin 
		if(!reset_n) 
		begin  //active low reset
			x <= 8'b0;
			y <= 7'b0;
			colour <= 3'b0;
		end
		else 
		begin
			if(x_a)
				x <= {1'b0, pos};
			if(y_a)
				y <= pos;
			if(c)
				colour <= rgb;
		end
	end
	
	always @(posedge clock) 
	begin
		if (!reset_n)
			count <= 4'b0000;
		else
		begin
			if (count != 4'b1111)
				count <= count + 1'b1;
			else
				count <= 4'b0000;
		end
	end
	
	assign x_out = x + count[1:0];
	assign y_out = y + count[3:2];
	assign rgb_out = colour;

endmodule

module control(in, reset_n, clock, d, LOAD_X, LOAD_Y, LOAD_C, plot);
	input in, reset_n, clock, d;
	output reg LOAD_X, LOAD_Y, LOAD_C, plot;
	
	reg [2:0] current_state, next_state;
	
	localparam 	X_L = 3'd0, X_L_wait = 3'd1, Y_L_C = 3'd2, Y_L_WAIT = 3'd3, illus = 3'd4;
	
	always @(posedge clock) 
	begin
		if (!reset_n)
			current_state <= X_L;
		else
			current_state <= next_state;
	end
	
	always @(*)
	begin
		case (current_state)
			X_L_wait: next_state = in ? X_L_wait : Y_L_C;
			Y_L_C: next_state = d ? Y_L_WAIT : Y_L_C;
			X_L: next_state = in ? X_L_wait : X_L;
			Y_L_WAIT: next_state = d ? Y_L_WAIT : illus;
			illus: next_state = in ? X_L : illus;
			default: next_state = X_L;
		endcase
	end
	
	always @(*) begin
		LOAD_X = 1'b0;
		LOAD_Y = 1'b0;
		LOAD_C = 1'b0;
		plot = 1'b0;
		
		case(current_state)
			illus: 
				begin
				plot = 1'b1;
				end
			X_L: 
				begin
				LOAD_X = 1'b1;
				end
			Y_L_C: 
				begin
				LOAD_C = 1'b1;
				LOAD_Y = 1'b1;
				end
		endcase
	end
endmodule


