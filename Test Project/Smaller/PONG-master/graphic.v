`timescale 1ns / 1ps

// show pixel(x, y) on the screen
module graphic(
    input wire  clk, reset,
    input wire  [1:0]  miao,
    input wire  [10:0] x, y,
    input wire  [1:0]  btn1, btn2,
    output wire [7:0]  rgb
);

    // colors: [B1 B2 G1 G2 G3 R1 R2 R3]
    localparam COLOR_BG   = 8'b01001000;
    localparam COLOR_BALL = 8'b11011101;
    localparam COLOR_LINE = 8'b11100001;
    localparam COLOR_LBAR = 8'b10010111;
    localparam COLOR_RBAR = 8'b00101011;
    localparam COLOR_NULL = 8'b00000000;

    // sizes
    reg [10:0] BAR_H   = 11'd60;
    reg [10:0] BAR_W   = 11'd5;
    localparam BALL_R  = 11'd5;
    localparam L_BOUND = 11'd60;
    localparam R_BOUND = 11'd580;
    localparam U_BOUND = 11'd40;
    localparam D_BOUND = 11'd440;

    // velocities
    localparam BAR_V  = 10'd1;
    localparam BALL_V = 10'd1;

    // initialize values
    reg [10:0] ball_x, ball_y, lbar_y, rbar_y;
    reg ball_move_x, ball_move_y;
    reg [5:0] lscore, rscore;
    initial begin
        ball_x = 11'd320;
        ball_y = 11'd240;
        lbar_y = 11'd240;
        rbar_y = 11'd240;
        ball_move_x = 1'b1;
        ball_move_y = 1'b1;
        lscore = 1'b0;
        rscore = 1'b0;
    end

    reg [7:0] rgb_now;
    wire clk_frame = (x == 0 && y == 0);
    always @(posedge clk) begin

        if (clk_frame) begin
            // controls
            if (btn1[0] && lbar_y > U_BOUND + BAR_H / 2) lbar_y = lbar_y - BAR_V;
            if (btn1[1] && lbar_y < D_BOUND - BAR_H / 2) lbar_y = lbar_y + BAR_V;
            if (btn2[0] && rbar_y > U_BOUND + BAR_H / 2) rbar_y = rbar_y - BAR_V;
            if (btn2[1] && rbar_y < D_BOUND - BAR_H / 2) rbar_y = rbar_y + BAR_V;

            if (miao[0]) BAR_H  = 11'd150;
            else BAR_H  = 11'd60;
            if (miao[1]) BAR_W  = 11'd20;
            else BAR_W  = 11'd5;
            if (reset) begin
                lscore = 0;
                rscore = 0;
            end

            // ball move
            if (ball_move_x) ball_x = ball_x + BALL_V;
            else ball_x = ball_x - BALL_V;
            if (ball_move_y) ball_y = ball_y + BALL_V;
            else ball_y = ball_y - BALL_V;

            // coliision detect
            if (ball_y <= U_BOUND + BALL_R || ball_y >= D_BOUND - BALL_R)
                ball_move_y = ~ball_move_y;
            if (ball_x == L_BOUND + BAR_W + BALL_R &&
                ball_y + BALL_R >= lbar_y - BAR_H / 2 && ball_y - BALL_R <= lbar_y + BAR_H / 2)
                ball_move_x = ~ball_move_x;
            if (ball_x == R_BOUND - BAR_W - BALL_R &&
                ball_y + BALL_R >= rbar_y - BAR_H / 2 && ball_y - BALL_R <= rbar_y + BAR_H / 2)
                ball_move_x = ~ball_move_x;

            // bound detect
            if (ball_x < 3 || ball_x > 637) begin
                if (ball_x < 3)
                    rscore = rscore + 1'b1;
                else if (ball_x > 637)
                    lscore = lscore + 1'b1;
                ball_x = 320;
                ball_y = 240;
                ball_move_x = (rscore > lscore);
                ball_move_y = 1'b1;
            end
        end

        if (x >= 0 && y >= 0 && x < 640 && y < 480) begin

            rgb_now <= COLOR_BG;

            // border
            if ((y == 40 || y == 440) && (x >= L_BOUND && x <= R_BOUND))
                rgb_now <= COLOR_LINE;

            // bars
            if ((x >= L_BOUND && x <= L_BOUND + BAR_W) &&
                (y >= lbar_y - BAR_H / 2 && y <= lbar_y + BAR_H / 2))
                rgb_now <= COLOR_LBAR;
            if ((x >= R_BOUND - BAR_W && x <= R_BOUND) &&
                (y >= rbar_y - BAR_H / 2 && y <= rbar_y + BAR_H / 2))
                rgb_now <= COLOR_RBAR;

            // ball
            if ((x >= ball_x - BALL_R && x <= ball_x + BALL_R) &&
                (y >= ball_y - BALL_R && y <= ball_y + BALL_R))
                rgb_now <= COLOR_BALL;

            // score
            if (x >= 6 && x <= 12)
                if (y / 6 % 2 == 1 && lscore > y / 6 / 2)
                    rgb_now <= COLOR_LBAR;
            if (x >= 628 && x <= 634)
                if (y / 6 % 2 == 1 && rscore > y / 6 / 2)
                    rgb_now <= COLOR_RBAR;

        end else begin
            // outside of the display area, fill black
            rgb_now <= COLOR_NULL;
        end
    end

    assign rgb = rgb_now;

endmodule
