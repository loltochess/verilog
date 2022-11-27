`timescale 10ns/1ps
module keypad_tb();
    reg clk,rst;
    reg [11:0] keypad_in;
    wire [7:0] data_out;
    wire [6:0] data_en;

    always #5 clk=~clk;

    keypad k1(clk,rst,keypad_in,data_out,data_en);

    initial begin
        $dumpfile("keypad.vcd");
        $dumpvars(-1,k1);
        clk<=0;
        rst<=1;
        #1 rst<=0;
        #1 rst<=1;
        #3 keypad_in<=12'b0000_0000_0001;
        #10 keypad_in<=0;
        #20 keypad_in<=12'b1000_0000_0000;
        #10 keypad_in<=0;
        #20 keypad_in<=12'b0000_0000_0010;
        #10 keypad_in<=0;
        #30 keypad_in<=12'b0100_0000_0000;
        #10 keypad_in<=0;
        #500
        $finish;
    end

endmodule