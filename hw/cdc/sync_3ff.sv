
`timescale 1ns/1ps

// ripple synchronizer to transfer data between 2 separate clock domains

module sync_3ff #(
    parameter int WIDTH = 1
)(
    input logic clk, // destination clock domain
    input logic rst_n,
    input logic[WIDTH-1:0] async_d,
    output logic [WIDTH-1:0] sync_q
);

    // tells synthesizer to place these regs together to minimize prop delay
    (* ASYNC_REG = "TRUE" *) logic [WIDTH - 1 : 0] q1;
    (* ASYNC_REG = "TRUE" *) logic [WIDTH - 1 : 0] q2;
    (* ASYNC_REG = "TRUE" *) logic [WIDTH - 1 : 0] q3;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            q1 <= '0;
            q2 <= '0;
            q3 <= '0;
        end
        else begin
            q1 <= async_d;
            q2 <= q1;
            q3 <= q2;        
        end
    end

    assign sync_q = q3;

endmodule