// Code your testbench here
// or browse Examples
module tb();
  reg seq_in , rst_n , clk , enb ;
  wire detect ;
  
  integer i ;
  
  reg [15:0] test_seq = 16'b1101_1010_1111_0100 ;
  
  seq_dec_1011 dut(
    .seq_in(seq_in),
    .enb(enb),
    .rst_n(rst_n),
    .clk(clk),
    .detect(detect)
  );
  
  initial begin 
    rst_n = 1'b0;
    seq_in = 0;
    clk = 0;
    enb = 0;
  end
  
  initial begin
    #2 rst_n = 1'b1;
    	enb = 1'b1;
    $monitor("seq_in = %b  , detect = %b , i = %b", seq_in , detect, i );
    
    for (i = 0; i <= 16 ; i = i+1) begin
      
      if(i != 16) begin
      @(posedge clk);
      seq_in = test_seq[i];
      
        
      end else begin
        seq_in = 0 ;
      end
    end
    
    #60 $finish();
    
  end
       
 initial begin
   forever begin
     #0.5 clk = ~clk ;
   end
 end
 
  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(1);
  end
  
endmodule

       
    
      
      
  
  
