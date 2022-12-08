`timescale 1ns / 1ps
module stimulus ();

   logic  clk;
   logic  reset;
   logic switch;
   logic [63:0] register_v;
   //logic [63:0] grid_evolve;
   logic [63:0] seed;
   
   
   integer handle3;
   integer desc3;

   //assign seed = 64'h0412_6424_0034_3C28;
   
   // Instantiate DUT
   CONTROL dut (switch, reset, seed, clk, register_v);   
   
   // Setup the clock to toggle every 1 time units 
   initial 
     begin	
	clk = 1'b1;
	forever #5 clk = ~clk;
     end

   initial
     begin
	// Gives output file name
	handle3 = $fopen("project.out");
	// Tells when to finish simulation
	#500 $finish;		
     end

   always 
     begin
	desc3 = handle3;
	#5 $fdisplay(desc3, "Switch: %b || Reset: %b \n %b \n %b \n %b \n %b \n %b \n %b \n %b \n %b", 
     switch, reset, register_v[7:0], register_v[15:8], register_v[23:16], register_v[31:24], register_v[39:32], register_v[47:40],
     register_v[55:48], register_v[63:56]);
     end   
   
   initial 
     begin      
	#0   reset = 1'b1;
	#5   reset = 1'b0;	
     #0   switch = 1'b1;
	#0   seed = 64'h0412_6424_0034_3C28;
     end

endmodule // FSM_tb

