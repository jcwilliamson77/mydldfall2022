module FSM (clk, reset, seed, grid, grid_evolve);
    input logic [63:0] grid;
    input logic clk;
    input logic reset;
    input logic [63:0] seed;
    output logic [63:0] grid_evolve;
    logic [63:0] y;
    logic decision;

datapath generation(grid, grid_evolve);

mux mux(seed, grid_evolve, grid, y, decision)

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
        assign grid = seed;
    next_state = S1;
       end
    default: begin
    next_state <= S0;
    end
      endcase
endmodule

module mux(seed, decison, grid, y)
    input logic [63:0] seed, decision, grid_evolve;
    input logic grid;
    output logic [63:0] y;

    assign y = decision?seed:grid;

endmodule