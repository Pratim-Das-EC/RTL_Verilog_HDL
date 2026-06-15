
// clock divider module
// designed by: Pratim Das
// Date 12.05.2026


//frequency divider block
`timescale 1us/1ns
module freq_divider(input clk ,input enb_clk,rst_n_freq_div ,input [8:0] c_check,
                          output reg divided_clk);
  
  reg [2:0] count ;
  always @(posedge clk) begin
    
    if(rst_n_freq_div && c_check < 9'd64 )begin  
     if(count < 3'b101)
    count <= count + 1'b1;
    else
      count <=0;
    end
    else
      count <=0;  
  end
  
  assign divided_clk = count[2];
  
endmodule
