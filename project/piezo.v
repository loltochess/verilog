module piezo(CLK, rst_x, valid, M, BUFF);
	
	input CLK, rst_x, valid;
	input[11:0] M;
	output reg BUFF;
	integer CN_SOUND, LIMIT;

	parameter hz=1000000,C=264,D=293,E=329,F=349,G=392,A=440,B=494;

	always@(M)begin
		case (M)
		12'b000000000001: LIMIT = hz/C/2;//C {implement your code here}
		12'b000000000010: LIMIT = hz/D/2;//D {implement your code here}
		12'b000000000100: LIMIT = hz/E/2;//E {implement your code here}
		12'b000000001000: LIMIT = hz/F/2;//F {implement your code here}
		12'b000000010000: LIMIT = hz/G/2;//G {implement your code here}
		12'b000000100000: LIMIT = hz/A/2;//A {implement your code here}
		12'b000001000000: LIMIT = hz/B/2;//B {implement your code here}
		12'b000010000000: LIMIT = hz/C/4;//C {implement your code here}
		12'b000100000000: LIMIT = hz/D/4;
		12'b001000000000: LIMIT = hz/E/4;
		12'b010000000000: LIMIT = hz/F/4;
		12'b100000000000: LIMIT = hz/G/4;
		default:LIMIT = 0; //no sound
		endcase
	end
	
	always@(posedge CLK or negedge rst_x)begin
	
		if(!rst_x) begin //reset=0
			BUFF <= 0;
			CN_SOUND <= 0;
		end
		
		else if(valid ==1) begin
			
			if(CN_SOUND >= LIMIT)begin
				CN_SOUND <= 0 ; //initial CN_SOUND
				BUFF <= ~BUFF; //change BUFF
			end
	
			else CN_SOUND <= CN_SOUND +1; //increase CN_SOUND
		end
	
		else begin //maintain data
			CN_SOUND <= CN_SOUND;
			BUFF <= BUFF;
		end
	end
		
endmodule	