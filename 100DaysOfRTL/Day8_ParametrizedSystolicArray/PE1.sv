module PE #(
    n = 4
) (
    input clk,
    input nrst,
    input [n-1:0] X_in,
    input [n-1:0] Y_in,
    output logic [n-1:0] X_out,
    output logic [n-1:0] Y_out,
    output logic [2*n-1:0] result
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