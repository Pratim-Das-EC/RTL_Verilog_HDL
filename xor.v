// Xor module
// designed by: Pratim Das
// Date 12.05.2026

//bitwise_xor block
/*
module bitwise_xor(input clk ,input [9:0] a , b ,input [8:0] c,c_chechk, output reg [10:0] c_xor_out)
   always @(posedge clk) begin
    
     if(c < 128 && c_check > 98) begin
      c_xor_out = a ^ b;
    end
    else
      c_xor_out = c_xor_out;
  end
  
endmodule
*/

`timescale 1us/1ns
module xor_gate(input rst_n,input enb_x ,input clk, input [9:0] a,b,input [8:0] c, c_check, output reg [10:0] c_xor_out);
  
  reg [10:0] xor_int_out;
 
 
always @(*) begin
  if(enb_x) begin
  if (c_check > 9'd99) begin
    if (c < 128)
      c_xor_out <= xor_int_out;
  end
  end
end

always @(*) begin
  if(enb_x)begin
  if (c_check > 9'd99) begin
    if (c < 128)
      xor_int_out = a ^ b;
  end
  end
end

  
endmodule