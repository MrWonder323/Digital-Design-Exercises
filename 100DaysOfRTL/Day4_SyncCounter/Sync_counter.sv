module Sync_counter #(
    counter_bits = 4
) (
    input clk,
    input nrst,
    input [counter_bits-1:0] counter_i,
    output reg [counter_bits-1:0] counter_o,
    output end_o
);

assign end_o = &counter_o;

always @(posedge clk, negedge nrst) begin
    if (!nrst) begin
        counter_o <= counter_i;
    end else begin
        counter_o <= counter_o + 1;
    end    
end
    
endmodule