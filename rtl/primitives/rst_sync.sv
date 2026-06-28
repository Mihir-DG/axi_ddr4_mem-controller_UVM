`timescale 1ns/1ps

// syncs async reset signal to a separate reset function that maps to the full system's clock domain.

module rst_sync(
    input async_rst_n,
    input clk, // destination clock domain
    output sync_rst_n
);

    // tells synthesizer to place these regs together to minimize prop delay
    (* ASYNC_REG = "TRUE" *) logic q1;
    (* ASYNC_REG = "TRUE" *) logic q2;

    always_ff @(posedge clk or negedge async_rst_n) begin
        
        if (!async_rst_n) begin
            
            // if reset asserted
            q1 <= '0;
            q2 <= '0;
        
        end

        else begin
            
            // default functioning, rippling high sync_rst_n through 2 FFs for sync
            q1 <= '1;
            q2 <= q1;

        end

    end

    assign sync_rst_n = q2;    

endmodule
