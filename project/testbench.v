`timescale 100ns/1ps
module testbench;
    reg clk,resetn;
    reg switch;
    reg [3:0] enable;
    reg [11:0] keypad_in;
    wire LCD_E;
    wire LCD_RS,LCD_RW;
    wire [7:0] LCD_DATA;

    main m1(clk,resetn,switch,enable,keypad_in,LCD_E,LCD_RS,LCD_RW,LCD_DATA,PIEZO);

    always #5 clk=~clk;

    initial begin
        $dumpfile("clock.vcd");
        $dumpvars(-1,m1);
        clk<=0;
        resetn<=1;
        #300 resetn<=0;
        #100 resetn<=1;
        #10000;
        enable<=4'b0100;//clockset
        #500 keypad_in<=12'b000000000001; //1
        #100000 keypad_in<=12'b0;
        #500 keypad_in<=12'b100000000000; //#
        #100 keypad_in<=12'b0;
        #500 keypad_in<=12'b010000000000; //0
        #100 keypad_in<=12'b0;
        #500 keypad_in<=12'b100000000000; //# :
        #100 keypad_in<=12'b0;
        #500 keypad_in<=12'b000000000010; //2
        #100 keypad_in<=12'b0;
        #500 keypad_in<=12'b100000000000; //#
        #100 keypad_in<=12'b0;
        #500 keypad_in<=12'b000000000100; //3
        #100 keypad_in<=12'b0;
        #500 keypad_in<=12'b100000000000; //# :
        #100 keypad_in<=12'b0;
        #500 keypad_in<=12'b000000001000; //4
        #100 keypad_in<=12'b0;
        #500 keypad_in<=12'b100000000000; //#
        #100 keypad_in<=12'b0;
        #500 keypad_in<=12'b000000010000; //5
        #100 keypad_in<=12'b0;
        #500 keypad_in<=12'b100000000000; //#
        #100 keypad_in<=12'b0;
        #500 keypad_in<=12'b001000000000; //*
        #100 keypad_in<=12'b0;
        #10000 enable<=4'b1000;//clockmode
        #10000 enable<=4'b0001;//alarm
        #500 keypad_in<=12'b000000000001; //1
        #100 keypad_in<=12'b0;
        #500 keypad_in<=12'b100000000000; //#
        #100 keypad_in<=12'b0;
        #500 keypad_in<=12'b010000000000; //0
        #100 keypad_in<=12'b0;
        #500 keypad_in<=12'b100000000000; //# :
        #100 keypad_in<=12'b0;
        #500 keypad_in<=12'b000000000010; //2
        #100 keypad_in<=12'b0;
        #500 keypad_in<=12'b100000000000; //#
        #100 keypad_in<=12'b0;
        #500 keypad_in<=12'b000000000100; //3
        #100 keypad_in<=12'b0;
        #500 keypad_in<=12'b100000000000; //# :
        #100 keypad_in<=12'b0;
        #500 keypad_in<=12'b000000001000; //4
        #100 keypad_in<=12'b0;
        #500 keypad_in<=12'b100000000000; //#
        #100 keypad_in<=12'b0;
        #500 keypad_in<=12'b000100000000; //9
        #100 keypad_in<=12'b0;
        #500 keypad_in<=12'b100000000000; //#
        #100 keypad_in<=12'b0;
        #500 keypad_in<=12'b001000000000; //*
        #100 keypad_in<=12'b0;
        #100000000;
        #30000 switch<=1;
        enable<=4'b1000;
        #100000;
        $finish;
    end
endmodule