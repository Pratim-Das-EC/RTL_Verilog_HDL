// Code your testbench here
// or browse Examples
`timescale 1s/1ms
module tb();
  
  parameter time1 = 18;
  
  reg clk , rst_n ;
 
  wire  RED_N , YELLOW_N , GREEN_N , RED_S , YELLOW_S , GREEN_S ,RED_E , YELLOW_E , GREEN_E ,RED_W , YELLOW_W , GREEN_W;
  
  
  traffic_light_controller #(.time1(time1))
  								
  								test (.clk(clk), 
                          	   .rst_n(rst_n), 
                               .RED_N(RED_N) , 
                               .YELLOW_N(YELLOW_N), 
                               .GREEN_N(GREEN_N) , 
                               .RED_S(RED_S) , 
                               .YELLOW_S(YELLOW_S) , 
                               .GREEN_S(GREEN_S) ,
                               .RED_E(RED_E) , 
                               .YELLOW_E(YELLOW_E) , 
                               .GREEN_E(GREEN_E) ,
                               .RED_W(RED_W) ,
                               .YELLOW_W(YELLOW_W) , 
                               .GREEN_W(GREEN_W));
                          
 initial begin
   clk = 1'b0 ;
   forever begin
     #0.5 clk = ~clk ;
   end
 end
  
  initial begin
    rst_n = 1'b0;
    #2 rst_n = 1'b1;
  end
  
   initial begin
    $dumpfile("waveform.vcd");
     $dumpvars(0, tb);
  end
  
  
  initial begin 
    #200 $finish();
  end
endmodule 
