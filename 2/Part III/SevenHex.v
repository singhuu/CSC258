module SevenHex(HEX0, SW);
    input [3:0] SW;
    output [6:0] HEX0;

    hex_0 comp0(
        .i_3(SW[3]),  
        .i_2(SW[2]),
        .i_1(SW[1]),
        .i_0(SW[0]),
        .out(HEX0[0])
        );
	
    hex_1 comp1(
        .i_3(SW[3]),
        .i_2(SW[2]),
        .i_1(SW[1]),
        .i_0(SW[0]),
        .out(HEX0[1])
        );
	  
    hex_2 comp2(
        .i_3(SW[3]),
        .i_2(SW[2]),
        .i_1(SW[1]),
        .i_0(SW[0]),
        .out(HEX0[2])
        );

    hex_3 comp3(
        .i_3(SW[3]),
        .i_2(SW[2]),
        .i_1(SW[1]),
        .i_0(SW[0]),
        .out(HEX0[3])
        );

    hex_4 comp4(
        .i_3(SW[3]),
        .i_2(SW[2]),
        .i_1(SW[1]),
        .i_0(SW[0]),
        .out(HEX0[4])
        );

    hex_5 comp5(
        .i_3(SW[3]),
        .i_2(SW[2]),
        .i_1(SW[1]),
        .i_0(SW[0]),
        .out(HEX0[5])
        );

    hex_6 comp6(
        .i_3(SW[3]),
        .i_2(SW[2]),
        .i_1(SW[1]),
        .i_0(SW[0]),
        .out(HEX0[6])
        );
				
endmodule

module hex_0(i_3, i_2, i_1, i_0, out);
    input i_3;
    input i_2;
    input i_1;
    input i_0;
    output out;
  
    assign out = (~i_3 & i_2 & ~i_1 & ~i_0) |(~i_3 & ~i_2 & ~i_1 & i_0) | (i_3 & i_2 & ~i_1 & i_0) | (i_3 & ~i_2 & i_1 & i_0);

endmodule

module hex_1(i_3, i_2, i_1, i_0, out);
    input i_3;
    input i_2;
    input i_1;
    input i_0;
    output out;
  
    assign out = (~i_3 & i_2 & ~i_1 & i_0) | (i_2 & i_1 & ~i_0) | (i_3 & i_2 & ~i_0)| (i_3 & i_1 & i_0);

endmodule

module hex_2(i_3, i_2, i_1, i_0, out);
    input i_3;
    input i_2;
    input i_1;
    input i_0;
    output out;
  
    assign out = (~i_3 & ~i_2 & i_1 & ~i_0)| (i_3 & i_2 & ~i_0) |(i_3 & i_2 & i_1);

endmodule

module hex_3(i_3, i_2, i_1, i_0, out);
    input i_3;
    input i_2;
    input i_1;
    input i_0;
    output out;
  
    assign out = (~i_3 & ~i_2 & ~i_1 & i_0) | (i_3 & ~i_2 & i_1 & ~i_0) | (~i_3 & i_2 & ~i_1 & ~i_0) | (i_2 & i_1 & i_0) ;

endmodule

module hex_4(i_3, i_2, i_1, i_0, out);
    input i_3;
    input i_2;
    input i_1;
    input i_0;
    output out;
  
    assign out = (~i_2 & ~i_1 & i_0) | (~i_3 & i_2 & ~i_1) |(~i_3 & i_0)   ;

endmodule

module hex_5(i_3, i_2, i_1, i_0, out);
    input i_3;
    input i_2;
    input i_1;
    input i_0;
    output out;
  
    assign out = (~i_3 & ~i_2 & i_0) |(~i_3 & ~i_2 & i_1) | (i_3 & i_2 & ~i_1 & i_0) | (~i_3 & i_1 & i_0);

endmodule

module hex_6(i_3, i_2, i_1, i_0, out);
    input i_3;
    input i_2;
    input i_1;
    input i_0;
    output out;
  
    assign out = (~i_3 & ~i_2 & ~i_1) | (~i_3 & i_2 & i_1 & i_0) | (i_3 & i_2 & ~i_1 & ~i_0);


endmodule
