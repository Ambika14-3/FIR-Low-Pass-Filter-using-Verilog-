`timescale 1ns / 1ps

module FIR
    (input clk, rstFIR,[2:0]addr, output [17:0]out_data, 
    input [7:0]c0,c1,c2,c3,c4,c5,c6,c7 ,input write); 
    
         wire [7:0]data_FIR;
    
         memory M0 ( addr, clk, data_FIR, c0,c1,c2,c3,c4,c5,c6,c7,write);
         
         LPF F0 (out_data, data_FIR, clk, rstFIR);

endmodule





