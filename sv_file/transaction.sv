
	class transaction;
		
		 randc logic wr_en;
		 randc logic rd_en;
		 randc logic [7:0] data_in;
		 logic wr_rst, rd_rst;
		 logic [7:0] data_out;
		 bit fifo_empty;
		 bit fifo_full;

    function void display(string name);
			$display("==================%s================",name);
			$display("wr_en=%b, wr_rst=%b, rd_rst=%b, rd_en=%b, data_in=%d, data_out=%d, fifo_empty=%b, fifo_full=%b",
            wr_en, wr_rst, rd_rst, rd_en, data_in, data_out, fifo_empty, fifo_full);
	endfunction : display

		
	endclass : transaction



	

