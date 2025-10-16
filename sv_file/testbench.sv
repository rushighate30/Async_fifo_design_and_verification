// `include "test.sv"
// `include "interface.sv"
// `include "main.v"

module testbench;

	parameter DATA_WIDTH = 8;
	parameter ADD_WIDTH = 4;
	logic wr_clk, rd_clk;
	logic wr_rst, rd_rst;

	// interfacting the Async fifo
	intf_Async #(.DATA_WIDTH(DATA_WIDTH))
	     fifo(.wr_clk(wr_clk), .rd_clk(rd_clk));

	test tst(.fifo(fifo));

    main #(.DATA_WIDTH(DATA_WIDTH), .ADD_WIDTH(ADD_WIDTH))
	   dut_main(
	     	.wr_clk(wr_clk),
	     	.wr_rst(wr_rst),
	     	.wr_en(fifo.wr_en), 
	     	.rd_clk(rd_clk), 
	     	.rd_rst(rd_rst), 
	     	.data_in(fifo.data_in), 
	     	.data_out(fifo.data_out), 
	     	.rd_en(fifo.rd_en),
	     	.fifo_full(fifo.fifo_full), 
	     	.fifo_empty(fifo.fifo_empty)
	     );



	  initial begin
	  	wr_clk = 0; rd_clk = 0; 
        wr_rst = 0; rd_rst = 0;
	  	#10; 

	  	wr_rst = 1; rd_rst = 1;
	  	assign fifo.wr_rst = wr_rst;
	  	assign fifo.rd_rst = rd_rst;
	  	#20;
	  end


	  always #4 wr_clk = ~wr_clk;
	  always #8 rd_clk = ~rd_clk;


	  initial begin

	  	 // $monitor("fifo_wr_rst=%b, fifo_rd_rst=%b",fifo.wr_rst, fifo.rd_rst);
       #500 $stop;
	  end 

endmodule : testbench