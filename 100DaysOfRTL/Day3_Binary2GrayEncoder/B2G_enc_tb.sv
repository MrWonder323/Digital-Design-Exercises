module B2G_enc_tb
  (

   );

parameter input_size = 4;
integer i;


logic [input_size-1:0] binary_i;
logic [input_size-1:0] gray_o;


initial begin
    for (i = 0; i<=(2**input_size)-1; i=i+1) begin
        #3
        binary_i = i;
    end
end

// DUT
B2G_enc #(.input_size(input_size)) B2G_enc
    (
    .*
    );


endmodule
