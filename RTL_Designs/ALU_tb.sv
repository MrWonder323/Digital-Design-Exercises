`timescale 1ns / 1ps
// FILE NAME: ALU_tb.sv
// TYPE: testbench
// DEPARTMENT: NONE
// AUTHOR: ENG. Marwan Fetteha
//------------------------------------------------
// Release history
// VERSION DATE AUTHOR DESCRIPTION
// 1.0 06/01/2024 Initial version
//------------------------------------------------
// KEYWORDS: ALU, asynchronous reset
//------------------------------------------------
// PURPOSE: Testbench for Parmetrized ALU

module ALU_tb
  (

   );

integer i;

parameter OP_SIZE_in = 8, OP_SIZE_out = OP_SIZE_in*2;

logic [OP_SIZE_in-1:0] a_in;
logic [OP_SIZE_in-1:0] b_in;
logic clk;
logic EN;
logic rst;
logic [2:0] op_in;
logic valid;
logic [OP_SIZE_out-1:0] alu_out;

// Clock definition
localparam CLK_PERIOD = 10; // 100 Mhz (counter is in ns)
localparam RST_COUNT = 10; //Clock cycles that reset is high

always begin
    #(CLK_PERIOD/2) clk = ~clk;
end

// reset definition
initial begin
    clk = 0;
    rst = 1;
    #(RST_COUNT*CLK_PERIOD);
    @(posedge clk);
    rst = 0;

    // Test Cases
    @(posedge clk);
    a_in = 6;
    b_in = 3;
    EN = 0;
    op_in = 0;

    @(posedge clk)
    EN = 1;
    for (i = 0; i<7; i=i+1) begin
        @(posedge clk)
        op_in = op_in+1;
    end
end

// DUT
ALU ALU_U1
    (
    .a_in(a_in),
    .b_in(b_in),
    .clk(clk),
    .EN(EN),
    .rst(~rst),
    .op_in(op_in),
    .valid(valid),
    .alu_out(alu_out)
    );


endmodule
