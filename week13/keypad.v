module regreg(clk,rst,en,in,out);
    input clk,rst,en;
    input [6:0] in;
    reg [6:0] sram;
    output [6:0] out;

    always @(posedge clk or negedge rst) begin
        if(!rst) 
            sram<=0;
        else begin
            if(en)
                sram<=in;
        end
    end
    assign out=sram;
endmodule

module keypad(clk,rst,keypad_in,data_out,data_en);
    input clk,rst;
    input [11:0] keypad_in;
    output [7:0] data_out;
    output [6:0] data_en;

    wire [11:0] scan_out;
    wire valid;
    wire [6:0] seg1,seg2,seg3,seg4,seg5,seg6,seg7,seg8;
    wire out_en;
    wire [6:0] out1,out2,out3,out4,out5,out6,out7,out8;


    keypad_scan ks1(clk,rst,keypad_in,scan_out,valid);
    display d1(clk,rst,scan_out,valid,seg1,seg2,seg3,seg4,seg5,seg6,seg7,seg8,out_en);
    regreg r1(clk,rst,out_en,seg1,out1);
    regreg r2(clk,rst,out_en,seg2,out2);
    regreg r3(clk,rst,out_en,seg3,out3);
    regreg r4(clk,rst,out_en,seg4,out4);
    regreg r5(clk,rst,out_en,seg5,out5);
    regreg r6(clk,rst,out_en,seg6,out6);
    regreg r7(clk,rst,out_en,seg7,out7);
    regreg r8(clk,rst,out_en,seg8,out8);
    seven_seg_controller ssc1(clk,rst,out1,out2,out3,out4,out5,out6,out7,out8,data_out,data_en);

endmodule