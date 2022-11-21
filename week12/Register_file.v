module DECODER2to4(A0,A1,D0,D1,D2,D3);
    input A0,A1;
    output reg D0,D1,D2,D3;
    reg [3:0] D={D3,D2,D1,D0};

    always @(*) begin
        case({A1,A0})
            2'b00: D<=4'b0001;
            2'b01: D<=4'b0010;
            2'b10: D<=4'b0100;
            2'b11: D<=4'b1000;
        endcase
    end
endmodule

module MUX21(DataA,DataB,SEL,OUT);
    input [3:0] DataA,DataB;
    input SEL;
    output reg [3:0] OUT;

    always @(*) begin
        if(~SEL) begin
            OUT<=DataA;
        else
            OUT<=DataB;
        end
    end
endmodule

module MUX4to1(s0,s1,D3,D2,D1,D0,OUT);
    input s0,s1;
    input [3:0] D3,D2,D1,D0;
    output reg [3:0] OUT;

    always @(*) begin
        case({s0,s1})
            2'b00: OUT<=D0;
            2'b01: OUT<=D1;
            2'b10: OUT<=D2;
            2'b11: OUT<=D3;
        endcase
    end
endmodule

module Register_file(CLK,Write,Data,Daddr,Aaddr,Baddr,Adata,Bdata,Reg0,Reg1,Reg2,Reg3);
    input CLK,Write;
    input [3:0] Data;
    input [1:0] Daddr, Aaddr, Baddr;
    output [3:0] Adata,Bdata,Reg0,Reg1,Reg2,Reg3;
    wire [3:0] D_IN;
    wire [3:0] out03,out02,out01,out00,out13,out12,out11,out10;
    reg [3:0] D3,D2,D1,D0;

    DECODER2to4 dec1(Daddr[0],Daddr[1],D_IN);
    MUX4to1 MuxA(Aaddr[0],Aaddr[1],D3,D2,D1,D0,Adata);
    MUX4to1 MuxB(Baddr[0],Baddr[1],D3,D2,D1,D0,Bdata);
    
    MUX21 reg3_3_0(D3,Data,D_IN[3],out03);
    MUX21 reg2_3_0(D2,Data,D_IN[2],out02);
    MUX21 reg1_3_0(D1,Data,D_IN[1],out01);
    MUX21 reg0_3_0(D0,Data,D_IN[0],out00);

    MUX21 reg3_7_4(D3,Data,out03,Write,out13);
    MUX21 reg2_7_4(D2,Data,out02,Write,out12);
    MUX21 reg1_7_4(D1,Data,out01,Write,out11);
    MUX21 reg0_7_4(D0,Data,out00,Write,out10);

    always @(posedge CLK) begin
        D3<=out13;
        D2<=out12;
        D1<=out11;
        D0<=out10;
    end
    
    assign Reg3=D3;
    assign Reg2=D2;
    assign Reg1=D1;
    assign Reg0=D0;

endmodule
