module textlcd(clk,resetn,enable,hour,minute,second,LCD_E,LCD_RS,LCD_RW,LCD_DATA);

input resetn,clk;
input [3:0] enable;
input [7:0] hour,minute,second;//7:4-> 10자리 3:0 -> 1자리
output LCD_E,LCD_RS,LCD_RW;
output [7:0]LCD_DATA;

reg[127:0] line1_data,line2_data;

wire LCD_E;
reg LCD_RS,LCD_RW;
reg [7:0] LCD_DATA;
reg [2:0] state;


parameter   delay          =3'b000, 
            function_set   =3'b001,
            entry_mode     =3'b010,
            disp_onoff     =3'b011,
            line1          =3'b100,  
            line2          =3'b101,
            delay_t        =3'b110,
            clear_disp     =3'b111;

parameter zero=8'b00110000, one=8'b00110001, two=8'b00110010, three=8'b00110011,
         four=8'b00110100, five=8'b00110101 ,six=8'b00110110, seven=8'b00110111,
         eight=8'b00111000, nine=8'b00111001,
         
         A=8'b01000001, B=8'b01000010, C=8'b01000011, D=8'b01000100,
         E=8'b01000101, F=8'b01000110, G=8'b01000111, H=8'b01001000,
         I=8'b01001001, J=8'b01001010, K=8'b01001011, L=8'b01001100,
         M=8'b01001101, N=8'b01001110, O=8'b01001111, P=8'b01010000,
         Q=8'b01010001, R=8'b01010010, S=8'b01010011, T=8'b01010100,
         U=8'b01010101, V=8'b01010110, W=8'b01010111, X=8'b01011000,
         Y=8'b01011001, Z=8'b01011010,

         blank=8'b00100000,
         colon=8'b00111010;

integer CNT;

always @(negedge resetn or posedge clk)
begin
   if(!resetn) state = delay;
   else
   begin   
      case(state)//line1,line2,delay,clear_disk에 500CNT --> 500hz == 1s
         delay:            if(CNT==70)    state = function_set;
         function_set:     if(CNT==30)    state = disp_onoff;
         disp_onoff:       if(CNT==30)    state = entry_mode;
         entry_mode:       if(CNT==30)    state = line1;
         line1:            if(CNT==20)    state = line2;
         line2:            if(CNT==20)    state = delay_t;
         delay_t:          if(CNT==360)   state = clear_disp;
         clear_disp:       if(CNT==100)   state = line1;
         default:                         state = delay;
      endcase
   end
end


always @(negedge resetn or posedge clk)
begin
   if(!resetn) CNT=0;
   else
      begin   
         case(state)
            delay:          if(CNT>=70)CNT=0;
                           else CNT=CNT+1;
            function_set:    if(CNT>=30)CNT=0;
                           else CNT=CNT+1;
            disp_onoff:      if(CNT>=30)CNT=0;
                           else CNT=CNT+1;
            entry_mode:      if(CNT>=30)CNT=0;
                           else CNT=CNT+1;
            line1:         if(CNT>=20)CNT=0;
                           else CNT=CNT+1;
            line2:         if(CNT>=20)CNT=0;
                           else CNT=CNT+1;
            delay_t:         if(CNT>=360)CNT=0;
                           else CNT=CNT+1;
            clear_disp:    if(CNT>=100)CNT=0;
                           else CNT=CNT+1;
            default:         CNT=0;
         endcase
      end
end

