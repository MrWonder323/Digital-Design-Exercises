module P2S_conv #(
    CONVERTER_SIZE = 4
) (
    input store_i,
    input load_i,
    input clk,
    input [CONVERTER_SIZE-1:0] data_i,
    output data_o
);

reg [CONVERTER_SIZE-1:0] converter;

asssign data_o = converter[0];

always @(posedge clk) begin
    if (store_i) begin
        converter <= data_i;
    end elseif (load_i) begin
        converter >> 1;
    end else begin
        converter <= converter;
    end

end
endmodule