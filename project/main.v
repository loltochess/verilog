module main(clk_1Mhz,resetn,switch,enable,keypad_in,LCD_E,LCD_RS,LCD_RW,LCD_DATA,PIEZO);
    input clk_1Mhz,resetn;
    // 4'b0000 MAIN 4'b1000 CLOCK 4'b0100 CLOCK STOP & SET CLOCK 4'b0010 STOPWATCH 4'b0001 ALARM
    input switch;
    input [3:0] enable;
    input [11:0]keypad_in;
    output LCD_E;
    output LCD_RS,LCD_RW;
    output [7:0] LCD_DATA;
    output PIEZO;
    wire PIEZO1,PIEZO2;
    assign PIEZO=PIEZO1|PIEZO2;
    
    wire [23:0] keypad_clock,setclock_clock,stopwatch_clock,alarm_clock;
    wire [7:0] hour,minute,second;
    wire clk_1khz,clk_1hz;
    wire pushed;
    
    alarm al1(clk_1Mhz,resetn,switch,enable,alarm_clock,hour,minute,second,PIEZO1);
    keypadclock_decoder kdec1(clk_1Mhz,resetn,enable,keypad_clock,setclock_clock,stopwatch_clock,alarm_clock);
    clock_divide cd1(clk_1Mhz,resetn,clk_1khz);
    clock_divide cd2(clk_1khz,resetn,clk_1hz);
    clock clock1(clk_1hz,resetn,enable,setclock_clock[23:16],setclock_clock[15:8],setclock_clock[7:0],hour,minute,second);
    keypad kp1(resetn,clk_1Mhz,enable,keypad_in,keypad_clock[23:16],keypad_clock[15:8],keypad_clock[7:0],PIEZO2);
    textlcd lcd1(clk_1khz,resetn,enable,stopwatch_clock,alarm_clock,hour,minute,second,LCD_E,LCD_RS,LCD_RW,LCD_DATA);
    
endmodule