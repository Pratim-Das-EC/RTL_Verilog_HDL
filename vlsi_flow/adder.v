// addition module
// designed by: Pratim Das
// Date 12.05.2026

//addition block
/*
module addition(input clk ,input [9:0] a , b ,input [8:0] c, output reg [10:0] c_out_add);
  always @(posedge clk) begin
    
    if(c > 128) begin
      c_out_add = a + b;
    end
    else
      c_out_add = c_out_add;
  end
  
  
endmodule

*/
`timescale 1us/1ns
module adder(input rst_n ,input enb_add, input clk ,input [9:0] a_add,b_add,input [8:0] c, c_check, output reg [10:0] c_out_add);
  
  reg [10:0] add_int_out;
  
  always @(*) begin
    if(enb_add) begin
    if( c > 128 && rst_n)
    c_out_add <= add_int_out;
  end
  end
  always @(*)begin
      if(enb_add) begin
      if( c > 128 && rst_n)
      add_int_out = a_add + b_add;
  end
  end
  
  
endmodule