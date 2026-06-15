// Code your testbench here
// or browse Examples
`timescale 1us/1ns
module tb();
  parameter FIFO_WIDTH = 8 , FIFO_DEPTH = 16;
  
  reg [7:0] d_in;
  reg clk_wr , clk_rd , rst_n , wr_enb , rd_enb ;
  wire full,empty;
  wire [7:0] d_out;
  
  fifo_async
  #(.FIFO_WIDTH(FIFO_WIDTH),
    .FIFO_DEPTH(FIFO_DEPTH))
  fifo_1(
         .clk_wr(clk_wr),
         .clk_rd(clk_rd),
         .rst_n(rst_n),
    	 .wr_enb(wr_enb),
    	 .rd_enb(rd_enb),
         .d_in(d_in),
         .full(full),
         .empty(empty),
         .d_out(d_out)
        );
  
  //rst block
  initial begin
    rst_n = 0;
    #1 rst_n = 1 ;
  end
  

  
     initial begin
    clk_wr = 1'b1;
    forever begin
      #0.6 clk_wr = ~clk_wr;
    end
  end
  
     initial begin
    clk_rd = 1'b1;
    forever begin
      #1 clk_rd = ~clk_rd;
    end
  end
  
  //data_in and data_out monitoring block
   initial begin
    forever begin
      $monitor("rd_enb=%d, wr_enb=%d, data_out=%d , d_in=%d, full = %d , empty = %d",rd_enb,wr_enb , d_out, d_in ,full, empty );
      
      #2 d_in = $random;
    end
     
  end
  
  //read write block
   initial begin
     wr_enb = 1'b0;
   		forever begin
          #1 wr_enb = $random % 2;
        end
     
  end
  
     initial begin
     rd_enb = 1'b0;
   		forever begin
          #1 rd_enb = $random % 2;
        end
     
  end
  
   initial begin
     $dumpfile("waveform.vcd");
     $dumpvars(0,tb);
     
     #200 $finish();
   
  end
endmodule
