module sysArray #(
    n = 4, matrix_size = 3
) (
    input clk,
    input nrst,
    input [n-1:0] dataA_in [0:matrix_size-1][0:matrix_size-1],
    input [n-1:0] dataB_in [0:matrix_size-1][0:matrix_size-1],
    output [2*n-1:0] dataC_out [0:matrix_size-1][0:matrix_size-1]
);

// Internal connections between PEs
logic [n-1:0] x_connections [0:matrix_size-1][0:matrix_size-1];
logic [n-1:0] y_connections [0:matrix_size-1][0:matrix_size-1];

logic [n-1:0] x_reg [0:matrix_size-1];
logic [n-1:0] y_reg [0:matrix_size-1];

logic [3:0] count;
logic done;

logic [n-1:0] dataB_delay [0:matrix_size-2];
logic [n-1:0] dataA_delay [0:matrix_size-2];

// Input rigesters getting there values from the input
always @(posedge clk, negedge nrst) begin
    if (!nrst) begin
        for (int i = 0; i < matrix_size; i++) begin
            x_reg[i] <= 0;
            y_reg[i] <= 0;
        end

        count <= 0;
        done <= 0;
    end else begin
        if (count == 2*matrix_size + 1) begin
            done <= 1;

        end else if (count < matrix_size) begin
            y_reg <= dataB_in[count][0:matrix_size-1];

            for (int i = 0; i < matrix_size; i++) begin
                x_reg[i] <= dataA_in[i][count];
            end
            
            count <= count + 1;
        end else begin
        
        for (int i = 0; i < matrix_size; i++) begin
            x_reg[i] <= 0;
            y_reg[i] <= 0;
        end           
            count <= count + 1;
        end
    end
end


// Initializing the PEs and routing data
genvar i, j, k;
    generate
        for (i = 0; i < matrix_size; i++) begin: row
            for (j = 0; j < matrix_size; j++) begin: col
                if (i == 0 && j == 0) begin
                    // First PE, initialize with the first values of A and B
                    assign x_connections[i][j] = x_reg[i];
                    assign y_connections[i][j] = y_reg[j];
                end else if (i == 0) begin
                    // For the top row, shift the data from the left
//                    assign x_connections[i][j] = x_connections[i][j-1];
                    assign y_connections[i][j] = dataB_delay[j-1];

                    // Input a ladder of zeros in the top row
                    delay_reg #(n, j) delay_reg_inst_row(
                    .clk(clk),
                    .nrst(nrst),
                    .D_in(y_reg[j]),
                    .D_out(dataB_delay[j-1])
                    );
                    
                    delay_reg #(n, 1) delay_x1 (
                    .clk(clk),
                    .nrst(nrst),
                    .D_in(x_connections[i][j-1]),  // Introduce delay in shifting
                    .D_out(x_connections[i][j])
                    );                      

                end else if (j == 0) begin
                    // For the leftmost column, shift the data from above
                    assign x_connections[i][j] = dataA_delay[i-1];
//                    assign y_connections[i][j] = y_connections[i-1][j];

                    // Input a ladder of zeros in the left coulmn
                    delay_reg #(n, i) delay_reg_inst_col(
                    .clk(clk),
                    .nrst(nrst),
                    .D_in(x_reg[i]),
                    .D_out(dataA_delay[i-1])
                    );  
                    
                    delay_reg #(n, 1) delay_y1 (
                    .clk(clk),
                    .nrst(nrst),
                    .D_in(y_connections[i-1][j]),  // Introduce delay in shifting
                    .D_out(y_connections[i][j])
                    );
                end else begin
                    // For all other PEs, shift data from left and top
//                    assign x_connections[i][j] = x_connections[i][j-1];
//                    assign y_connections[i][j] = y_connections[i-1][j];
                    
                    delay_reg #(n, 1) delay_x (
                    .clk(clk),
                    .nrst(nrst),
                    .D_in(x_connections[i][j-1]),  // Introduce delay in shifting
                    .D_out(x_connections[i][j])
                    );
                    
                     delay_reg #(n, 1) delay_y (
                    .clk(clk),
                    .nrst(nrst),
                    .D_in(y_connections[i-1][j]),  // Introduce delay in shifting
                    .D_out(y_connections[i][j])
                    );
                end

                // Instantiate the PE
                PE pe_inst (
                    .clk(clk),
                    .nrst(nrst),
                    .X_in(x_connections[i][j]),
                    .Y_in(y_connections[i][j]),
                    .X_out(x_connections[i][j+1]),
                    .Y_out(y_connections[i+1][j]),
                    .result(dataC_out[i][j])
                );
            end
        end
    endgenerate



endmodule