//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Isaac Schertz, Isaac Amar
// 
//     Create Date: 2023-02-07
//     Module Name: regfile
//     Description: 32-bit RISC register file
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef REGFILE
`define REGFILE

`timescale 1ns/100ps

module regfile
    #(parameter n = 32, r = 5)(
        //
        // ---------------- PORT DEFINITIONS ----------------
        //
        input  logic clk, 
        input  logic we3, 
        input  logic [(r-1):0] ra1, ra2, wa3, 
        input  logic [(n-1):0] wd3, 
        output logic [(n-1):0] rd1, rd2
    );
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    localparam NUM_REGS = 2**r; // Number of registers
    logic [(n-1):0] rf[NUM_REGS-1:0]; // Register array

    // Write logic - write to register wa3 on positive edge of clk if we3 is high and wa3 is not 0
    always @(posedge clk) begin
        if (we3 && wa3 != 0) // Ensure we do not write to register 0
            rf[wa3] <= wd3;
    end

    // Read logic - output zero if address is 0, otherwise output register content
    // Register 0 is always zero
    assign rd1 = (ra1 != 0) ? rf[ra1] : 0;
    assign rd2 = (ra2 != 0) ? rf[ra2] : 0;

endmodule

`endif // REGFILE
