
`timescale 1s/1ms
module traffic_light_controller
  
  #(parameter time1 = 4)
  
  (
  
  input  clk,
  input  rst_n,
  output reg RED_N, YELLOW_N, GREEN_N,
  output reg RED_S, YELLOW_S, GREEN_S,
  output reg RED_E, YELLOW_E, GREEN_E,
  output reg RED_W, YELLOW_W, GREEN_W
);

  // state registers
  reg [3:0] state, next_state;

  // parameters (UNCHANGED)
  parameter [3:0]
    red_north    = 4'b0000,
    yellow_north = 4'b0001,
    green_north  = 4'b0010,
    red_south    = 4'b0011,
    yellow_south = 4'b0100,
    green_south  = 4'b0101,
    red_east     = 4'b0110,
    yellow_east  = 4'b0111,
    green_east   = 4'b1000,
    red_west     = 4'b1001,
    yellow_west  = 4'b1010,
    green_west   = 4'b1011;

  integer timer;


  always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
      state <= red_north;
    else
      state <= next_state;
  end

  
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
      timer <= 0;
    else if (timer == 161)
      timer <= 0;
    else
      timer <= timer + 1;
  end

  
  always @(*) begin
    next_state = state;
    
    if( time1 >= 4 && time1 <= 7)begin

    if (timer >= 0   && timer < 51)
      next_state = green_north;
    else if (timer >= 51  && timer < 61)
      next_state = yellow_north;
    else if (timer >= 61  && timer < 101)
      next_state = green_south;
    else if (timer >= 101 && timer < 111)
      next_state = yellow_south;
    else if (timer >= 111 && timer < 131)
      next_state = green_east;
    else if (timer >= 131 && timer < 141)
      next_state = yellow_east;
    else if (timer >= 141 && timer < 151)
      next_state = green_west;
    else
      next_state = yellow_west;
  end
  
  else if( time1 >= 16 && time1 <= 20) begin
    
       if (timer >= 0   && timer < 51)
      next_state = green_south;
    else if (timer >= 51  && timer < 61)
      next_state = yellow_south;
    else if (timer >= 61  && timer < 101)
      next_state = green_north;
    else if (timer >= 101 && timer < 111)
      next_state = yellow_north;
    else if (timer >= 111 && timer < 131)
      next_state = green_east;
    else if (timer >= 131 && timer < 141)
      next_state = yellow_east;
    else if (timer >= 141 && timer < 151)
      next_state = green_west;
    else
      next_state = yellow_west;
    
    
  end else begin
    

	if (timer >= 0   && timer < 35)
    next_state = green_north;

  	else if (timer >= 35 && timer < 40)
    next_state = yellow_north;

  	else if (timer >= 40 && timer < 75)
    next_state = green_south;

  	else if (timer >= 75 && timer < 80)
    next_state = yellow_south;

  	else if (timer >= 80 && timer < 115)
    next_state = green_east;

  	else if (timer >= 115 && timer < 120)
    next_state = yellow_east;

  	else if (timer >= 120 && timer < 155)
    next_state = green_west;

  	else
    next_state = yellow_west;  // 155–160
	end

    
  end

  always @(*) begin
    {RED_N,YELLOW_N,GREEN_N,
     RED_S,YELLOW_S,GREEN_S,
     RED_E,YELLOW_E,GREEN_E,
     RED_W,YELLOW_W,GREEN_W} = 12'b0;

    case (state)
      green_north  : begin GREEN_N  = 1; RED_S    = 1 ; RED_E   = 1 ; RED_W    = 1 ; end
      yellow_north : begin YELLOW_N = 1;  RED_S    = 1 ; RED_E    = 1 ; RED_W   = 1 ; end
      red_north    : RED_N    = 1;

      green_south  : begin GREEN_S  = 1;  RED_N    = 1 ; RED_E    = 1 ; RED_W    = 1 ; end
      yellow_south : begin YELLOW_S = 1;  RED_N    = 1 ; RED_E    = 1 ; RED_W    = 1 ; end
      red_south    : RED_S    = 1;

      green_east   : begin GREEN_E  = 1;  RED_N    = 1 ; RED_S    = 1 ; RED_W    = 1 ; end
      yellow_east  : begin YELLOW_E = 1;	RED_N    = 1 ; RED_S    = 1 ; RED_W    = 1 ; end
      red_east     : RED_E    = 1;

      green_west   : begin GREEN_W  = 1; RED_N    = 1 ; RED_E    = 1 ; RED_S    = 1 ; end
      yellow_west  : begin YELLOW_W = 1; RED_N    = 1 ; RED_E    = 1 ; RED_S    = 1 ; end
      red_west     : RED_W    = 1;
    endcase
  end

endmodule

