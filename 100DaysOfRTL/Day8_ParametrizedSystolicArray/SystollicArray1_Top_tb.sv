module tb_systolic_array;

    parameter n = 8, matrix_size = 4;  // 4x4 matrix

    logic clk;
    logic nrst;
    logic signed [n-1:0] A [matrix_size-1:0][matrix_size-1:0];
    logic signed [n-1:0] B [matrix_size-1:0][matrix_size-1:0];
    logic signed [2*n-1:0] C [matrix_size-1:0][matrix_size-1:0];  // Output matrix C

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

        A = '{'{-1, 2, 3, 4},
             '{5, 6, 7, 8},
             '{9, 10, -11, 12},
             '{13, 14, 15, 15}};
        B = '{'{1, 1, 1, 1},
             '{2, 2, -2, 2},
             '{3, 3, 3, 3},
             '{4, 4, 4, 4}};

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
        end        $finish;
    end
endmodule
