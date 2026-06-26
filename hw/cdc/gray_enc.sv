`timescale 1ns/1ps

module gray_enc #(
    parameter int WIDTH = 1
)(
    input logic [WIDTH - 1 : 0] bin,
    output logic [WIDTH - 1 : 0] gray
);

    assign gray = bin ^ (bin >>  1);

endmodule