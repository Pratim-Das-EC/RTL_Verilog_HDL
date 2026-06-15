// Code your design here
//Designer : Pratim Das
//Module : Asynchronous FIFO
`timescale 1us/1ns
module fifo_async

#(parameter FIFO_DEPTH = 8 , FIFO_WIDTH = 8)

  (input clk_wr , clk_rd ,  wr_enb , rd_enb , rst_n , input [FIFO_WIDTH-1:0] d_in , output reg [FIFO_WIDTH-1:0]  d_out , output reg full , empty);

localparam FIFO_ptr = $clog2(FIFO_DEPTH);

reg [FIFO_ptr:0] rd_ptr , wr_ptr ,rd_ptr_gry , wr_ptr_gry , rd_ptr_gry_sync ,wr_ptr_gry_sync,rd_ptr_gry_sync_bin,wr_ptr_gry_sync_bin ;

  reg [FIFO_ptr:0] rd_sync_intm , wr_sync_intm;

reg [FIFO_WIDTH-1:0] mem [FIFO_DEPTH-1:0];

integer i,j,k,l ;

// rd_ptr binary to gery conversion block || rd_ptr --> rd_ptr_gry 

always @(*) begin
  rd_ptr_gry = rd_ptr^(rd_ptr>>1);
end

//wr_ptr binary to grey conversion block || wr_ptr --> wr_ptr_gry

always @(*) begin
  wr_ptr_gry = wr_ptr^(wr_ptr>>1);
end

//rd_ptr_gry --> ff1--> rd_sync_intm --> ff2 --> rd_ptr_gry_sync

always @(posedge clk_rd or negedge rst_n) begin
  
  if(!rst_n)begin
    rd_ptr_gry_sync <= 0;
    rd_sync_intm     <= 0;
  end
  else begin
  rd_sync_intm <= rd_ptr_gry;
  rd_ptr_gry_sync <= rd_sync_intm;
  end
end


//wr_ptr_gry --> ff1--> wr_sync_intm --> ff2 --> wr_ptr_gry_sync

always @(posedge clk_wr or negedge rst_n) begin
  if(!rst_n) begin
    wr_ptr_gry_sync <= 0;
    wr_sync_intm    <= 0;
  end
  else begin
  wr_sync_intm <= wr_ptr_gry;
  wr_ptr_gry_sync <= wr_sync_intm;
  end
end

//write handler will convert rd_ptr_gry_sync into rd_ptr_gry_sync_bin

always @(*) begin
  rd_ptr_gry_sync_bin[FIFO_ptr] = rd_ptr_gry_sync[FIFO_ptr];
  
  for(i=FIFO_ptr-1 ;i>= 0 ; i=i-1) begin
    rd_ptr_gry_sync_bin[i] =  rd_ptr_gry_sync_bin[i+1]^rd_ptr_gry_sync[i];
  end
end

//read handler will convert wr_ptr_gry_sync into wr_ptr_gry_sync_bin

always @(*) begin
  wr_ptr_gry_sync_bin[FIFO_ptr] = wr_ptr_gry_sync[FIFO_ptr];
  
  for(j=FIFO_ptr-1 ;j>= 0 ; j=j-1) begin
    wr_ptr_gry_sync_bin[j] =  wr_ptr_gry_sync_bin[j+1]^wr_ptr_gry_sync[j];
  end
end

//  fifo logic for full empty  


always @(posedge clk_rd or negedge rst_n) begin
  if (!rst_n) begin
    rd_ptr <= 0;
    d_out  <= 0;
  end
  else if (rd_enb && !empty) begin
    d_out  <= mem[rd_ptr[FIFO_ptr-1:0]];
    rd_ptr <= rd_ptr + 1;
  end
end
  

    
  always @(posedge clk_wr or negedge rst_n) begin
  if(!rst_n) begin
    wr_ptr <= 0;
    for(l=0; l<FIFO_DEPTH ; l = l+1) begin
      mem[l] <= 0 ;
    end
  end 
      else if( wr_enb && !full) begin
        mem[wr_ptr[FIFO_ptr-1:0]]<= d_in;
        wr_ptr <= wr_ptr + 1 ;
      end
    end
  
  
  assign empty =(rd_ptr == wr_ptr_gry_sync_bin);
  assign full = (wr_ptr[FIFO_ptr-1:0] == rd_ptr_gry_sync_bin[FIFO_ptr-1:0]) &&(wr_ptr[FIFO_ptr]!= rd_ptr_gry_sync_bin[FIFO_ptr]);

endmodule


