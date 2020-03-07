`timescale 1ns / 1ps

// generate a 25 MHz pixel clock
module clk_pixel(
    input wire clk,
    output reg clk_pixel
);

    reg cnt;

    initial begin
        cnt <= 0;
        clk_pixel <= 0;
    end

    always @(posedge clk)
    begin
        if (cnt == 1)
            begin
                cnt <= 0;
                clk_pixel <= ~clk_pixel;
            end
        else
            cnt <= 1;
    end

endmodule
