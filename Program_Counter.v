module Program_Counter(CLK,PL,JB,BC,LAddress,RAddress,AData,PC);
    input CLK,PL,JB,BC;
    input [1:0] LAddress,RAddress;
    input [3:0] AData;
    output [3:0] PC;

    reg [3:0] PC;

    initial begin
        LAddress<=2'b00;
        RAddress<=2'b00;
        AData<=4'b0000;
        PC<=4'b0000;
    end

    always@(posedge CLK) begin
        if(~PL)
            PC<=PC+4'b0100;
        else if(JB)
            PC<=AData;
        else if(BC) begin
            if(AData<4'b0000)
                PC<=PC+{LAddress[1:0],RAddress[1:0]}
            else
                //
        end
        else if(~BC) begin
            if(AData==4'b0000)
                PC<=PC+{LAddress[1:0],RAddress[1:0]};
            else
            //
        end
    end
endmodule