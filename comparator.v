// comparator module
// designed by: Pratim Das
// Date 12.05.2026




// comparator block 

/*module compare_4bit_lower(input [3:0] a_comp , b_comp ,input [8:0] c_check , output reg [10:0] comp_out);
  always @(posedge clk) begin
    if(c_check > 62 && c_check < 99) begin
    if(a_comp > b_comp) begin // A_lower 4 bit is greater than B_lower 4 bit
      comp_out = 11'b000_0001_0000;
    end
    else if( a_comp < b_comp) begin
      comp_out = 11'b000_0000_0001;
    end
    else
      comp_out = 11'b000_0000_0000;
    end
  end
endmodule
*/

`timescale 1us/1ns
module compare_4bit_lower(input [8:0] c, input rst_n ,input enb_com, input clk, input [3:0] a_comp,b_comp,input [8:0] c_check, output reg [10:0] comp_out);
  
  reg [10:0] comp_int_out ;
  
  always @(*) begin
    if(enb_com) begin
      if(c_check >= 64 && c_check < 99 && rst_n)
    comp_out <= comp_int_out ;
    end
  end
  

always @(*)begin
  if(enb_com) begin
    if(c_check >= 64 && c_check < 99 && rst_n)begin
    if(a_comp > b_comp) begin
      comp_int_out = 11'b000_0001_0000;
    end
    else if(a_comp < b_comp) begin
      comp_int_out = 11'b000_0000_0001;
    end
    else if(a_comp === b_comp)
      comp_int_out = 11'b000_0000_0000;
  end
  end
end

  
  
endmodule