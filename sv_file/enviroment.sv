// `include "all_file.sv"
import trans_pkg::*;


class enviroment;

     bit wr_rst;
     bit rd_rst;
	// we are call to all submodule ot class  of the  enviroment 

    // this is object of the class
	generator gen;
	driver   drv;
	monitor  mon;
	scoreboard scb;
     
     // this is actuall interface based on modport direction
     virtual intf_Async.wr_mp_drv fifow_drv;
     virtual intf_Async.rd_mp_drv fifor_drv;
     virtual intf_Async.wr_mp_mon fifow_mon;
     virtual intf_Async.rd_mp_mon fifor_mon;

	mailbox gen2drv;
	mailbox mon2scb;



	// we are write the there contructor to call in another to class 

	function new( virtual intf_Async.wr_mp_drv fifow_drv,
		 	    virtual intf_Async.rd_mp_drv fifor_drv,
		 	    virtual intf_Async.wr_mp_mon fifow_mon,
		 	    virtual intf_Async.rd_mp_mon fifor_mon);

			    this.fifow_drv = fifow_drv;
			    this.fifor_drv = fifor_drv;
			    this.fifow_mon = fifow_mon;
			    this.fifor_mon = fifor_mon;
			
       //   we are allocate the memory for the mailbox

            gen2drv = new();
            mon2scb = new();

	   // we are call the all enviromant of thesub class and pass there arguments

			gen = new(fifow_drv, fifor_drv, gen2drv);
			drv = new(fifow_drv, fifor_drv, gen2drv);
			mon = new(fifow_mon, fifor_mon, mon2scb);
			scb = new(mon2scb);

	endfunction : new


//  we are write the task for run our enviroment of the subclass in concurrently (parallely)

   task env_task();
   
   	fork
   		
   		gen.gen_task();
   		drv.drv_task();
   		mon.mon_task();
   		scb.scb_task();

   	join

  endtask : env_task
	
endclass : enviroment