// Code your testbench here
// or browse Examples
`timescale 1ns/10ps

module data_mux_tb;
  
  reg clk;
  reg symbol_clk;
  reg [7:0] DS1, DS2, DS3;
  wire [2:0] switch_clk_cycles;
  wire [1:0] mode;
  reg [7:0] mux_data;
  
  data_mux UUT (clk, symbol_clk, switch_clk_cycles, DS1, DS2, DS3, mode, mux_data);
  
  localparam period = 20;
    
  assign mode = 2'd3;
  assign switch_clk_cycles = 3'd2;
  
   //100MHz
  initial begin
    forever begin
  		clk = 1'b1;
  		#10 clk = ~clk;
    end
  end
  
  //50MHz
  initial begin
    forever begin
      symbol_clk = 1'b1;
      #period symbol_clk = ~symbol_clk;
    end
  end

  
 initial begin
    DS1 = 8'd3;
   	DS2 = 8'd50;
   	DS3 = 8'd98;
   #(period/3)
    DS1 = 8'd6;
   	DS2 = 8'd53;
   	DS3 = 8'd100;
   #(period/3)
    DS1 = 8'd9;
   	DS2 = 8'd55;
   	DS3 = 8'd120;
   #(period/3)
   $finish;
 end
  
  
 initial 
  begin
    // Required to dump signals to EPWave
    $dumpfile("dump.vcd");
    $dumpvars(0);
  end
  
  
endmodule
    
    
    
    
    
  
  
