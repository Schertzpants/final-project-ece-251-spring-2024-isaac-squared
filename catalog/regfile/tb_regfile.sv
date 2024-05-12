//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Isaac Schertz, Isaac Amar
// 
//     Create Date: 2023-02-07
//     Module Name: tb_regfile
//     Description: Test bench for simple behavioral register file
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_REGFILE
`define TB_REGFILE

`timescale 1ns / 100ps
`include "regfile.sv"

module tb_regfile;
    parameter n = 32;
    parameter r = 5;
    logic clk, we3;
    logic [(r-1):0] ra1, ra2, wa3;
    logic [(n-1):0] wd3, rd1, rd2;

    // Clock generation
    always #5 clk = ~clk; // Clock with a period of 10ns

    initial begin
        $dumpfile("tb_regfile.vcd");
        $dumpvars(0, uut);
        $monitor("time=%0t \t ra1=%h rd1=%h \t ra2=%h rd2=%h", $time, ra1, rd1, ra2, rd2);
        clk = 0;
        we3 = 0; ra1 = 0; ra2 = 0; wa3 = 0; wd3 = 0; // Initialize signals

        // Test case: Write and read from a register
        #10 wa3 = 5; wd3 = 32'hA5A5; we3 = 1; // Write 0xA5A5 to register 5
        #10 we3 = 0; ra1 = 5; // Read from register 5

        #10 wa3 = 3; wd3 = 32'h1234; we3 = 1; // Write 0x1234 to register 3
        #10 we3 = 0; ra2 = 3; // Read from register 3

        #20 $finish; // End simulation after some time
    end

    // Instantiate the register file
    regfile uut(
        .clk(clk), .we3(we3), .ra1(ra1), .ra2(ra2), .wa3(wa3), .wd3(wd3), .rd1(rd1), .rd2(rd2)
    );
endmodule

`endif // TB_REGFILE
