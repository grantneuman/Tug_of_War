module victory (clk, Reset, L, R, lightLeft, lightRight, HEX0);
	input logic clk, Reset, L, R, lightLeft, lightRight;
	
	
	
	
	output logic [6:0] HEX0;
	
	//logic [6:0] ps;
	logic [6:0] ns;
	
	
	
	logic [6:0] one, two, off;

	
	assign one = 7'b1111001;
	assign two = 7'b0100100;
	assign off = 7'b1111111; 
	
	
	
	always_comb begin
		case(HEX0)
			off: if (lightLeft & (L & ~R)) ns = two;
				  else if (lightRight  & (~L & R)) ns = one;
				  else ns = off;
			one: ns = one;
			
			two: ns = two;
	
			default: ns = off;
			
		endcase
	end
	


	//assign HEX0 = ps;
	
	always_ff @(posedge clk) begin
		if (Reset)
			HEX0 <= off;
		else 
			HEX0 <= ns;
	end
	
endmodule

//module victory_testbench();
//	logic clk;
//	logic Reset;
//	logic [6:0] HEX0;
//	logic L, R, NL, NR, lightOn;
//   integer i;
//
//	victory dut (clk, Reset, L, R, NL, NR, lightOn, HEX0);
//
//	// Set up the clock.
//	parameter CLOCK_PERIOD=100;
//	initial begin
//		clk <= 0;
//		forever #(CLOCK_PERIOD/2) clk <= ~clk;
//	end
//	initial begin
//														@(posedge clk);
//													  @(posedge clk);
//		Reset <= 1; L <= 0; R <=0; lightLeft <= 0; lightRight <= 0; @(posedge clk);
//													  @(posedge clk);
//													  @(posedge clk);
//													  @(posedge clk);
//		Reset <= 1; L <= 0; R <=0; lightLeft <= 0; lightRight <= 0; @(posedge clk);
//													  @(posedge clk);
//													  @(posedge clk);
//													  @(posedge clk);
//				 L <= 0; R <=0; lightLeft <= 0; lightRight <= 0; @(posedge clk);
//													  @(posedge clk);
//													  @(posedge clk);
//													  @(posedge clk);
//				leftEnd <= 0; rightEnd <=0; leftKey <= 1; rightKey <= 0; @(posedge clk);
//													  @(posedge clk);
//													  @(posedge clk);
//													  @(posedge clk);
//				 leftEnd <= 0; rightEnd <=1; leftKey <= 0; rightKey <= 0; @(posedge clk);
//													  @(posedge clk);
//													  @(posedge clk);	
//													  @(posedge clk);		
//				leftEnd <= 0; rightEnd <=0; leftKey <= 0; rightKey <= 1; @(posedge clk);
//													  @(posedge clk);
//													  @(posedge clk);	
//													  @(posedge clk);			  
//				 leftEnd <= 0; rightEnd <=0; leftKey <= 1; rightKey <= 0; @(posedge clk);
//													  @(posedge clk);
//													  @(posedge clk);
//													  @(posedge clk);
//
//		$stop;
//	end
//	
//endmodule 
//
//
