// Code your design here
// Designed by: Pratim Das
// Date: 11/05/2026
// 
//
`include "clock_divider.v" 
`include "xor.v"
`include "adder.v"
`include "comparator.v"

`timescale 1us/1ns
module assignment_05_11(input clk,rst_n,
                        input [9:0] A , B ,
                        input [8:0] c,
                        output reg [10:0] out);
  
  
  reg [8:0] c_check ;
  
  wire freq_out;
  wire [10:0] comp_out;
  wire [10:0] add_out;
  wire [9:0] xor_out; 
  
  reg enb_a,enb_b,enb_c,enb_d;
  
always @(*) begin
  // Default
  enb_a = 0;
  enb_b = 0;
  enb_c = 0;
  enb_d = 0;

  if (c_check < 64) begin
    enb_a = 1;
  end

  else if (c_check >= 64 && c_check <= 98) begin
    enb_a = 1;
    enb_b = 1;
  end

  else if (c_check >= 99 && c < 128) begin
    enb_a = 1;
    enb_b = 1;
    enb_c = 1;
    enb_d = 1;
  end

  else begin
    enb_a = 1;
    enb_b = 1;
    enb_c = 1;
    enb_d = 1;
  end
end

  
  
  
  always @(*) begin
    c_check <= c[6:0] + c[8:2];
  end
  
  
   always @(posedge clk) begin
     
     if(!rst_n)
       out <= 11'b000_0000_0000;
     else if(c_check < 64)
       out <= {11{freq_out}};
     else if((c_check >= 64 && c_check < 99 && rst_n) && c < 128)
       out <= comp_out;
     else if(c < 128 && c_check > 9'd99)
       out <= {1'b0,xor_out};
     else
       out <= add_out;
   end
  
  
  
   

  freq_divider f1(.clk(clk),.rst_n_freq_div(rst_n),.divided_clk(freq_out),.c_check(c_check),.enb_clk(enb_a));
 
  compare_4bit_lower comp(.clk(clk),.a_comp(A[3:0]),.c(c),.rst_n(rst_n),.b_comp(B[3:0]),.c_check(c_check),.comp_out(comp_out),.enb_com(enb_b));

  xor_gate bit_xr(.clk(clk),.a(A),.rst_n(rst_n),.b(B),.c(c),.c_check(c_check),.c_xor_out(xor_out),.enb_x(enb_c));
    
  adder ad1(.clk(clk), .a_add(A),.rst_n(rst_n),.b_add(B),.c(c),.c_check(c_check), .c_out_add(add_out),.enb_add(enb_d));
  
 
     
endmodule 
 




  
  

      
      