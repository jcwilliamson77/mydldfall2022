module CONTROL (clk, reset, seed, switch, registerval);
    input logic switch;
    input logic reset;
    input logic clk;
    input logic [63:0] seed;
    output logic [63:0] registerval;
    logic [63:0] grid_evolve;
    logic [63:0] grid;
    logic out;

mux2_1 mux(seed, out, grid, registerval);
FSM fsm(clk, reset, switch, out);
datapath datapath(grid, grid_evolve);
register register(clk, reset, grid_evolve, registerval);

endmodule

module mux2_1(FSM, seed, grid_evolve, grid);
    input logic FSM;
    input logic [63:0] seed, grid_evolve;
    output logic [63:0] grid;

    always_comb
        case (FSM)
        0: grid <= seed;
        1: grid <= grid_evolve;
        default: grid <= seed;
        endcase
endmodule

module FSM(clk, reset, switch, out);
    input logic clk, reset, switch;
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

module register(clk, reset, grid_evolve, registerval);
    input logic clk, reset;
    input logic [63:0] grid_evolve;
    output logic [63:0] registerval;

always_ff @(posedge clk, posedge reset)
        if (reset) registerval <= 0;
        else registerval <= grid_evolve; 

  
endmodule