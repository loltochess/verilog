module add3 (out, in);
  input[3:0] in;
  output reg[3:0] out;
  
  always @(in) begin
    if(in < 5)
      out <= in;
    else if(in < 10)
      out <= in + 3;
    else
      out <= 4'bxxxx;
  end
endmodule

module BCD_to_7_segment(seg,inp);
  input [3:0] inp;
  output reg [7:0] seg;
  
  always @(*) begin
    case(inp) 
      4'd0 : seg=8'b11111100;
      4'd1 : seg=8'b01100000;
      4'd2 : seg=8'b11011010;
      4'd3 : seg=8'b11110010;
      4'd4 : seg=8'b01100110;
      4'd5 : seg=8'b10110110;
      4'd6 : seg=8'b10111110;
      4'd7 : seg=8'b11100100;
      4'd8 : seg=8'b11111110;
      4'd9 : seg=8'b11110110;
      default : seg=8'b00000000;
    endcase
  end
endmodule

module bin_to_bcd(hunds, tens, units, in);
  input[5:0] in;
  output[1:0] hunds;
  output[3:0] tens, units;
  
  wire[3:0] t1, t2, t3, t4, t5;
  
  add3 c1 (t1, {1'b0,in[5:3]});
  add3 c2 (t2, {t1[2:0], in[2]});
  add3 c3 (t3, {3'b0, t1[3]});
  add3 c4 (t4, {t2[2:0], in[1]});
  add3 c5 (t5, {t3[2:0], t2[3]});
  
  assign hunds = {t3[3], t5[3]};
  assign tens = {t5[2:0], t4[3]};
  assign units = {t4[2:0], in[0]};
endmodule

module Binary_to_7_segment(os_COM,os_ENS,CLK,inp,nRST);
  input CLK,nRST;
  input [5:0] inp;
  output [7:0] os_COM,os_ENS;
  wire [3:0] tens,units;
  wire [1:0] hunds;
  wire [7:0] iSEG1,iSEG0;

  bin_to_bcd B1 (hunds,tens,units,inp);
  BCD_to_7_segment SS1(iSEG1,tens);
  BCD_to_7_segment SS0(iSEG0,units);
  SevenSeg_CTRL SSCTRL1 (CLK,nRST,iSEG0,iSEG1,8'b0,8'b0,8'b0,8'b0,8'b0,8'b0,os_COM,os_ENS);
  
endmodule

module SevenSeg_CTRL(
  iCLK,
  nRST,
  iSEG7,
  iSEG6,
  iSEG5,
  iSEG4,
  iSEG3,
  iSEG2,
  iSEG1,
  iSEG0,
  os_COM,
  os_ENS
);

  input iCLK,nRST;
  input [7:0] iSEG7,iSEG6,iSEG5,iSEG4,iSEG3,iSEG2,iSEG1, iSEG0;
  output reg [7:0] os_COM,os_ENS;
  integer CNT_SCAN;

  always @(posedge iCLK)
    begin
      if(nRST)
        begin
          os_COM<=8'b00000000;
          os_ENS<=0;
          CNT_SCAN=7;
        end
      else
        begin
          if(CNT_SCAN>=7)
            CNT_SCAN=0;
          else
            CNT_SCAN=CNT_SCAN+1;

          case(CNT_SCAN)
            0: 
              begin
                os_COM<=8'b11111110;
                os_ENS<=iSEG0;
              end
            1:
              begin
                os_COM<=8'b11111101;
                os_ENS<=iSEG1;
              end
            2:
              begin
                os_COM<=8'b11111011;
                os_ENS<=iSEG2;
              end
            3:
              begin
                os_COM<=8'b11110111;
                os_ENS<=iSEG3;
              end
            4:
              begin
                os_COM<=8'b11101111;
                os_ENS<=iSEG4;
              end
            5:
              begin
                os_COM<=8'b11011111;
                os_ENS<=iSEG5;
              end
            6:
              begin
                os_COM<=8'b10111111;
                os_ENS<=iSEG6;
              end
            7:
              begin
                os_COM<=8'b01111111;
                os_ENS<=iSEG7;
              end
            default:
              begin
                os_COM<=8'b11111111;
                os_ENS<=iSEG7;
              end
          endcase
        end
    end
endmodule
