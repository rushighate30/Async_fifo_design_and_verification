
module fifo_write #(parameter ADD_WIDTH = 3 )
(wr_clk, wr_rst, wr_en, rd_gry_sync, wr_addrs, fifo_full, wr_ptr_bin_gry);    // rollover bit addes in this condition

	input wr_clk, wr_rst, wr_en;
	input [ADD_WIDTH:0] rd_gry_sync; // this is rd_2ff
	output [ADD_WIDTH-1:0] wr_addrs; // this is adress
	output reg [ADD_WIDTH:0] wr_ptr_bin_gry;
	output fifo_full;

	// internal binary pointer
	reg [ADD_WIDTH:0] wr_ptr_bin;  // 4 bit 1bit MSB rollover and 3 bit adress
	// reg [ADD_WIDTH-1:0] rd_gry_bin_full;
	

  //  this is combinational next ptr taken to remove the lags which is create by the combination circutes
	wire [ADD_WIDTH:0] wr_ptr_bin_next = wr_ptr_bin + 1'b1;
   assign wr_addrs = wr_ptr_bin[ADD_WIDTH-1:0];   // 3 bit adress assign


	// compare the next gray pointer with synchronized with read gray pointers
   wire [ADD_WIDTH:0] wr_ptr_bin_grya_next = bin2gry_f(wr_ptr_bin_next);
   assign  fifo_full = ({~wr_ptr_bin_grya_next[ADD_WIDTH-1], wr_ptr_bin_grya_next[ADD_WIDTH-2:0]} == rd_gry_sync);  // compared the gry value with next converted


	function automatic [ADD_WIDTH:0] bin2gry_f(input [ADD_WIDTH:0] bin);
		integer k;
		begin
		bin2gry_f[ADD_WIDTH] = bin[ADD_WIDTH];
		for( k= ADD_WIDTH-1; k >= 0; k = k-1)
			 bin2gry_f[k] = bin[k+1] ^ bin[k];
		end
	endfunction
   


	always @(posedge wr_clk or negedge wr_rst)begin
	    
	    if(~wr_rst)begin
//	       $display("Write reset setting");
	    	wr_ptr_bin <= 0;
	    	wr_ptr_bin_gry <= 0;
	    end
	    else if( wr_en && !fifo_full)begin
	    	  wr_ptr_bin <= wr_ptr_bin + 1'b1;
	    	  wr_ptr_bin_gry <= wr_ptr_bin_grya_next;
       end
       else begin
       	wr_ptr_bin = wr_ptr_bin;
       	wr_ptr_bin_gry <= wr_ptr_bin_gry;
       end
   end
   
//    initial $monitor("Read wr_ptr_bin=%b, wr_gry_bin_empty=%b",wr_ptr_bin,rd_gry_bin_full);
     
   
//   assign  fifo_full = ({~wr_ptr_bin[3], wr_ptr_bin[2:0]} == rd_gry_bin_full);  // its generated the flag based on binary checking
   
endmodule 