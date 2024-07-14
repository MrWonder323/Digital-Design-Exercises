typedef enum { 
    start,
    address,
    w_r,
    data
} state;

module i2c (
    // USER INPUT
    input clk,
    input nrst,
    input [6:0] address_i,
    input [7:0] data_i,
    input start_i,
    inout SDA,
    inout SCL
);

    assign SCL = SCL_en_reg? z: SCL_reg;
    assign SDA = SDA_en_reg? z: SDA_reg;

    // master only
    reg SCL_reg = 1;
    reg SDA_reg = 1;
    reg SCL_en_reg = 1;
    reg SDA_en_reg = 1;

    state current_state, next_state;

    
    always @(posedge clk, negedge nrst) begin
        if (!nrst) begin
            current_state <= start;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            start: begin
                SCL_reg = 1;
                
            end 
            default: 
        endcase
    end

endmodule