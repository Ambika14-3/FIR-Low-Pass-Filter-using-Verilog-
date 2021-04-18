`timescale 1ns / 1ps

module memory
#(parameter word_size = 8)
 
 (input [2:0]addr, input clk,output reg [word_size-1:0]out_data,
 input [word_size-1:0]c0,c1,c2,c3,c4,c5,c6,c7,input write);


	reg [7:0]mem [7:0];
	
	initial 
	begin
         mem[0] <= 8'd0;
         mem[1] <= 8'd0;
         mem[2] <= 8'd0;
         mem[3] <= 8'd0;
         mem[4] <= 8'd0;
         mem[5] <= 8'd0;
         mem[6] <= 8'd0;
         mem[7] <= 8'd0;
	end
		
    always @(posedge clk)
    begin
        if(write == 1)
        begin
            mem[0] <= c0;
            mem[1] <= c1;
            mem[2] <= c2;
            mem[3] <= c3;
            mem[4] <= c4;
            mem[5] <= c5;
            mem[6] <= c6;
            mem[7] <= c7;
        end
       
        out_data <= mem[addr];
        
    end
endmodule 