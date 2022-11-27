module keypad_scan(clk,rst,keypad_in,scan_out,valid);
    input clk,rst;
    input [11:0] keypad_in;
    reg pushed;
    output reg [11:0] scan_out;
    output reg valid;

    always @(posedge clk or negedge rst) begin
        if(!rst) begin
            pushed<=0;
            valid<=0;
        end
        else if(valid) begin
            scan_out<=12'bx;
            valid<=0;
        end
        else if(keypad_in==0) begin
            pushed<=0;
        end
        else if(keypad_in>0) begin
            if(pushed==0) begin
                scan_out<=keypad_in;
                valid<=1;
                pushed<=1;
            end
        end
    end

endmodule