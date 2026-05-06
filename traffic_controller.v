module traffic_controller(
    input clk,
    input reset,
    output reg A_red, A_yellow, A_green,
    output reg B_red, B_yellow, B_green
);

reg [1:0] state;
parameter A_GREEN = 2'b00,
          A_YELLOW = 2'b01,
          B_GREEN = 2'b10,
          B_YELLOW = 2'b11;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= A_GREEN;
    else
        state <= state + 1;
end

always @(*) begin
    // Default OFF
    A_red = 0; A_yellow = 0; A_green = 0;
    B_red = 0; B_yellow = 0; B_green = 0;

    case(state)
        A_GREEN: begin
            A_green = 1;
            B_red = 1;
        end

        A_YELLOW: begin
            A_yellow = 1;
            B_red = 1;
        end

        B_GREEN: begin
            B_green = 1;
            A_red = 1;
        end

        B_YELLOW: begin
            B_yellow = 1;
            A_red = 1;
        end
    endcase
end

endmodule
