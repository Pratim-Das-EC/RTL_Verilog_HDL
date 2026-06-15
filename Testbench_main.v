`timescale 1us/1ns

module tb_all;
  
  reg clk,rst_n;
  reg [9:0] A,B;
  reg [8:0] c,c_chk;
  wire [10:0] out;
  
    assignment_05_11 dut(
  .A(A),
  .B(B),
  .c(c),
  .clk(clk),
  .rst_n(rst_n),
  .out(out)
);

  
  reg[3:0] a_in , b_in;
  
  
  always @(*) begin
    a_in = A[3:0];
    b_in = B[3:0];
  end
  
  
  
  reg [2:0] counter;
  //block for c_chk========================================================
  always @(*) begin
    c_chk = c[6:0] + c[8:2];
  end
  //rst_n==================================================================
  initial begin
    rst_n = 0;
    #1;
    rst_n = 1;
  end
  
 //block for clock ========================================================
  initial begin
    clk = 1'b0;
    forever begin
      #0.5 clk = ~clk;
    end
  end
  //block for c generation ================================================
  initial begin
    
    #1.3 c=0;
    forever begin
      if(c < 9'd256)
      #1  c = c + 1'b1;
      else
        rst_n = 1'b0;
    end
  end
  //block for A,B========================================================== 
    initial begin
      
      #1.3 {A,B} = 0;
      forever begin
    
      #1  {A,B} = $random();
      end
    end
  //counter needed for clk divder==========================================
  reg  count_int;
  initial begin
  end
  always @(posedge clk) begin
    if(rst_n && c_chk < 9'd64)begin
      if(counter < 3'b101)
      counter <= counter + 1'b1;
    else
      counter <= 0 ;
    end
    else
      counter <= 0 ;
  end
  always @(*) begin
    count_int = counter[2];
  end
  // function block to generate output =====================================
  
  function [10:0] self_check(input [9:0] A,B,
                             input [8:0] c,c_chk,
                             input count_int);    

begin     
  if (!rst_n)
    self_check = 11'b000_0000_0000;

  // Highest priority → c_chk < 64
  else if (c_chk < 64)
    self_check = {11{count_int}};

  // Next → comparator region
  else if (c_chk >= 65 && c_chk < 99) begin
    if (c < 128) begin
      if (A[3:0] === B[3:0])
        self_check = 0;
      else
        self_check = (A[3:0] > B[3:0]) ? 11'd16 : 11'd1;
    end
    else
      self_check = 11'bx;   // optional (inactive region)
  end

  // XOR region (only after c_chk conditions are done)
  else if (c_chk >= 99) begin
    if (c < 128)
      self_check = {1'b0, (A ^ B)};
    else
      self_check = A + B;
  end
end

  endfunction

  //compare task ==========================================================
  integer pass_counter = 0;
  integer fail_counter = 0;
  
  task compare(input [10:0] self_check , input [10:0] out);
    begin
      if(self_check === out) begin
        pass_counter = pass_counter + 1 ;
        $display("||c=%d||c_chk=%d||pass_counter=%d||fail_counter=%d",c,c_chk,pass_counter,fail_counter);
      end
      else begin
        fail_counter = fail_counter + 1 ;
        $display("||c=%d||c_chk=%d||pass_counter=%d||fail_counter=%d",c,c_chk,pass_counter,fail_counter);
      end
    end
  endtask
  //compare call ============================================================
  reg [10:0] expected;
  
  always @(posedge clk) begin
    if(rst_n)
      expected =self_check(A,B,c,c_chk,count_int);
  end
  
 
  always @(posedge clk)begin
    if(rst_n)
    compare(expected,out);
  end
  
  
 //dumpars files================================================================= 
    initial begin
    $dumpfile("waveform.vcd");
      $dumpvars(0,tb_all);
  end
  
  //final output show ========================================================
  initial begin
  @(posedge clk);
    wait (c_chk == 9'd190);
 
  $display("--------------------------------------------------------------------------------");
  $display("--------------------------------------------------------------------------------");
    
  $display("The Final report for clk divider for c[6:0] + c[8:2] < 63 is shown below");
    
  $display("--------------------------------------------------------------------------------");
  $display("--------------------------------------------------------------------------------");
    
  $display("|| C = %0d || c_chk = %0d || passed cases = %0d || failed cases = %0d",c,c_chk,pass_counter,fail_counter);
    
  $display("--------------------------------------------------------------------------------");
  $display("--------------------------------------------------------------------------------");
  $finish();
end
endmodule
  
  
  
        
        
    
  
    
  
    
        
    