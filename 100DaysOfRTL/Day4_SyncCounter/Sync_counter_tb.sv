module Sync_counter_tb
  (

   );

parameter counter_bits = 8;

logic clk;
logic nrst;
logic [counter_bits-1:0] counter_i;
logic [counter_bits-1:0] counter_o;
logic end_o;


// Clock definition
localparam CLK_PERIOD = 10; // 100 Mhz (counter is in ns)
localparam RST_COUNT = 10; //Clock cycles that reset is high

always begin
    #(CLK_PERIOD/2) clk = ~clk;
end


initial begin
    clk = 0;
    nrst = 0;
    counter_i = 5;
    #(RST_COUNT*CLK_PERIOD);
    @(posedge clk);
    nrst = 1;

end

// DUT
Sync_counter #(.counter_bits(counter_bits))Sync_counter
    (
    .*
    );


endmodule
