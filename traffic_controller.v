### 📄 traffic_controller.v (Verilog Code)
```verilog
//////////////////////////////////////////////////////////////////////////////
// ASM-Based Traffic Signal Controller
// Two-road intersection traffic light controller
// States: A_GREEN (5s), A_YELLOW (2s), B_GREEN (5s), B_YELLOW (2s)
//////////////////////////////////////////////////////////////////////////////

module traffic_controller (
    input wire clk,          // System clock
    input wire reset,        // Synchronous reset (active high)
    output reg a_green,      // Road A green light
    output reg a_yellow,     // Road A yellow light
    output reg a_red,        // Road A red light
    output reg b_green,      // Road B green light
    output reg b_yellow,     // Road B yellow light
    output reg b_red         // Road B red light
);

    // State encoding
    localparam [1:0]
        A_GREEN  = 2'b00,
        A_YELLOW = 2'b01,
        B_GREEN  = 2'b10,
        B_YELLOW = 2'b11;

    // Timing parameters (in clock cycles)
    // Assuming 1 Hz clock for simulation
    localparam [2:0]
        GREEN_DURATION  = 3'd5,   // 5 seconds
        YELLOW_DURATION = 3'd2;   // 2 seconds

    // Internal registers
    reg [1:0] current_state, next_state;
    reg [2:0] timer;               // 3-bit counter (0-7)
    reg timer_reset;
    reg timer_enable;

    //////////////////////////////////////////////////////////////////////////
    // State Register Block
    //////////////////////////////////////////////////////////////////////////
    always @(posedge clk) begin
        if (reset)
            current_state <= A_GREEN;
        else
            current_state <= next_state;
    end

    //////////////////////////////////////////////////////////////////////////
    // Timer Logic
    //////////////////////////////////////////////////////////////////////////
    always @(posedge clk) begin
        if (reset || timer_reset)
            timer <= 3'b0;
        else if (timer_enable)
            timer <= timer + 1'b1;
    end

    // Timer done flag
    wire timer_done = (timer == ( (current_state == A_GREEN || current_state == B_GREEN) ? 
                                   GREEN_DURATION - 1 : 
                                   YELLOW_DURATION - 1));

    //////////////////////////////////////////////////////////////////////////
    // Next State Logic Block (Combinational)
    //////////////////////////////////////////////////////////////////////////
    always @(*) begin
        // Default assignments
        next_state = current_state;
        timer_reset = 1'b0;
        timer_enable = 1'b1;
        
        case (current_state)
            A_GREEN: begin
                if (timer_done) begin
                    next_state = A_YELLOW;
                    timer_reset = 1'b1;
                end
            end
            
            A_YELLOW: begin
                if (timer_done) begin
                    next_state = B_GREEN;
                    timer_reset = 1'b1;
                end
            end
            
            B_GREEN: begin
                if (timer_done) begin
                    next_state = B_YELLOW;
                    timer_reset = 1'b1;
                end
            end
            
            B_YELLOW: begin
                if (timer_done) begin
                    next_state = A_GREEN;
                    timer_reset = 1'b1;
                end
            end
            
            default: begin
                next_state = A_GREEN;
                timer_reset = 1'b1;
            end
        endcase
    end

    //////////////////////////////////////////////////////////////////////////
    // Output Logic Block (Combinational)
    //////////////////////////////////////////////////////////////////////////
    always @(*) begin
        // Default outputs (all lights off)
        {a_green, a_yellow, a_red} = 3'b000;
        {b_green, b_yellow, b_red} = 3'b000;
        
        case (current_state)
            A_GREEN: begin
                a_green = 1'b1;
                a_red   = 1'b0;
                b_red   = 1'b1;
                b_green = 1'b0;
            end
            
            A_YELLOW: begin
                a_yellow = 1'b1;
                a_red    = 1'b0;
                b_red    = 1'b1;
                b_green  = 1'b0;
            end
            
            B_GREEN: begin
                b_green = 1'b1;
                b_red   = 1'b0;
                a_red   = 1'b1;
                a_green = 1'b0;
            end
            
            B_YELLOW: begin
                b_yellow = 1'b1;
                b_red    = 1'b0;
                a_red    = 1'b1;
                a_green  = 1'b0;
            end
        endcase
    end

endmodule
