module Control_Unit(CLK,AData,PC,Constant,MB,MD,RW,MW,DA,AA,BA,FS);
    input CLK;
    input [3:0] AData;
    output [3:0] PC,Constant;
    output MB,MD,RW,MW;
    output [1:0] DA,AA,BA;
    output [3:0] FS;
    wire PL,JB,BC;
    wire [3:0] A;
    wire [12:0] Q;
    
    Program_Counter PC1(CLK,PL,JB,BC,DA,BA,A);
    Instruction_Memory IM1(CLK,1'b0,A,13'h0,Q);
    Instruction_Decoder ID1(Q,DA,AA,BA,MB,FS,MD,RW,MW,PL,JB,BC);

    assign PC=A;
    assign Constant={2'b0,Q[1:0]};
endmodule
