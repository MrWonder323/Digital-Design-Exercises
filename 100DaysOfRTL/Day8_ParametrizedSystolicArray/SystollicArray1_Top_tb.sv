module tb_systolic_array;

    parameter n = 4, matrix_size = 4;  // 4x4 matrix

    logic clk;
    logic nrst;
    logic [3:0] A [matrix_size-1:0][matrix_size-1:0];
    logic [3:0] B [matrix_size-1:0][matrix_size-1:0];
    logic [7:0] C [matrix_size-1:0][matrix_size-1:0];  // Output matrix C

    // Instantiate the systolic array
    sysArray #(.n(n), .matrix_size(matrix_size)) dut (
        .dataA_in(A),
        .dataB_in(B),
        .clk(clk),
        .nrst(nrst),
        .dataC_out(C)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;  // 10ns period
    end

    // Test vector generation and simulation
    initial begin
        // Initialize signals
        clk = 0;

        A = '{'{4'd1, 4'd2, 4'd3, 4'd4},
             '{4'd5, 4'd6, 4'd7, 4'd8},
             '{4'd9, 4'd10, 4'd11, 4'd12},
             '{4'd13, 4'd14, 4'd15, 4'd15}};
        B = '{'{4'd1, 4'd1, 4'd1, 4'd1},
             '{4'd2, 4'd2, 4'd2, 4'd2},
             '{4'd3, 4'd3, 4'd3, 4'd3},
             '{4'd4, 4'd4, 4'd4, 4'd4}};

        // Reset the system
        nrst = 0;
        #10;
        nrst = 1;

        // Wait for the simulation to finish
        #100;

        // Display the result
        $display("Result Matrix C:");
        for (int i = 0; i < matrix_size; i++) begin
            for (int j = 0; j < matrix_size; j++) begin
                $display("C[%0d][%0d] = %0d", i, j, C[i][j]);
            end
        end

        $finish;
    end
endmodule
