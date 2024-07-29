// FILE NAME: ALU.sv
// TYPE: module
// DEPARTMENT: NONE
// AUTHOR: ENG. Marwan Fetteha
//------------------------------------------------
// Release history
// VERSION DATE AUTHOR DESCRIPTION
// 1.0 06/01/2024 Initial version
//------------------------------------------------
// KEYWORDS: ALU, asynchronous reset
//------------------------------------------------
// PURPOSE: Parmetrized ALU

module ALU #(
    OP_SIZE_in = 8,
    OP_SIZE_out = OP_SIZE_in*2
) (
    input [OP_SIZE_in-1:0] a_in,
    input [OP_SIZE_in-1:0] b_in,
    input clk,
    input EN,
    input rst,
    input [2:0] op_in,
    output reg valid,
    output reg [OP_SIZE_out-1:0] alu_out
);

reg [OP_SIZE_out-1:0] alu_out_comp = 0;
reg  valid_comp;

parameter ADD = 0, SUB = 1, MULT = 2, DIV = 3;
parameter AND = 4, OR = 5, NOT = 6, XOR = 7;

always_ff @( posedge clk or negedge rst) begin
    if (!rst) begin
        alu_out <= 0;
        valid <= 0;
    end else begin
        alu_out <= alu_out_comp;
        valid <= valid_comp;
    end        
end

always_comb begin
    if (EN) begin
        valid_comp = 1;
        case (op_in)
            ADD: alu_out_comp = a_in + b_in;
            SUB: alu_out_comp = a_in - b_in;
            MULT: alu_out_comp = a_in * b_in; // Needs checking
            DIV: alu_out_comp = a_in / b_in;
            AND: alu_out_comp = a_in & b_in;
            OR: alu_out_comp = a_in | b_in;
            NOT: alu_out_comp = ~a_in;
            XOR: alu_out_comp = a_in ^ b_in; 
            default: alu_out_comp = 0; 
        endcase
    end else begin
        valid_comp = 0;
        alu_out_comp = 0;
    end    
end
    
endmodule