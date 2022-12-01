`timescale 10ms/1ps
module testbench;
    reg clk,resetn;
    wire LCD_E;
    wire LCD_RS,LCD_RW;
    wire [7:0] LCD_DATA;

    main m1(clk,resetn,LCD_E,LCD_RS,LCD_RW,LCD_DATA);

    always #5 clk=~clk;

    initial begin
        $dumpfile("clock.vcd");
        $dumpvars(-1,m1);
        clk<=0;
        resetn<=1;
        #3 resetn<=0;
        #1 resetn<=1;
        #30000;
        $finish;
    end
endmodule