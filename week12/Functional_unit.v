module ArithmeticCircuit(s1,s0,Cin,Adata,Bdata,Cout);
    input s1,s0,Cin;
    input [3:0] Adata,Bdata;
    output reg [3:0] Cout;
    
    always @(*) begin
        if(~Cin) begin
            case({s1,s0}) 
                2'b00: Cout<=Adata;
                2'b01: Cout<=Adata+Bdata;
                2'b10: Cout<=Adata+(~Bdata);
                2'b11: Cout<=Adata-1;
            endcase 
        end
        else begin
            case({s1,s0})
                2'b00: Cout<=Adata+1;
                2'b01: Cout<=Adata+Bdata+1;
                2'b10: Cout<=Adata+(~Bdata)+1;
                2'b11: Cout<=Adata;
            endcase
        end
    end
endmodule

module LogicCircuit(s1,s0,Adata,Bdata,Cout);
    input s1,s0;
    input [3:0] Adata,Bdata;
    output [3:0] Cout;

    always @(*) begin
        case({s1,s0})
            2'b00: Cout<=A&B;
            2'b01: Cout<=A|B;
            2'b10: Cout<=A^B;
            2'b11: Cout<=~A;
        endcase
    end
endmodule

module MUX2to1(S,D1,D0,OUT);
    input S;
    input [3:0] D1,D0;
    output reg [3:0] OUT;
    always @(*) begin
        if(~S)
            OUT<=D0;
        else    
            OUT<=D1;
    end
endmodule

module Functional_unit(FS,Adata,Bdata,Fout);
    input [3:0] FS,Adata,Bdata;
    output [3:0] Fout;
    wire [3:0] A1,L1;
    
    ArithmeticCircuit U2(FS[2],FS[1],FS[0],Adata,Bdata,A1);
    LogicCircuit U1(FS[1],FS[0],Adata,Bdata,L1);
    MUX2to1 U3(FS[3],L1,A1,Fout);

endmodule
