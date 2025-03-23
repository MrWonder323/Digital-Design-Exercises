module PE #(
    n = 8
) (
    input clk,
    input nrst,
    input signed [n-1:0] X_in,
    input signed [n-1:0] Y_in,
    output logic signed [n-1:0] X_out,
    output logic signed [n-1:0] Y_out,
    output logic signed [2*n-1:0] result
);

// logic [2*n-1:0] result;

always @(posedge clk, negedge nrst) begin
    if (!nrst) begin
        result <= 0;
        X_out <= 0;
        Y_out <= 0;
    end else begin
        X_out <= X_in;
        Y_out <= Y_in;
        result <= (Y_in * X_in) + result;
    end
end
    
endmodule