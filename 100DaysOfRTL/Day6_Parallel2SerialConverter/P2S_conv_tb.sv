module P2S_conv_tb
  (

   );

parameter CONVERTER_SIZE = 8;

logic store_i;
logic load_i;
logic clk;
logic [CONVERTER_SIZE-1:0] data_i;
logic data_o;


// Clock definition
localparam CLK_PERIOD = 10; // 100 Mhz (counter is in ns)
localparam RST_COUNT = 10; //Clock cycles that reset is high

always begin
    #(CLK_PERIOD/2) clk = ~clk;
end


initial begin
    clk = 0;
    load_i = 0;
    store_i = 0;
    data_i = {CONVERTER_SIZE/2{10}};
    #(RST_COUNT*CLK_PERIOD);
    @(posedge clk);
    store_i = 1;
    @(posedge clk);
    load_i = 1;

end

// DUT
P2S_conv #(.CONVERTER_SIZE(CONVERTER_SIZE))P2S_conv
    (
    .*
    );


endmodule