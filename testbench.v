//////////////////////////////////////////////////////////////////////////////
// Testbench for Traffic Signal Controller
//////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module testbench();

    // Signals
    reg clk;
    reg reset;
    wire a_green, a_yellow, a_red;
    wire b_green, b_yellow, b_red;
    
    // Instantiate the traffic controller
    traffic_controller uut (
        .clk(clk),
        .reset(reset),
        .a_green(a_green),
        .a_yellow(a_yellow),
        .a_red(a_red),
        .b_green(b_green),
        .b_yellow(b_yellow),
        .b_red(b_red)
    );
    
    // Clock generation (1 Hz for timing visualization)
    // Using 10ns period for simulation speed
    always #5 clk = ~clk;  // 100 MHz clock
    
    // Monitor outputs
    initial begin
        $monitor("Time=%0t | State: A[%b%b%b] B[%b%b%b] | Timer=%d", 
                 $time, a_green, a_yellow, a_red, b_green, b_yellow, b_red, uut.timer);
    end
    
    // Test sequence
    initial begin
        // Initialize
        clk = 0;
        reset = 1;
        
        // Apply reset for 2 cycles
        repeat(2) @(posedge clk);
        reset = 0;
        
        $display("\n=== TRAFFIC CONTROLLER SIMULATION STARTED ===");
        $display("=============================================\n");
        
        // Run simulation for complete cycles
        // Each state duration: 5 + 2 + 5 + 2 = 14 seconds total
        
        // Wait for complete simulation
        #150000;  // ~10+ cycles
        
        $display("\n=== SIMULATION COMPLETED ===");
        $finish;
    end
    
    // Waveform dumping (for ModelSim/Vivado)
    initial begin
        $dumpfile("traffic_controller.vcd");
        $dumpvars(0, testbench);
    end
    
    // Assertion to ensure no conflicting green signals
    always @(posedge clk) begin
        assert (!(a_green && b_green)) 
            else $error("CONFLICT! Both roads have green signal!");
    end
    
endmodule
