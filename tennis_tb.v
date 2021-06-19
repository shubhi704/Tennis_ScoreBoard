`timescale 1ns/1ns

module tennis_tb;

  reg pl1,pl2,rst,clk;
  wire p1_win,p2_win;


 tennis dut(pl1,pl2,rst,clk, p1_win, p2_win );


 initial
  begin 
   clk = 0;
   forever #5 clk = ~clk;
  end

 initial
  begin
   rst = 0;
   #12 rst =1;
   @(negedge clk) pl1 = 1; pl2 =0; 
   #50;
   @(negedge clk) pl1 = 0; pl2 =1; 
   #50;
   @(posedge  clk)  pl1 = 1; pl2 =0; 
   @(posedge  clk)  pl1 = 0; pl2 =1; 
   @(posedge  clk)  pl1 = 1; pl2 =0; 
   @(posedge  clk)  pl1 = 0; pl2 =1; 
   @(posedge  clk)  pl1 = 1; pl2 =0; 
   @(posedge  clk)  pl1 = 0; pl2 =1; 
   @(posedge  clk)  pl1 = 0; pl2 =1; 
   @(posedge  clk)  pl1 = 0; pl2 =1; 
   @(posedge  clk)  pl1 = 0; pl2 =1; 
    
   #10 $finish;
 end

 initial
  begin
    $dumpfile("ten.vcd");
    $dumpvars;
  end

endmodule
    
   
   
  
