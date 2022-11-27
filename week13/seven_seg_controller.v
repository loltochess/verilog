module seven_seg_controller(clk,rst,seg1,seg2,seg3,seg4,seg5,seg6,seg7,seg8,data_out,data_en);
  input clk,rst;
  input [6:0] seg1,seg2,seg3,seg4,seg5,seg6,seg7,seg8;
  output reg [6:0] data_en;
  output reg [7:0] data_out;
  integer CNT_SCAN;

  always @(posedge clk or negedge rst)
    begin
      if(!rst)
        begin
          data_out<=8'b00000000;
          data_en<=0;
          CNT_SCAN=0;
        end
      else
        begin
          if(CNT_SCAN==0)
            CNT_SCAN=7;
          else
            CNT_SCAN=CNT_SCAN-1;

          case(CNT_SCAN)
            7: 
              begin
                data_out<=8'b01111111;
                data_en<=seg1;
              end
            6:
              begin
                data_out<=8'b10111111;
                data_en<=seg2;
              end
            5:
              begin
                data_out<=8'b11011111;
                data_en<=seg3;
              end
            4:
              begin
                data_out<=8'b11101111;
                data_en<=seg4;
              end
            3:
              begin
                data_out<=8'b11110111;
                data_en<=seg5;
              end
            2:
              begin
                data_out<=8'b11111011;
                data_en<=seg6;
              end
            1:
              begin
                data_out<=8'b11111101;
                data_en<=seg7;
              end
            0:
              begin
                data_out<=8'b11111110;
                data_en<=seg8;
              end
            default:
              begin
                data_out<=8'b11111111;
                data_en<=seg8;
              end
          endcase
        end
    end
endmodule