module clock(clk,resetn,h,m,s);
    input clk,resetn;
    output [7:0] h,m,s;

    reg [5:0] second,minute;
    reg [4:0] hour;

    always @(posedge clk or negedge resetn) begin
        if(!resetn) begin
            second<=0;
            minute<=0;
            hour<=0;
        end
        else if(clk)begin
            second<=second+1;
            if(second==60) begin
                second<=0;
                minute<=minute+1;
                if(minute==60) begin
                    minute<=0;
                    hour<=hour+1;
                    if(hour==24) begin
                        hour<=0;
                    end
                end
            end
        end
    end

    assign h[7:4]=hour/10;
    assign h[3:0]=hour%10;
    assign m[7:4]=minute/10;
    assign m[3:0]=minute%10;
    assign s[7:4]=second/10;
    assign s[3:0]=second%10;

endmodule