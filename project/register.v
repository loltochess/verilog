module register(clk, rst, in, en, out);
  input clk, rst, en;
  input [3:0]in;
  output reg [3:0]out;
  
  always@(posedge clk or negedge rst) begin
    if (!rst) begin
      out <= 4'b0;
    end
    else begin
      if (en) out <= in;
      else out<=4'bx;
    end
  end
endmodule