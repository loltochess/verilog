module Data_Memory(CLK,WR,A,D_IN,Q);
    input CLK,WR;
    input [3:0] A,D_IN;
    output reg [3:0] Q;
    reg [3:0] SRAM[0:15];

    always @(*) begin
        if(WR) begin
            SRAM[A]<=D_IN;
            Q<=4'bxxxx;
        end
        else begin
            Q<=SRAM[A];
        end
    end
endmodule

module Simple_Computer(CLK,Bdata,Adata,Reg0,Reg1,Reg2,Reg3,OutData,DataIn,ControlWord,Constant,PC);
    input CLK;
    output [3:0] Bdata,Adata,Reg0,Reg1,Reg2,Reg3,OutData,DataIn,Constant,PC;
    output [12:0] ControlWord;

    wire MB,MD,RW,MW,WR;
    wire [1:0] DA,AA,BA;
    wire [3:0] FS,AddressOut,DataOut;
    wire [3:0] A,D_IN,Q;


    assign ControlWord={DA,AA,BA,MB,FS,MD,RW,MW};
    assign A=Adata;
    assign D_IN=DataOut;
    assign Q=OutData;
    

    Control_Unit CU1(CLK,Adata,PC,Constant,MB,MD,RW,MW,DA,AA,BA,FS);
    Datapath DP1(ControlWord,Constant,CLK,DataIn,DataOut,AddressOut,Reg0,Reg1,Reg2,Reg3);
    Data_Memory DM1(1'b0,WR,A,D_IN,Q);

    assign Bdata=DataOut;
    
endmodule

