`timescale 1ns / 1ps

module debounce(
    input wire clk,
    input wire button,
    output reg click
);

    reg [3:0] cnt;
    wire clk_1ms;

    localparam threshold = 10;

    timer_1ms m0(clk, clk_1ms);

    always @(posedge clk_1ms)
    begin
        if (button == 0) begin
            click = 0;
            cnt = 0;
        end
        else begin
            if (cnt < threshold) begin
                cnt = cnt + 1'b1;
                click = 0;
            end else begin
                click = 1;
            end
        end
    end

endmodule
