`timescale 1ns / 1ps
module stimulus ();

   logic  clk;
   logic  reset;
   logic [63:0] grid;
   logic [63:0] grid_evolve;
   logic [63:0] seed;
   
   
   integer handle3;
   integer desc3;

   assign seed = 64'h0412_6424_0034_3C28;
   
   // Instantiate DUT
   projectcontrollogic dut (clk, reset, seed, grid, grid_evolve);   
   
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
	#5 $fdisplay(desc3, "%b || %b %b", reset, grid, grid_evolve);
     end   
   
   initial 
     begin      
	#0   reset = 1'b1;
	#50  reset = 1'b0;	
	#100   seed = 64'h0412_6424_0034_3C28;
     end

endmodule // FSM_tb

