typedef enum { 
    idle,
    start,
    address,
    w_r,
    data,
    stop
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

    reg [6:0] address_reg;
    reg [7:0] data_reg;

    state current_state, next_state;

    
    always @(posedge clk, negedge nrst) begin
        if (!nrst) begin
            current_state <= idle;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            idle: begin
                SCL_reg = 1;
                SDA_reg = 1;
                next_state = start;
            end
            start: begin
                SDA_reg = 0;
                next_state = address;
            end
            address: begin
                SCL_reg = !SCL_reg;

            end 
            default: 
        endcase
    end

endmodule