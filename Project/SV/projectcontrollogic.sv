module CONTROL (switch, reset, seed, clk, register_v);
    input logic switch;
    input logic reset;
    input logic [63:0] seed;
    input logic clk;
    output logic [63:0] register_v;
    logic [63:0] grid;
    logic [63:0] grid_evolve;
    logic out;
    
    
fsm fsm(clk, reset, switch, out);
mux2_1 mux(out, seed, register_v, grid);
datapath datapath(grid, grid_evolve);
register register(clk, reset, grid_evolve, register_v);

endmodule

module mux2_1(fsm, seed, grid, grid_evolve);
    input logic fsm;
    input logic [63:0] seed; 
    input logic [63:0] grid;
    output logic [63:0] grid_evolve;

        assign grid_evolve = fsm==1?grid:seed;

    /*always_comb
        case (fsm)
        0: grid <= seed;
        1: grid <= grid_evolve;
        default: grid <= seed;
        endcase*/
endmodule

module fsm(clk, reset, switch, out);
    input logic clk;
    input logic reset; 
    input logic switch;
    output logic out;

    typedef enum logic {S0, S1} statetype;
    statetype current_state, next_state;

    //state register
    always_ff @(posedge clk, posedge reset)
        if (reset) current_state <= S0;
        else current_state <= next_state;

    //next state logic and outputs
    always_comb 
      case (current_state)
       
    S0: begin
        out <= 1'b0;
        if(switch) next_state <= S1;
        else       next_state <= S0;
        end

    S1: begin
        out <= 1'b0;
        if (switch) next_state <= S1;
        else        next_state <= S0;
        end

    default: begin
        next_state <= S0;
        end
      endcase
endmodule

module register(clk, reset, grid_evolve, register_v); //grid_evolve
    input logic clk;
    input logic reset;
    input logic [63:0] grid_evolve; //grid_evolve
    output logic [63:0] register_v;

always_ff @(posedge clk, posedge reset)
        if (reset) register_v <= 0;
        else register_v <= grid_evolve; //grid_evolve

  
endmodule