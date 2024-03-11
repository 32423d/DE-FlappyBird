module comb_ckt_generator (
   // VGA-related signals
   col,
   row,
   red,
   green,
   blue,
   // input push buttons and switches
   KEY,
   SW,
   // output LEDs and 7-segment displays
   LEDR,
   HEX0,
   HEX1,
   HEX2,
   HEX3,
   HEX4,
   HEX5,
	clk
   );

input  [9:0]  col;
input  [8:0]  row;
input clk;
output reg [3:0]  red;    // 4-bit color output
output reg [3:0]  green;  // 4-bit color output
output reg [3:0]  blue;   // 4-bit color output

// input push buttons and switches
input  [1:0]  KEY;    // two board-level push buttons KEY1 - KEY0
input  [9:0]  SW;     // ten board-level switches SW9 - SW0

// output LEDs and 7-segment displays
output [9:0]  LEDR;   // ten board-level LEDs LEDR9 - LEDR0
output [7:0]  HEX0;   // board-level 7-segment display
output [7:0]  HEX1;   // board-level 7-segment display
output [7:0]  HEX2;   // board-level 7-segment display
output [7:0]  HEX3;   // board-level 7-segment display
output [7:0]  HEX4;   // board-level 7-segment display
output [7:0]  HEX5;   // board-level 7-segment display

// Specific pixel coordinates for the square
localparam [9:0] squareRowStart = 200;
localparam [9:0] squareRowEnd = 250;
localparam [9:0] squareColStart = 300;
localparam [9:0] squareColEnd = 380;

wire bird_clk;
reg game_over;

initial begin
game_over <= 0;
end

wire [9:0] bird_y;
wire [9:0] pipe_x, gap_y;
clkdiv clkdiv1 (.cin(clk), .cout(bird_clk));
bird bird1 (.clk(bird_clk), .freeze(game_over), .flap(KEY[1]), .bird_y(bird_y));
pipe pipe1 (.clk(bird_clk), .freeze(game_over), .reset(reset), .pipe_x(pipe_x), .gap_y(gap_y));


// Game over logic
   always @(clk) begin
       if (reset) begin
           game_over = 0;
       end
       else if ((col >= pipe_x && col <= pipe_x + 50 && (row < gap_y || row > gap_y + 100)) || (col - 100)**2 + (row - bird_y)**2 > 20**2) begin
           // The bird has collided with a pipe or the boundaries of the screen
           // Game over: set the screen to red
           game_over = 1;
       end 
   end

always @(*)
begin
	if (game_over == 1) begin
		red = 4'b1111;
      green = 4'b1000;
      blue = 4'b1000;
	end 
 else if ((col - 100)**2 + (row - bird_y)**2 <= 20**2)
	 begin
		red = 4'b1111;
		green = 4'b1001;
		blue = 4'b0010;
		
		if (col >= pipe_x && col <= pipe_x + 50 && (row < gap_y || row > gap_y + 100)) begin
           // Will turn collision blocks red
				red = 4'b1111;
				green = 4'b1011;
				blue = 4'b1010;
       end 
	 
	 end
	 
	 else if (col >= pipe_x && col <= pipe_x + 50 && (row < gap_y || row > gap_y + 100)) begin
	      red = 4'b1111;
			green = 4'b1011;
			blue = 4'b1010;
    end
	 
	 else begin
    // Set the default color as white
    red = 4'b0100;
    green = 4'b1110;
    blue = 4'b1100;
	end
    
end

endmodule