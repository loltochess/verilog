module play_controller(clk,nRST,state,clr,player1_en,player2_en,player1_surrender,player2_surrender);
    input clk,nRST,player1_surrender,player2_surrender;
    
    output reg player1_en,player2_en;
    output reg [7:0] state;
    output reg clr=0;
    reg [1:0] current,next;

    parameter idle=2'b00;
    parameter player1=2'b01;
    parameter player2=2'b10;
    parameter endgame=2'b11;

    always @(posedge clk or negedge nRST) begin
        if(nRST)
            current<=idle;
        else
            current<=next;
    end
    
    always @(posedge clk) begin
        if(current==idle) begin
            state=8'b00010000;
            next=player1;
            player1_en=0;
            player2_en=0;
            clr=1;
        end
        if(current==player1) begin
            state=8'b00100000;
            player1_en=1;
            player2_en=0;
            clr=0;
            if(player1_surrender==1 && player2_surrender==1)
                next=endgame;
            else if(player1_surrender==1)
                next=player2;
            else 
                next=player1;
        end
        if(current==player2) begin
            state=8'b01000000;
            player1_en=0;
            player2_en=1;
            clr=0;
            if(player1_surrender==1 && player2_surrender==1)
                next=endgame;
            else if(player1_surrender==1)
                next=player2;
            else 
                next=player1;
        end
        if(current==endgame) begin
            state=8'b10000000;
            player1_en=0;
            player2_en=0;
            clr=0;
        end
    end
endmodule

