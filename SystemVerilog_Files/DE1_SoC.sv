module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR,SW);
	input logic CLOCK_50; // 50MHz clock.
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY; // True when not pressed, False when pressed
	input logic [9:0] SW;
	
	logic keyOne;
	logic keyTwo;
	
	logic firstStableInput;
	logic secondStableInput;
	
	logic rightLED;
	logic leftLED;

	// Generate clk off of CLOCK_50, whichClock picks rate.
	logic [31:0] clk;
	// Hook up FSM inputs and outputs.
//	logic Reset, w, out;
//	assign Reset = SW[9]; // Reset when SW[9] is pressed.
	
	//turn off HEX1 through HEX5 displays
	assign HEX1 = 7'b1111111;
	assign HEX2 = 7'b1111111;
	assign HEX3 = 7'b1111111;
	assign HEX4 = 7'b1111111;
	assign HEX5 = 7'b1111111;

	
	seriesFlipFlop stableOne (.clk(CLOCK_50), .Reset(SW[9]), .key(KEY[0]), .out(firstStableInput));
	seriesFlipFlop stableTwo (.clk(CLOCK_50), .Reset(SW[9]), .key(KEY[3]), .out(secondStableInput));

	//add in module for metastability: take in the two keys directly then put into series D flip flops
	userInput one (.Reset(SW[9]), .clk(CLOCK_50), .key(firstStableInput), .awardPoint(keyOne));
	userInput two (.Reset(SW[9]), .clk(CLOCK_50), .key(secondStableInput), .awardPoint(keyTwo));

	//victory winner (.Reset(SW[9]), .clk(CLOCK_50), .leftEnd(LEDR[9]), .rightEnd(LEDR[1]), .leftKey(secondStableInput), .rightKey(firstStableInput), .HEX0(HEX0));
	victory winner (.clk(CLOCK_50), .Reset(SW[9]), .L(keyTwo), .R(keyOne), .lightLeft(LEDR[9]), .lightRight(LEDR[1]), .HEX0(HEX0));
	//victory right (.clk(CLOCK_50), .Reset(SW[9]), .L(keyTwo), .R(keyOne), .NL(LEDR[2]), .NR(1'b0), .lightOn(LEDR[1]), .HEX0(HEX0));
	
	normalLight led1 (.clk(CLOCK_50), .Reset(SW[9]), .L(keyTwo), .R(keyOne), .NL(LEDR[2]), .NR(1'b0), .lightOn(LEDR[1]));
	normalLight led2 (.clk(CLOCK_50), .Reset(SW[9]), .L(keyTwo), .R(keyOne), .NL(LEDR[3]), .NR(LEDR[1]), .lightOn(LEDR[2]));
	normalLight led3 (.clk(CLOCK_50), .Reset(SW[9]), .L(keyTwo), .R(keyOne), .NL(LEDR[4]), .NR(LEDR[2]), .lightOn(LEDR[3]));
	normalLight led4 (.clk(CLOCK_50), .Reset(SW[9]), .L(keyTwo), .R(keyOne), .NL(LEDR[5]), .NR(LEDR[3]), .lightOn(LEDR[4]));
	
	centerLight led5 (.clk(CLOCK_50), .Reset(SW[9]), .L(keyTwo), .R(keyOne), .NL(LEDR[6]), .NR(LEDR[4]), .lightOn(LEDR[5]));
	
	normalLight led6 (.clk(CLOCK_50), .Reset(SW[9]), .L(keyTwo), .R(keyOne), .NL(LEDR[7]), .NR(LEDR[5]), .lightOn(LEDR[6]));
	normalLight led7 (.clk(CLOCK_50), .Reset(SW[9]), .L(keyTwo), .R(keyOne), .NL(LEDR[8]), .NR(LEDR[6]), .lightOn(LEDR[7]));
	normalLight led8 (.clk(CLOCK_50), .Reset(SW[9]), .L(keyTwo), .R(keyOne), .NL(LEDR[9]), .NR(LEDR[7]), .lightOn(LEDR[8]));
	normalLight led9 (.clk(CLOCK_50), .Reset(SW[9]), .L(keyTwo), .R(keyOne), .NL(1'b0), .NR(LEDR[8]), .lightOn(LEDR[9]));


endmodule
