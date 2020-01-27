module Four_to_One(LEDR, SW);
    input [9:0] SW;
    output [9:0] LEDR;
	 wire connect_1;
	 wire connect_2;
    Two_to_One block_1(
        .A(SW[0]),
        .B(SW[1]),
        .s(SW[8]),
        .out(connect_1)
        );
	
	 Two_to_One block_2(
        .A(SW[2]),
        .B(SW[3]),
        .s(SW[8]),
        .out(connect_2)
        );
		  
	 Two_to_One block_3(
        .A(connect_1),
        .B(connect_2),
        .s(SW[9]),
        .out(LEDR[0])
        );
endmodule

module Two_to_One(A, B, s, out);
    input A;
    input B;
    input s;
    output out;
  
    assign out = s & B | ~s & A;

endmodule
