module delay_reg #(
    n = 8, delay = 4
) (
    input clk,
    input nrst,
    input signed [n-1:0] D_in,
    output signed [n-1:0] D_out
);

    reg signed [n-1:0] delay_arr [0:delay-1];
    assign D_out = delay_arr[0];
    


    always @(posedge clk, negedge nrst) begin
        if (!nrst) begin
            for (int i = 0; i < delay; i++) begin
                delay_arr[i] <= 0;
            end
            
        end else begin
//            delay_arr[delay-1] <= D_in;
            delay_arr[delay-1] <= D_in;
            for (int i = 0; i < delay-1; i++) begin
                delay_arr[i] <= delay_arr[i+1];
            end
        end
    end
endmodule