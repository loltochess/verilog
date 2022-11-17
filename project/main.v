module main(clk,nRST,player1_raise,player1_call,player2_raise,player2_call,player1_go,player1_stop,player2_go,player2_stop,os_ENS,os_COM,state);
    input clk,nRST;
    input player1_raise,player1_call,player2_raise,player2_call;
    input player1_go,player1_stop,player2_go,player2_stop;

    output [7:0] os_ENS,os_COM;
    output [7:0] state;

    bet_controller()
    betting()
    play_controller()
    blackjack()
    result_calculator()

endmodule
