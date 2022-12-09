module music_rom(clk,resetn,music_cnt,sound);
	input clk,resetn;
	input [7:0] music_cnt;
	output reg [11:0] sound;

	parameter C=1915,D=1706,E=1519,F=1432,G=1278,A=1136,B=1014;

	always @(posedge clk or negedge resetn)begin
		case(music_cnt)
			0:sound<=G;
			1:sound<=0;
			2:sound<=G;
			3:sound<=0;
			4:sound<=A;
			5:sound<=0;
			6:sound<=A;
			7:sound<=0;
			8:sound<=G;
			9:sound<=0;
			10:sound<=G;
			11:sound<=0;
			12:sound<=E;
			13:sound<=E;
			14:sound<=0;
			15:sound<=G;
			16:sound<=0;
			17:sound<=G;
			18:sound<=0;
			19:sound<=E;
			20:sound<=0;
			21:sound<=E;
			22:sound<=0;
			23:sound<=D;
			24:sound<=D;
			25:sound<=D;
			26:sound<=0;
			27:sound<=G;
			28:sound<=0;
			29:sound<=G;
			30:sound<=0;
			31:sound<=A;
			32:sound<=0;
			33:sound<=A;
			34:sound<=G;
			35:sound<=0;
			36:sound<=G;
			37:sound<=0;
			38:sound<=E;
			39:sound<=E;
			40:sound<=0;
			41:sound<=G;
			42:sound<=0;
			43:sound<=E;
			44:sound<=0;
			45:sound<=D;
			46:sound<=0;
			47:sound<=E;
			48:sound<=0;
			49:sound<=C;
			50:sound<=C;
			51:sound<=0;
			52:sound<=0;
			53:sound<=0;
			default:sound<=0;
		endcase
	end
endmodule

module alarm(clk,resetn,switch,enable,alarm_clock,hour,minute,second,BUFF);
    input clk,resetn;
	input switch;
    input [3:0] enable;
    input [23:0] alarm_clock;
    input [7:0] hour,minute,second;
    output reg BUFF;

	parameter C=1915,D=1706,E=1519,F=1432,G=1278,A=1136,B=1014;
    integer CNT;
	reg [7:0] music_cnt;
	reg thetime;
	wire [11:0] sound;
	
	music_rom ROM1(clk,resetn,music_cnt,sound);

	integer time_cnt;
	always @(posedge clk or negedge resetn)begin
		if(!resetn)begin
			time_cnt<=0;
		end
		if(resetn)begin
			if(thetime)begin
				if(time_cnt>=500000)begin
					music_cnt<=music_cnt+1;
					time_cnt<=0;
					if(music_cnt>=54)
						music_cnt<=0;
				end
				else
					time_cnt<=time_cnt+1;
			end
		end
	end

	always @(posedge clk or negedge resetn)begin
		if(!resetn)begin
			music_cnt<=0;
			thetime<=0;
			BUFF<=0;
			CNT<=0;
		end
		else if(switch==1)begin
			BUFF<=0;
			CNT<=0;
			thetime<=0;
			music_cnt<=0;
			time_cnt<=0;
		end 
		else if(thetime)begin
			if(sound==0)begin
				BUFF<=0;
			end
			else if(CNT>=sound)begin
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

endmodule