module bird (
    input wire clk,
	 input wire freeze,
    input wire flap,
    output reg [9:0] bird_y
);
    // The bird's vertical position
    reg [9:0] bird_y_next;
	 reg skip;

    initial begin
        bird_y_next <= 10;  // Start in the middle of the screen
		  bird_y <= 10;
    end

    always @(posedge clk) begin
			if (~freeze) begin
        if (flap) begin
            bird_y_next <= bird_y + 10;  // Move up
        end else if (skip == 0) begin
			  if (bird_y_next > 10) begin
					bird_y_next <= bird_y - 10;  // Fall down
				end
        end
        bird_y <= bird_y_next;
		  skip <= skip +1;
    end
	 end
endmodule
