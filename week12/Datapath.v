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

module Datapath(ControlWord,ConstantIn,CLK,DataIn,DataOut,AddressOut,Reg0,Reg1,Reg2,Reg3);
    input [12:0] ControlWord;
    input [3:0] ConstantIn,DataIn;
    input CLK;
    output [3:0] DataOut,AddressOut,Reg0,Reg1,Reg2,Reg3;
    
    wire [1:0] Daddr,Aaddr,Baddr;
    wire MB,MD,Write;

    wire [3:0] Adata,Bdata;
    wire [3:0] Fout;
    wire [3:0] Ddata;

    assign Daddr=ControlWord[12:11];
    assign Aaddr=ControlWord[10:9];
    assign Baddr=ControlWord[8:7];
    assign MB=ControlWord[6];
    assign MD=ControlWord[1];
    assign Write=ControlWord[0];

    MUX21 MuxB(Bdata,ConstantIn,MB,DataOut);
    Functional_unit U2(Daddr,Aaddr,Baddr,Fout);
    MUX21 MuxD(Fout,DataIn,MD,Ddata);
    Register_file R1(CLK,Write,Ddata,Daddr,Aaddr,Baddr,Adata,Bdata,Reg0,Reg1,Reg2,Reg3);

    assign AddressOut=Adata;

endmodule
