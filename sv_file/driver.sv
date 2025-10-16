import trans_pkg::*;

class driver;

	// this is driver to drive the signla to the dut thorut the interface

	// taken two interface of the following to clock
	virtual intf_Async.wr_mp_drv fifow; 
	virtual intf_Async.rd_mp_drv fifor;

	mailbox gen2drv;

	function new( virtual intf_Async.wr_mp_drv fifow, virtual intf_Async.rd_mp_drv fifor, mailbox gen2drv);
			
			this.fifow = fifow;
			this.fifor = fifor;
			this.gen2drv = gen2drv;

	endfunction : new

   
   // write the task for drive the signale

   task drv_task();

   		transaction trans;
   		repeat(10) begin
   			
   		gen2drv.get(trans);

   		// drive signal based on the wr_clock
   		@(fifow.wr_cb_drv);
   		fifow.wr_cb_drv.wr_en <= trans.wr_en;
   		fifow.wr_cb_drv.data_in <= trans.data_in;
   		
   		// drive signal based on the rd_clock
   		@(fifor.rd_cb_drv);
   		fifor.rd_cb_drv.rd_en <= trans.rd_en;
        
          // trans.display("Driver signals");
      

   		end
   endtask : drv_task	


endclass : driver
