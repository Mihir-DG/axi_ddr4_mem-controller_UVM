`timescale 1ns/1ps

module fifo_mem #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4
)(
    // writer
    input logic wclk,
    input logic wclken,
    input logic[ADDR_WIDTH - 1 : 0] waddr,
    input logic[DATA_WIDTH - 1 : 0] wdata,

    // reader
    input logic[ADDR_WIDTH - 1 : 0] raddr,
    output logic[DATA_WIDTH - 1 : 0] rdata
);
    // logic[BIT_WIDTH - 1:0] array_name [ARRAY_DEPTH-1:0]
    logic [DATA_WIDTH - 1 : 0] mem [2 ** ADDR_WIDTH - 1 : 0];
    // eg, 4 addr bits ==> 2^4 = 16 slots = arr[15:0]

    always_ff @(posedge wclk) begin
        if (wclk) begin
            mem[waddr] <= wdata;
        end
    end

    assign rdata = mem[raddr];

endmodule