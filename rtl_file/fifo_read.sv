
module fifo_read #(parameter ADD_WIDTH = 3)
(rd_clk, rd_rst, rd_en, wr_gry_sync, rd_addrs, rd_ptr_bin_gry, fifo_empty);

	input rd_clk, rd_rst;
	input rd_en;
	input [ADD_WIDTH:0] wr_gry_sync;  // this is comming from wr_2ff pointer
	output [ADD_WIDTH-1:0] rd_addrs;    // outut adress to pointer as asyn fifo
	output reg [ADD_WIDTH:0] rd_ptr_bin_gry;
	output fifo_empty;                     //  flag signal
	                                  
	reg [ADD_WIDTH:0] rd_ptr_bin;   // we are declare the internal pointer 

	// it updates non-blockingly (<=), the task sees the old value of wr_ptr_bin.
	wire [ADD_WIDTH:0] rd_ptr_bin_next = rd_ptr_bin + 1'b1;
	assign rd_addrs =  rd_ptr_bin[ADD_WIDTH-1:0]; 


   wire [ADD_WIDTH:0] rd_ptr_bin_next_gry = bin_gry_f(rd_ptr_bin_next);
	assign fifo_empty = (rd_ptr_bin_next_gry == wr_gry_sync);  // its generated the flag based on the gray compare


    function automatic [ADD_WIDTH:0] bin_gry_f(input logic [ADD_WIDTH:0] bin);
    	  integer k;
    		begin
    			bin_gry_f[ADD_WIDTH] = bin[ADD_WIDTH];
    			for (k = ADD_WIDTH-1; k >= 0; k = k-1)
    				bin_gry_f[k] = bin[k+1] ^ bin[k];
    		end
    endfunction



	always @(posedge rd_clk or negedge  rd_rst)begin
		
		if(~rd_rst)begin
			
//		    $display("Read reset setting");
			rd_ptr_bin <= 0;
			rd_ptr_bin_gry <= 0;
			
		end
		else if(rd_en && !fifo_empty)begin
			
//		    $display("Read increment ");
			 rd_ptr_bin <= rd_ptr_bin + 1'b1;
          rd_ptr_bin_gry <= rd_ptr_bin_next_gry;
		end
		else begin
			rd_ptr_bin = rd_ptr_bin;
			rd_ptr_bin_gry = rd_ptr_bin_gry;
		end

	end
   
endmodule 
