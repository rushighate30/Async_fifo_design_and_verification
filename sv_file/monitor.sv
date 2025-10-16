import trans_pkg::*;

class monitor;

	// this is the read the disgrm from the dut with interface

	mailbox mon2scb;
	virtual intf_Async.wr_mp_mon fifow;
	virtual intf_Async.rd_mp_mon fifor;


	// write the constructor here
	function new(virtual intf_Async.wr_mp_mon fifow, virtual intf_Async.rd_mp_mon fifor, mailbox mon2scb);

			this.fifow = fifow;
			this.fifor = fifor;
			this.mon2scb = mon2scb;

	endfunction : new


	// task this is task to read the signlas form the dut using interface
	task mon_task();

		 transaction trans;

		// repeat(5)begin
			forever begin

			trans = new();

			// this is read base on wr clock
			@(fifow.wr_cb_mon);
			trans.wr_rst = fifow.wr_cb_mon.wr_rst;
			trans.wr_en = fifow.wr_cb_mon.wr_en;
			trans.data_in = fifow.wr_cb_mon.data_in;
			trans.fifo_full = fifow.wr_cb_mon.fifo_full;


			@(fifor.rd_cb_mon);
			trans.rd_rst = fifor.rd_cb_mon.rd_rst;
			trans.rd_en = fifor.rd_cb_mon.rd_en;
			trans.data_out = fifor.rd_cb_mon.data_out;
			trans.fifo_empty = fifor.rd_cb_mon.fifo_empty;
			
			mon2scb.put(trans);
			// trans.display("Monitor_Class");
		   
	end

	endtask : mon_task
	
endclass : monitor