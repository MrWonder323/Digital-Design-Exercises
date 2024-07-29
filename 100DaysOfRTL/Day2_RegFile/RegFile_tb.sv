// FILE NAME: RegFile_tb.sv
// TYPE: testbench
// DEPARTMENT: NONE
// AUTHOR: ENG. Marwan Fetteha
//------------------------------------------------
// Release history
// VERSION DATE AUTHOR DESCRIPTION
// 1.0 06/01/2024 Initial version
//------------------------------------------------
// KEYWORDS: Regester file, asynchronous reset
//------------------------------------------------
// PURPOSE: Testbench for Parmetrized Regester File

module RegFile_tb
  (

   );

integer i;

parameter MEM_WIDTH = 8, ADDRESS_SIZE = 4, MEM_DEPTH = 16;

logic clk,
logic rst,
logic [MEM_WIDTH-1:0] data_in,
logic [ADDRESS_SIZE-1:0] address_in,
logic write_read_n,
logic [MEM_WIDTH] data_out

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
    data_in = 6;
    address_in = 3;
    write_read_n = 1;

    @(posedge clk)
    data_in = 6;
    address_in = 3;
    write_read_n = 0;

    @(posedge clk)
    data_in = 6;
    address_in = 4;
    write_read_n = 0;

    @(posedge clk)
    data_in = 6;
    address_in = 6;
    write_read_n = 1;

    @(posedge clk)
    data_in = 6;
    address_in = 6;
    write_read_n = 0;
end

// DUT
RegFile RegFile_U1
    (
    .clk(clk),
    .rst(~rst),
    .data_in(data_in),
    .address_in(address_in),
    .write_read_n(write_read_n),
    .data_out(data_out)
    );


endmodule
