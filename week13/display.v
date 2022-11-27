module display(clk,rst,scan_data,valid,seg1,seg2,seg3,seg4,seg5,seg6,seg7,seg8,out_en);
    input clk,rst,valid;
    input [11:0] scan_data;
    output [6:0] seg1,seg2,seg3,seg4,seg5,seg6,seg7,seg8;
    output reg out_en;
    reg [6:0] num[0:9];
    reg [6:0] r[0:7];
    reg [11:0] r8;
    reg [3:0] r9;
    integer i;

    // 1~9 and 0 seven segment
    initial begin
    num[0]=7'b0110000;
    num[1]=7'b1101101;
    num[2]=7'b1111001;
    num[3]=7'b0110010;
    num[4]=7'b1011011;
    num[5]=7'b1011111;
    num[6]=7'b1110010;
    num[7]=7'b1111111;
    num[8]=7'b1111011;
    num[9]=7'b0000000;
    end


    always @(posedge clk or negedge rst) begin
        if(!rst) begin
            for(i=0;i<=7;i=i+1)
                r[i]<=0;
            r8<=0;
            r9<=0;
        end
        else if(valid) begin
            r8=scan_data;
            for(i=0;i<=8;i=i+1)begin
                if(r8[i]==1)
                    r[r9]=num[i];
            end
            if(r8[11]==1)
                r9=r9+1;
            if(r8[10]==1)
                out_en=1;
            else
                out_en=0;
        end 
    end


    assign seg1=r[0];
    assign seg2=r[1];
    assign seg3=r[2];
    assign seg4=r[3];
    assign seg5=r[4];
    assign seg6=r[5];
    assign seg7=r[6];
    assign seg8=r[7];

endmodule