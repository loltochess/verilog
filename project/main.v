module main(clk,resetn,LCD_E,LCD_RS,LCD_RW,LCD_DATA);
    input clk,resetn;
    output LCD_E;
    output LCD_RS,LCD_RW;
    output [7:0] LCD_DATA;

    wire [4:0] h;
    wire [5:0] m,s;
    wire [7:0] hour,minute,second;
    wire clk_divided;
    
    clock_divide cd1(clk,resetn,clk_divided);
    clock clock1(clk_divided,resetn,hour,minute,second);
    textlcd lcd1(clk,resetn,hour,minute,second,LCD_E,LCD_RS,LCD_RW,LCD_DATA);

endmodule