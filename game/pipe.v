module pipe (
    input wire clk,
    input wire reset,
	 input wire freeze,
    output reg [9:0] pipe_x,
    output reg [9:0] gap_y
);
    // The pipe's horizontal position and the position of the gap
    reg [9:0] pipe_x_next, gap_y_next;

    always @(posedge clk or posedge reset) begin
	 
        if (reset) begin
            pipe_x <= 639;  // Start at the right side of the screen
            gap_y <= 240;  // Start with the gap in the middle of the screen
        end else begin
            pipe_x <= pipe_x_next;
            gap_y <= gap_y_next;
        end
    end

    always @* begin
        if (pipe_x == 0) begin
            pipe_x_next = 639;  // Reset to the right side of the screen
            gap_y_next = 250 % 480;  // Randomly generate the position of the gap
        end else begin
            pipe_x_next = pipe_x - 10;  // Move to the left
        end
    end
endmodule