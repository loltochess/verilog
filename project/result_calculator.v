module result_calculator(player1_money,player2_money,game_money,player1_card,player2_card,state,player1_newmoney,player2_newmoney);
    input [3:0] player1_money,player2_money;
    input [3:0] game_money;
    input [5:0] player1_card,player2_card;
    input [7:0] state;
    
    output reg [3:0] player1_newmoney,player2_newmoney;

    always @(*) begin
        if(state==8'b10000000) begin
            if(player1_card>21 && player2_card>21) begin
                player1_newmoney=player1_money;
                player2_newmoney=player2_money;
            end
            else if(player1_card>21) begin
                player1_newmoney=player1_money-game_money;
                player2_newmoney=player2_money+game_money;
            end
            else if(player2_card>21) begin
                player1_newmoney=player1_money+game_money;
                player2_newmoney=player2_money-game_money;
            end
            else if(player1_card==player2_card) begin
                player1_newmoney=player1_money;
                player2_newmoney=player2_money;
            end
            else if(player1_card>player2_card) begin
                player1_newmoney=player1_money+game_money;
                player2_newmoney=player2_money-game_money;
            end
            else if(player1_card<player2_card) begin
                player1_newmoney=player1_money-game_money;
                player2_newmoney=player2_money+game_money;
            end
        end
    end
endmodule

    
