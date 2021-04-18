`timescale 1ns / 1ps

module TB;
        
    reg [2:0]addr_Mem;
    reg clk;                                // DECLARED COMMON FOR ALL
    wire [7:0]Mem_data;
    reg [7:0]c0,c1,c2,c3,c4,c5,c6,c7;
    reg write;
    integer x;
    reg rstFIR;
    reg [2:0]addr;
    wire [17:0]out_data;


    integer i;
    real t;
    
    memory memory_0 (addr_Mem,clk,Mem_data,c0,c1,c2,c3,c4,c5,c6,c7,write);
    FIR FIR_0 (clk, rstFIR,addr,out_data,c0,c1,c2,c3,c4,c5,c6,c7,write ); 
    

    always #10 clk = ~ clk;
  
    initial
    begin
    
           // CHECKING MEMORY MODULE: 
           // INPUT: write = 0, c0,c1,....c7 NON-ZERO VALUES
           // EXPECTED OUTPUT : FOR ALL DATA REGISTERS, OUTPUT OF MEMORY BLOCK IS ZERO 
          
            begin
                clk <= 0;
                addr_Mem <= 0;
                write <= 0;
                c0 <= 8'd1;
                c1 <= 8'd2;
                c2 <= 8'd3;  
                c3 <= 8'd4;
                c4 <= 8'd5; 
                c5 <= 8'd6;
                c6 <= 8'd7;
                c7 <= 8'd8;     
                    
                for(i = 0; i<8; i = i + 1)
                begin
                       addr_Mem <= i;
                       #20; 
                end
            end
            
            
            
            // CHECKING MEMORY MODULE:
            // INPUT write = 1 , #20 write = 0
            // EXPECTED OUTPUT: DATA REGISTERS HAVING THEIR CORRESPONDING INPUT VALUES AS FED BY c0,c1..c7
            //                  OUTPUT OF MEMORY BLOCK SHOULD CHANGE ONLY WHEN POSITIVE EDGE OF CLOCK
            //                  ARRIVES
            begin
                clk <= 0;
                addr_Mem <= 0;
                write <= 1;
                c0 <= 8'd1;
                c1 <= 8'd2;
                c2 <= 8'd3;  
                c3 <= 8'd4;
                c4 <= 8'd5; 
                c5 <= 8'd6;
                c6 <= 8'd7;
                c7 <= 8'd8;   
                
                #20 write <= 0;
                
                for(i = 0; i<8; i = i + 1)
                begin 
                      addr_Mem <= i;
                      #20;
                end  
            end


            // CHECKING MEMORY MODULE:
            // INPUT write = 1 , #20 write = 0, c0,c1,....c7 = 0
            // EXPECTED OUTPUT: DATA REGISTERS TO BE SET AS ZERO
            begin
                clk <= 0;
                addr_Mem <= 0;
                write <= 1;
                c0 <= 8'd0;
                c1 <= 8'd0;
                c2 <= 8'd0;  
                c3 <= 8'd0;
                c4 <= 8'd0; 
                c5 <= 8'd0;
                c6 <= 8'd0;
                c7 <= 8'd0;   
                
                #20 write <= 0;
                
                for(i = 0; i<8; i = i + 1)
                begin
                      addr_Mem <= i;
                      #20;
                end  
            end



            // CHECKING TOP LEVEL MODULE FIR:
            // INPUT: rstFIR = 1, write = 1 , #10 {rstFIR,write} <= 0
            //        c0,c1,c2...c7 = {0,0,0,0,0,0,0,0}, .i.e., ALL ZEROS
            // EXPECTED OUTPUT: ZERO OUTPUT          

            begin
                 clk <= 0;
                 addr <= 0;
                 rstFIR <= 1;
                 write <= 1;
                 c0 <= 8'd0;
                 c1 <= 8'd0;  
                 c2 <= 8'd0;
                 c3 <= 8'd0;
                 c4 <= 8'd0; 
                 c5 <= 8'd0;
                 c6 <= 8'd0;
                 c7 <= 8'd0;   

                 #20 {rstFIR,write} <= 0;                 
 
                 
                 for(i = 0; i<8; i = i + 1)
                 begin
                       addr <= i;
                       #20;
                 end    
                 
            end

               
                   
        
            
            // CHECKING TOP LEVEL MODULE FIR:
            // INPUT: rstFIR = 1, write = 1 , #10 {rstFIR,write} <= 0
            //        c0,c1,c2...c7 = {1,0,0,0,0,0,0,0}, .i.e., IMPULSE
            // EXPECTED OUTPUT: COEFFICIENTS OF FIR FILTERS, i.e. , IMPULSE RESPONSE
            //                  OUTPUT OF FILTER MUST CHANGE ONLY WHEN POSITIVE EDGE
            //                  OF CLOCK ARRIVES

            begin
                 clk <= 0;
                 addr <= 0;
                 rstFIR <= 1;
                 write <= 1;
                 c0 <= 8'd1;
                 c1 <= 8'd0;  
                 c2 <= 8'd0;
                 c3 <= 8'd0;
                 c4 <= 8'd0; 
                 c5 <= 8'd0;
                 c6 <= 8'd0;
                 c7 <= 8'd0;   

                 #20 {rstFIR,write} <= 0;                 
 
                 for(i = 0; i<8; i = i + 1)
                 begin
                       addr <= i;
                       #20;
                 end
               
                #60;       
            end
          
     
             // CHECKING TOP LEVEL MODULE FIR:
            // INPUT: rstFIR = 1, write = 1 , #10 {rstFIR,write} <= 0
            //        c0,c1,c2...c7 = {1,1,1,1,1,1,1,1}, .i.e., STEP
            // EXPECTED OUTPUT: THE LAST OUTPUT OBTAINED AS A CONTINUITY SHOULD BE 
            //                  SUMMATION OF ALL THE COEFFICIENTS OF FIR FILTERS

            begin
                 clk <= 0;
                 addr <= 0;
                 rstFIR <= 1;
                 write <= 1;
                 c0 <= 8'd1;
                 c1 <= 8'd1;  
                 c2 <= 8'd1;
                 c3 <= 8'd1;
                 c4 <= 8'd1; 
                 c5 <= 8'd1;
                 c6 <= 8'd1;
                 c7 <= 8'd1;   

                 #20 {rstFIR,write} <= 0;                 
 
                 for(i = 0; i<8; i = i + 1)
                 begin
                       addr <= i;
                       #20;
                 end
                 
                 #60;
                 
            end
           
            // CHECKING TOP LEVEL MODULE FIR:
            // INPUT: rstFIR = 1, write = 1 , #10 {rstFIR,write} <= 0
            //        c0,c1,c2...c7 = {1,2,3,4,3,2,1,1}, .i.e., IMPULSE
            // EXPECTED OUTPUT: COEFFICIENTS OF FIR FILTERS, i.e. , IMPULSE RESPONSE
            //                  OUTPUT OF FILTER MUST CHANGE ONLY WHEN POSITIVE EDGE
            //                  OF CLOCK ARRIVES

            begin
                 clk <= 0;
                 addr <= 0;
                 rstFIR <= 1;
                 write <= 1;
                 c0 <= 8'd1; c1 <= 8'd2; c2 <= 8'd3;
                 c3 <= 8'd4; c4 <= 8'd3; c5 <= 8'd2;
                 c6 <= 8'd1; c7 <= 8'd1;   

                 #20 {rstFIR,write} <= 0;                 
 
                 for(i = 0; i<4; i = i + 1)
                 begin
                       addr <= i;
                       #20;
                 end
            end
            
            begin
                 rstFIR <= 1;
                 write <= 1;
                 c0 <= 8'd0; c1 <= 8'd0; c2 <= 8'd0;
                 c3 <= 8'd1; c4 <= 8'd0; c5 <= 8'd0;
                 c6 <= 8'd0; c7 <= 8'd0; 
                 addr <= 0;
                 
                 #40 {rstFIR,write} <= 0;
                 
                 for(i = 0; i<6; i = i + 1)
                 begin
                       addr <= i;
                       #20;
                 end      
            end


    end
        
endmodule 
 




















