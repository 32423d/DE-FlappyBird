module clkdiv (
    input wire cin, // clock input
    output reg cout // clock output
);
    reg [31:0] i;
	 
    always @(posedge cin) begin
        if (i == 499999) begin
		  i <= 0;
		  cout <= ~cout;
		end else i <= i + 1;
    end
endmodule
