`timescale 1ns/1ps

module gray_dec #(
    parameter int WIDTH = 1
)(
    input logic [WIDTH - 1 : 0] gray,
    output logic [WIDTH - 1 : 0] bin
);

    always_comb begin
    
        bin[WIDTH - 1] = gray[WIDTH - 1];
        
        for (int i = 1; i < WIDTH; i ++) begin
            bin[WIDTH - 1 - i] = bin[WIDTH - i] ^ gray[WIDTH - i - 1];    
        end
    
    end
endmodule