
module write_2FF #(ADD_WIDTH = 3)(
    wr_2ff_in, wr_2ff_sync, wr_clk, wr_rst);
	input wr_clk, wr_rst;
	input [ADD_WIDTH:0]wr_2ff_in;
	output reg [ADD_WIDTH:0] wr_2ff_sync;


	//  this is the interna reg which work as 1 bit FF
	reg [ADD_WIDTH:0] wr_2ff;  // reg 

	always @(posedge wr_clk or negedge wr_rst) begin
		
		if(~wr_rst) begin
            wr_2ff <= 0;
			
	end else begin

		{wr_2ff_sync, wr_2ff} <= {wr_2ff_in, wr_2ff };
		
   end
  end
 
endmodule 
