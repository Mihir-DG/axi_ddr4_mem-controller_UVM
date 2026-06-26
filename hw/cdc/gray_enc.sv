`timescale 1ns/1ps // <time unit>/<time precision>
// ==> #1 ==> delay of 1 ns with calcs closest to nearest ps

module gray_enc #(
    parameter int WIDTH = 1
)(
    input logic [WIDTH - 1 : 0] bin, // big endian
    output logic [WIDTH - 1 : 0] gray
);

    assign gray = bin ^ (bin >>  1);

endmodule