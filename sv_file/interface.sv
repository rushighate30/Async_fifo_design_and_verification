interface intf_Async #(parameter DATA_WIDTH = 8)
	   (input logic rd_clk, input logic wr_clk);


	logic wr_en;
	logic rd_en;
	logic rd_rst;
	logic wr_rst;
	logic [DATA_WIDTH-1:0]data_in;
	logic [DATA_WIDTH-1:0]data_out;
	logic fifo_empty;
	logic fifo_full;



	// we are create the different block based on the different clock 

	// wr_clk clocking block for driver
	clocking wr_cb_drv @(posedge wr_clk);
 		default input #1 output #1;
 		output wr_en, data_in;
 		input  wr_rst; 
	endclocking	


	// wr_clk clocking block for monitor
	clocking wr_cb_mon @(posedge  wr_clk);
		default input #1 output #1;
		input wr_rst, wr_en, data_in;
		input fifo_full;
	endclocking


	//rd_clk clocking blcok for driver
	clocking rd_cb_drv @(posedge  rd_clk);
		default input #1 output #1;
		output rd_en;
		input  rd_rst;
	endclocking


	//rd_clk clocking block for monitor 
	clocking rd_cb_mon @(posedge rd_clk);
		default input #1  output #1;
		input rd_rst, rd_en;
		input fifo_empty, data_out;
	endclocking


   // modport for the write 
	modport wr_mp_drv( clocking wr_cb_drv);
	modport wr_mp_mon( clocking wr_cb_mon);

	// modport for the read
	modport rd_mp_drv( clocking rd_cb_drv);
	modport rd_mp_mon( clocking rd_cb_mon);


	
endinterface : intf_Async