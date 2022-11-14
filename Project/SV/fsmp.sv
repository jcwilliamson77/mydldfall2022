   module FSM (clk, reset, Left, Right, y);

   input logic  clk;
   input logic  reset;
   input logic 	Left;
   input logic  Right;
   
   
   output logic [5:0] y;

   typedef enum 	logic [3:0] {S0, S1, S2, S3, S4, S5, S6, S7, S8, S9} statetype;
   statetype state, nextstate;
   
   // state register
   always_ff @(posedge clk, posedge reset)
     if (reset) state <= S0;
     else       state <= nextstate;
   
   // next state logic
   always_comb
     case (state)
       S0: begin
	  y <= 6'b000_000;	  
	  if (reset) nextstate <= S0;
    else if (Left && Right) nextstate <= S7;
    else if (Left) nextstate <= S1;
    else if (Right) nextstate <= S4;
	  else   nextstate <= S0;
       end
       S1: begin
	  y <= 6'b001_000;	  	  
	  if (~reset) nextstate <= S2;
	  else   nextstate <= S0;
       end
       S2: begin
	  y <= 6'b011_000;	  	  
	  if (~reset) nextstate <= S3;
	  else   nextstate <= S0;
       end
       S3: begin
	  y <= 6'b111_000;	  	  
	  if (~reset) nextstate <= S0;
	  else   nextstate <= S0;
       end
       S4: begin
	  y <= 6'b000_100;	  	  
	  if (~reset) nextstate <= S5;
	  else   nextstate <= S0;
       end
       S5: begin
	  y <= 6'b000_110;	  	  
	  if (~reset) nextstate <= S6;
	  else   nextstate <= S0;
       end
       S6: begin
	  y <= 6'b000_111;	  	  
	  if (~reset) nextstate <= S0;
	  else   nextstate <= S0;
       end
       S7: begin
	  y <= 6'b001_100;	  	  
	  if (~reset) nextstate <= S8;
	  else   nextstate <= S0;
       end
       S8: begin
	  y <= 6'b011_110;	  	  
	  if (~reset) nextstate <= S9;
	  else   nextstate <= S0;
       end
       S9: begin
	  y <= 6'b111_111;	  	  
	  if (~reset) nextstate <= S0;
	  else   nextstate <= S0;
       end
       default: begin
	  y <= 6'b000_000;	  	  
	  nextstate <= S0;
       end
     endcase
   
endmodule