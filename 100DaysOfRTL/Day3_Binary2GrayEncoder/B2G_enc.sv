module B2G_enc #(
    input_size = 4
) (
    input [input_size-1:0] binary_i,
    output [input_size-1:0] gray_o
);
genvar i;
    
assign gray_o[input_size-1] = binary_i[input_size-1];

generate
    for (i = 0; i <= input_size-2; i++) begin
        assign gray_o[i] = binary_i[i+1] ^ binary_i[i];
    end
endgenerate
    
endmodule