always @(negedge resetn or posedge clk) 
begin
   if(!resetn)
   begin
      line1_data={blank,blank,blank,blank,blank,blank,blank,blank,blank,blank,blank,blank,blank,blank,blank,blank};
      line2_data={blank,blank,blank,blank,blank,blank,blank,blank,blank,blank,blank,blank,blank,blank,blank,blank};
   end
   else
   begin
      if(enable==4'b1000) begin
      line1_data={blank,blank,blank,blank,blank,blank,C,L,O,C,K,blank,M,O,D,E};
      line2_data={blank,blank,blank,blank,blank,blank,blank,blank,zero+{4'b0,hour[7:4]},zero+{4'b0,hour[3:0]},colon,zero+{4'b0,minute[7:4]},zero+{4'b0,minute[3:0]},colon,zero+{4'b0,second[7:4]},zero+{4'b0,second[3:0]}};
      end
      else if(enable==4'b0100) begin
      line1_data={blank,blank,blank,blank,blank,blank,blank,S,E,T,blank,C,L,O,C,K};
      line2_data={blank,blank,blank,blank,blank,blank,blank,blank,zero+{4'b0,hour[7:4]},zero+{4'b0,hour[3:0]},colon,zero+{4'b0,minute[7:4]},zero+{4'b0,minute[3:0]},colon,zero+{4'b0,second[7:4]},zero+{4'b0,second[3:0]}};
      end
   end
end


always @(negedge resetn or posedge clk)
begin
   if(!resetn) begin
      LCD_RS=1'b1;
      LCD_RW=1'b1;
      LCD_DATA=8'b00000000;
   end
   else
      begin   
         case(state)
            function_set:    begin
                              LCD_RS=1'b0;
                              LCD_RW=1'b0;
                              LCD_DATA=8'b00111000;
                           end
            disp_onoff:      begin
                              LCD_RS=1'b0;
                              LCD_RW=1'b0;
                              LCD_DATA=8'b00001100;
                           end
            entry_mode:      begin
                              LCD_RS=1'b0;
                              LCD_RW=1'b0;
                              LCD_DATA=8'b00000110;
                           end
            line1:         begin
                              LCD_RW=1'b0;
                              case(CNT)
                                 0:begin
                                    LCD_RS=1'b0;LCD_DATA=8'b10000000;//address
                                 end 
                                 1:begin
                                    LCD_RS=1'b1;LCD_DATA=line1_data[127:120];
                                 end
                                 2:begin
                                    LCD_RS=1'b1;LCD_DATA=line1_data[119:112];
                                 end
                                 3:begin
                                    LCD_RS=1'b1;LCD_DATA=line1_data[111:104];
                                 end
                                 4:begin
                                    LCD_RS=1'b1;LCD_DATA=line1_data[103:96];
                                 end
                                 5:begin
                                    LCD_RS=1'b1;LCD_DATA=line1_data[95:88];
                                 end
                                 6:begin
                                    LCD_RS=1'b1;LCD_DATA=line1_data[87:80];
                                 end
                                 7:begin
                                    LCD_RS=1'b1;LCD_DATA=line1_data[79:72];
                                 end
                                 8:begin
                                    LCD_RS=1'b1;LCD_DATA=line1_data[71:64];
                                 end
                                 9:begin
                                    LCD_RS=1'b1;LCD_DATA=line1_data[63:56];
                                 end
                                 10:begin
                                    LCD_RS=1'b1;LCD_DATA=line1_data[55:48];
                                 end
                                 11:begin
                                    LCD_RS=1'b1;LCD_DATA=line1_data[47:40];
                                 end
                                 12:begin
                                    LCD_RS=1'b1;LCD_DATA=line1_data[39:32];
                                 end
                                 13:begin
                                    LCD_RS=1'b1;LCD_DATA=line1_data[31:24];
                                 end
                                 14:begin
                                    LCD_RS=1'b1;LCD_DATA=line1_data[23:16];
                                 end
                                 15:begin
                                    LCD_RS=1'b1;LCD_DATA=line1_data[15:8];
                                 end
                                 16:begin
                                    LCD_RS=1'b1;LCD_DATA=line1_data[7:0];
                                 end
                                 default:begin
                                    LCD_RS=1'b1;LCD_DATA=8'b00100000;
                                 end
                              endcase
                           end
            line2:         begin
                              LCD_RW=1'b0;
                              case(CNT)
                                 0:begin
                                    LCD_RS=1'b0;LCD_DATA=8'b11000000;//addressx
                                 end
                                 1:begin
                                    LCD_RS=1'b1;LCD_DATA=line2_data[127:120];
                                 end
                                 2:begin
                                    LCD_RS=1'b1;LCD_DATA=line2_data[119:112];
                                 end
                                 3:begin
                                    LCD_RS=1'b1;LCD_DATA=line2_data[111:104];
                                 end
                                 4:begin
                                    LCD_RS=1'b1;LCD_DATA=line2_data[103:96];
                                 end
                                 5:begin
                                    LCD_RS=1'b1;LCD_DATA=line2_data[95:88];
                                 end
                                 6:begin
                                    LCD_RS=1'b1;LCD_DATA=line2_data[87:80];
                                 end
                                 7:begin
                                    LCD_RS=1'b1;LCD_DATA=line2_data[79:72];
                                 end
                                 8:begin
                                    LCD_RS=1'b1;LCD_DATA=line2_data[71:64];
                                 end
                                 9:begin
                                    LCD_RS=1'b1;LCD_DATA=line2_data[63:56];
                                 end
                                 10:begin
                                    LCD_RS=1'b1;LCD_DATA=line2_data[55:48];
                                 end
                                 11:begin
                                    LCD_RS=1'b1;LCD_DATA=line2_data[47:40];
                                 end
                                 12:begin
                                    LCD_RS=1'b1;LCD_DATA=line2_data[39:32];
                                 end
                                 13:begin
                                    LCD_RS=1'b1;LCD_DATA=line2_data[31:24];
                                 end
                                 14:begin
                                    LCD_RS=1'b1;LCD_DATA=line2_data[23:16];
                                 end
                                 15:begin
                                    LCD_RS=1'b1;LCD_DATA=line2_data[15:8];
                                 end
                                 16:begin
                                    LCD_RS=1'b1;LCD_DATA=line2_data[7:0];
                                 end
                                 default:begin
                                    LCD_RS=1'b1;LCD_DATA=8'b00100000;//
                                 end
                              endcase
                           end
            delay_t:         begin
                              LCD_RS=1'b0;
                              LCD_RW=1'b0;
                              LCD_DATA=8'b00000010;
                           end
            clear_disp:    begin
                              LCD_RS=1'b0;
                              LCD_RW=1'b0;
                              LCD_DATA=8'b00000001;
                           end
            default:         begin
                              LCD_RS=1'b1;
                              LCD_RW=1'b1;
                              LCD_DATA=8'b00000000;
                           end
         endcase
      end
end

assign LCD_E=clk;

endmodule
