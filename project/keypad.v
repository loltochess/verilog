module keypad(rst, clk, enable,keypad_in, h,m,s,PIEZO);
  input rst,clk;
  input [3:0] enable;//4'b0100 clock을 멈추고 동작!
  input [11:0]keypad_in;
  output [7:0] h,m,s;
  output PIEZO;

  
  wire [11:0]scan_out;
  wire valid;
  wire [3:0]r0,r1,r2,r3,r4,r5;
  wire en;
  
  keypad_scan KS(rst, clk, enable,keypad_in, scan_out, valid);
  piezo P1(clk, rst, valid, scan_out, PIEZO);
  display DP(rst, clk, enable,scan_out, valid, r0,r1,r2,r3,r4,r5, en);
  register RG1(clk, rst, r0, en, h[7:4]);
  register RG2(clk, rst, r1, en, h[3:0]);
  register RG3(clk, rst, r2, en, m[7:4]);
  register RG4(clk, rst, r3, en, m[3:0]);
  register RG5(clk, rst, r4, en, s[7:4]);
  register RG6(clk, rst, r5, en, s[3:0]);

endmodule