module blackjack(clk,clr,player1_en,player2_en,player1_go,player1_stop,player2_go,player2_stop,player1_card,player2_card,player1_surrender,player2_surrender);
  input clk,clr,player1_en,player2_en;
  input player1_go,player1_stop,player2_go,player2_stop;
  output reg [5:0] player1_card,player2_card;
  output reg player1_surrender,player2_surrender;


  always @(posedge clk) begin
    if(clr) begin
      player1_card<=$urandom%23;
      player2_card<=$urandom%23;
      player1_surrender<=0;
      player2_surrender<=0;
    end
  end

  always @(*) begin
    if(player1_surrender==0 && player1_en==1 && player1_go==1 && player1_stop==0) begin
      player1_card=player1_card+&urandom%12;
    end
    else if(player1_en==1 && player1_stop==1) begin
      player1_surrender=1;
    end
    else if(player2_surrender==0 && player2_en==1 && player2_go==1 && player2_stop==0) begin
      player2_card=player2_card+$urandom%12;
    end
    else if(player2_en==1 && player2_stop==1) begin
      player2_surrender=1;
    end
  end

  always @(*) begin
    if(clr==0 && player1_card > 21) 
      player1_surrender=1;
    if(clr==0 && player2_card > 21)
      player2_surrender=1;
  end

endmodule
