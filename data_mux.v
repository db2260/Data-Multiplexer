// Code your design here
`timescale 1ns/10ps

module data_mux (clk, symbol_clk, switch_clk_cycles, DS1, DS2, DS3, mode, mux_data);
  
  input clk, symbol_clk;
  input [2:0] switch_clk_cycles;
  input [7:0] DS1, DS2, DS3;
  input [1:0] mode;
  output reg [7:0] mux_data;
  
  reg [2:0] cnt = 3'd1;
  
  always begin
    #10 cnt = cnt + 1;
    if(cnt == 3'd7) cnt = 3'd1;
  end
    
  
  always @(posedge symbol_clk) begin
    if(mode == 2'd1 && switch_clk_cycles == 3'd6) begin
      mux_data = DS1;
    end
  end
  
  always @(posedge clk) begin
    if(mode == 2'd2 && switch_clk_cycles == 3'd3) begin
      if(cnt <= switch_clk_cycles)
        mux_data = DS1;
      else if(cnt <= mode*switch_clk_cycles)
        mux_data = DS2;
      else
        mux_data = mux_data;
    end
  end
  
  always @(posedge clk or posedge symbol_clk) begin
    if(mode == 2'd3 && switch_clk_cycles == 3'd2) begin
      if(cnt <= switch_clk_cycles)
        mux_data = DS1;
      else if(cnt <= mode*switch_clk_cycles-switch_clk_cycles)
        mux_data = DS2;
      else if(cnt <= mode*switch_clk_cycles)
        mux_data = DS3;
      else
        mux_data = mux_data;
    end
  end
  
endmodule