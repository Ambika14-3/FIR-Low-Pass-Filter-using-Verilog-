`timescale 1ns / 1ps


    module LPF
    #(parameter order = 8, word_size_in = 8, word_size_out = 2*word_size_in + 2,  b0 = 8'h00,
    b1 = 8'h00, b2 = 8'h0C,b3 = 8'h88, b4 = 8'hEC, b5 = 8'h88, b6 = 8'h0C, b7 = 8'h00, b8 = 8'h00)
    (
        output [word_size_out - 1: 0] Data_out,
        input [word_size_in - 1: 0] Data_in,
        input clock, reset
     );
             
            
        reg [word_size_in -1: 0] Samples[1: order];
                
        integer k;
                
        assign Data_out = b0*Data_in + b1*Samples[1] + b2*Samples[2] + b3*Samples[3] + b4*Samples[4] 
                    + b5*Samples[5] + b6*Samples[6] + b7*Samples[7]+b8*Samples[8] ;
                                        
        always @(posedge clock)
                
        if(reset == 1)
           begin
                for(k=1; k<=order; k = k+1)
                        Samples[k] <= 0;
                end
                        
        else
            begin
                Samples[1] <= Data_in;
                for(k=2 ; k<=order; k = k+1)
                        Samples[k] <= Samples[k-1];
            end
                        
    endmodule 


