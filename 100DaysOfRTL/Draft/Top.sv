module Top (
);
    PC PC (.*,
        .pc_out(address))
    inst_mem inst_mem (.*);
endmodule