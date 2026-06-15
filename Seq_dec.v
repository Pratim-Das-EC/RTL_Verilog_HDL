// Code your design here
module seq_dec_1011(input seq_in,rst_n,clk,enb , output reg detect) ;
  

  parameter [1:0]	starting = 2'b00,
  					s1       = 2'b01,
  					s10	     = 2'b10,
  					s101     = 2'b11;
  
 	
  reg [1:0] state ;
  reg [1:0] next_state;
  
  always @(*) begin
    
    detect = 1'b0 ;
    
    if(!enb) begin
      state = starting;
    end
    else begin
      case(state) 
        starting 	:  next_state 	= (seq_in == 1)? s1 	: starting ;
        s1 			:  next_state 	= (seq_in == 0)? s10 	: s1 ; 
        s10 		:  next_state	= (seq_in == 1)? s101	: starting ; 
        s101 		:  if(seq_in == 1) begin
          					next_state = s1 ;
          					detect = 1'b1 ;
                       end else begin
                         next_state = s10;
                       end
        
        default 	: next_state = starting ;
          
       endcase
       
      end    
          
    end
          
    always @(posedge clk or negedge rst_n) begin
      if(!rst_n) state <= starting;
      else state <= next_state;
   end
        
endmodule    
        
        
        
        
          
  
  
