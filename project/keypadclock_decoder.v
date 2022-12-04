module keypadclock_decoder(clk,resetn,enable,keypad_clock,setclock_clock,stopwatch_clock,alarm_clock);
    input clk,resetn;
    input [3:0] enable;
    input [23:0] keypad_clock;
    output reg [23:0] setclock_clock,stopwatch_clock,alarm_clock;

    always @(posedge clk or negedge resetn) begin
        if(!resetn)begin
            setclock_clock<=24'b0;
            stopwatch_clock<=24'bx;
            alarm_clock<=24'bx;
        end
        case(enable)
            4'b0100:setclock_clock<=keypad_clock;
            4'b0010:stopwatch_clock<=keypad_clock;
            4'b0001:alarm_clock<=keypad_clock;
        endcase
    end
endmodule