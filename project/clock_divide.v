module clock_divide(clk,resetn,clk_divided);
    input clk,resetn;
    output reg clk_divided;

    integer count;

    always @(negedge resetn or posedge clk)
    begin
        if(!resetn) begin
            count<=0;
            clk_divided<=0;
        end
    else begin
        count=count+1;
        if(count>=400) begin
            count<=0; clk_divided<=~clk_divided;
        end
    end
end

endmodule