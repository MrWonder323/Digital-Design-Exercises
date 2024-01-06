// FILE NAME: RegFile.sv
// TYPE: module
// DEPARTMENT: NONE
// AUTHOR: ENG. Marwan Fetteha
//------------------------------------------------
// Release history
// VERSION DATE AUTHOR DESCRIPTION
// 1.0 06/01/2024 Initial version
//------------------------------------------------
// KEYWORDS: Regester file, asynchronous reset
//------------------------------------------------
// PURPOSE: Parmetrized Regester File

module RegFile #(
    MEM_WIDTH = 8, ADDRESS_SIZE = 4, MEM_DEPTH = 16 
) (
    input clk,
    input rst,
    input [MEM_WIDTH-1:0] data_in,
    input [ADDRESS_SIZE-1:0] address_in,
    input write_read_n,
    output reg [MEM_WIDTH] data_out
);

reg [MEM_WIDTH-1:0] MEM_reg [0:MEM_DEPTH-1];

always_ff @( posedge clk or negedge rst ) begin
    if (!rst) begin
        data_out <= 0;
        MEM_reg <= 0;
    end else begin
        if (write_read_n) begin
            MEM_reg[address_in] <= data_in;
        end else begin
            data_out <= MEM_reg[address_in];
        end
    end    
end
    
endmodule