module alarm(clk,resetn,switch,enable,alarm_clock,hour,minute,second,PIEZO);
    input clk,resetn;
	input switch;
    input [3:0] enable;
    input [23:0] alarm_clock;
    input [7:0] hour,minute,second;
    output PIEZO;
    reg BUFF;

	parameter C=956,D=851,E=758,F=716,G=638,A=568,B=506;
    integer CNT;
	reg thetime;
	
	always @(posedge clk or negedge resetn)begin
		if(!resetn)begin
			thetime<=0;
			BUFF<=0;
			CNT<=0;
		end
		else if(switch==1)begin
			BUFF<=0;
			CNT<=0;
			thetime<=0;
		end
		else if(thetime)begin
			if(CNT>=500)begin
				CNT<=0;
				BUFF=~BUFF;
			end
			else
				CNT<=CNT+1;
		end
		else if(alarm_clock=={hour,minute,second})begin
			thetime<=1;
		end
		else begin
			CNT<=CNT;
			BUFF<=BUFF;
		end
		
	end

    assign PIEZO=BUFF;

endmodule