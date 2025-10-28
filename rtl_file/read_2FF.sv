
module read_2FF #(ADD_WIDTH = 3)
   ( rd_2ff_in, rd_2ff_sync, rd_clk, rd_rst);
	input rd_clk, rd_rst;
	input [ADD_WIDTH:0] rd_2ff_in;
	output reg [ADD_WIDTH:0] rd_2ff_sync;


	//  this is the internal reg which works as 1 1-bit FF
	reg [ADD_WIDTH:0] rd_2ff;  // reg 

	always @(posedge rd_clk or negedge rd_rst) begin
		
		if(~rd_rst) begin
			
            rd_2ff <= 0;
			
	end else begin
		
		{rd_2ff_sync, rd_2ff} <= { rd_2ff_in, rd_2ff };
		
   end
  end
 
endmodule 
