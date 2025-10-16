import trans_pkg::*;

class generator;

	// there generate the randome values 
    mailbox gen2drv;

    // interface we are take to reset signla operation 
    virtual intf_Async.wr_mp_drv fifow_rst;
    virtual intf_Async.rd_mp_drv fifor_rst;

    function new( virtual intf_Async.wr_mp_drv fifow_rst, 
                  virtual intf_Async.rd_mp_drv fifor_rst,
                  mailbox gen2drv);
 			
            this.fifow_rst = fifow_rst;
            this.fifor_rst = fifor_rst;
 			this.gen2drv = gen2drv;

    endfunction : new


    task  gen_task();

    	 transaction trans;

        // $display("wait for reset the Aysnch FIFO with CDC");
        wait(fifow_rst.wr_cb_drv.wr_rst == 1'b1 && fifor_rst.rd_cb_drv.rd_rst == 1'b1);

    	repeat(10) begin    
           trans = new();

           trans.wr_en = 1;
           trans.rd_en = 1;
           trans.data_in = $urandom_range(0,500);
           trans.wr_rst = fifow_rst.wr_cb_drv.wr_rst;
           trans.rd_rst = fifor_rst.rd_cb_drv.rd_rst;
            
            gen2drv.put(trans);
            // trans.display("Generator_class");
            #1;
    	end
   
    endtask : gen_task


endclass : generator