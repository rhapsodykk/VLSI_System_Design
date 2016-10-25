module  lab2(clk,buttons,switch,led);
input clk,switch;      //clk_50Mhz
input[7:0] buttons;        // 8 buttons board
output[7:0] led;     //led0-led7
reg[7:0] led,led_casez,led_if;
initial begin
	led = 8'h00;
end

always@(posedge clk) begin             // switch to different models to control led. 1st model: casez
	casez(buttons)
		8'b11111110:  led_casez = 8'h01;     //push button 1
		8'b1111110?:  led_casez = 8'h02; 	   //push button 2	
		8'b111110??:  led_casez = 8'h03;     //push button 3
		8'b11110???:  led_casez = 8'h04;     //push button 4
		8'b1110????:  led_casez = 8'h05;     //push button 5	  
		8'b110?????:  led_casez = 8'h06;     //push button 6	
		8'b10??????:  led_casez = 8'h07;     //push button 7
		8'b0???????:  led_casez = 8'h08;     //push button 8
		default:  led_casez = led_casez; 	
	endcase	
end

always@(posedge clk) begin      	//2st model: if else
	if ((buttons >= 8'h3f) && (buttons <= 8'h7f))  led_if = 8'h08;     //push button 0011_1111 ~ 0111_1111
	else if ((buttons >= 8'h9f) && (buttons <= 8'hbf))  led_if = 8'h07;     //push button 1001_1111 ~ 1011_1111
	else if ((buttons >= 8'hcf) && (buttons <= 8'hdf))  led_if = 8'h06;     //push button 1100_1111 ~ 1101_1111
	else if ((buttons >= 8'he7) && (buttons <= 8'hef))  led_if = 8'h05;     //push button 1110_0111 ~ 1110_1111
	else if ((buttons >= 8'hf3) && (buttons <= 8'hf7))  led_if = 8'h04;     //push button 1111_0011 ~ 1111_0111
	else if ((buttons >= 8'hf9) && (buttons <= 8'hfb))  led_if = 8'h03;     //push button 1111_1001 ~ 1111_1011
	else if ((buttons == 8'hfc) || (buttons == 8'hfd))  led_if = 8'h02;     //push button 1111_1100 ~ 1111_1101
	else if (buttons == 8'hfe)  led_if = 8'h01;     //push button 1111_1110
end

always@(led_casez or led_if or switch) begin    //switch mux
	if(switch) led = led_casez;
	else led = led_if;
end
endmodule
