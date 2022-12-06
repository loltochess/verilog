module main(clk,resetn,switch,enable,keypad_in,LCD_E,LCD_RS,LCD_RW,LCD_DATA,PIEZO);
    input clk,resetn;
    // 4'b0000 MAIN 4'b1000 CLOCK 4'b0100 CLOCK STOP & SET CLOCK 4'b0010 STOPWATCH 4'b0001 ALARM
    input switch;
    input [3:0] enable;
    input [11:0]keypad_in;
    output LCD_E;
    output LCD_RS,LCD_RW;
    output [7:0] LCD_DATA;
    output PIEZO;
    
    wire [23:0] keypad_clock,setclock_clock,stopwatch_clock,alarm_clock;
    wire [7:0] hour,minute,second;
    wire clk_divided;
    wire pushed;
    
    alarm al1(clk,resetn,switch,enable,alarm_clock,hour,minute,second,PIEZO);
    keypadclock_decoder kdec1(clk,resetn,enable,keypad_clock,setclock_clock,stopwatch_clock,alarm_clock);
    clock_divide cd1(clk,resetn,clk_divided);
    clock clock1(clk_divided,resetn,enable,setclock_clock[23:16],setclock_clock[15:8],setclock_clock[7:0],hour,minute,second);
    keypad kp1(resetn,clk,enable,keypad_in,keypad_clock[23:16],keypad_clock[15:8],keypad_clock[7:0],PIEZO);
    textlcd lcd1(clk,resetn,enable,stopwatch_clock,alarm_clock,hour,minute,second,LCD_E,LCD_RS,LCD_RW,LCD_DATA);
    
endmodule