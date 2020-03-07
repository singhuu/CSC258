`timescale 1ns / 1ps

// generate a 1 ms (1 KHz) clock
module timer_1ms(
    input wire clk,
    output reg clk_1ms
);

    reg [15:0] cnt;

    initial begin
        cnt [15:0] <= 0;
        clk_1ms <= 0;
    end

    always @(posedge clk) begin
        if (cnt >= 50000) begin
            cnt <= 0;
            clk_1ms <= ~clk_1ms;
        end else begin
            cnt <= cnt + 1'b1;
        end
    end

endmodule
