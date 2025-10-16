import trans_pkg::*;

class scoreboard;

	// there only extract the signlas form the main and compare values

	mailbox mon2scb;
	bit [7:0] privious_data_in = 0;
	bit [7:0] privious_data_out = 0;

	function new(mailbox mon2scb);

		this.mon2scb = mon2scb;

	endfunction : new


	task scb_task();
   			
   			transaction  trans;

   			// repeat(5) begin
   				forever begin
   				mon2scb.get(trans);

   				// there we are comparing the actual input and desired output 

   				// if(trans.wr_en == 1'b1 && !trans.fifo_full)begin
   				// 	// $display("In write score board");
   				// 	if(trans.data_in != privious_data_in) begin
   				// 	   $display("Data Write data_in=%d",trans.data_in);
   				// 	   privious_data_in = trans.data_in;
   				// 	end
   				// end


   				// if(trans.rd_en == 1'b1 && !trans.fifo_empty)begin
   					
   				// 	if(trans.data_out != privious_data_out)begin
   				// 		$display("Data Read data_out=%d",trans.data_out);
   				// 		privious_data_out = trans.data_out;
   				// 	end
   				// end


   				if( (trans.wr_en == 1'b1 && !trans.fifo_full) || (trans.rd_en == 1'b1 && !trans.fifo_empty))begin

   				   if( (trans.data_in != privious_data_in) || (trans.data_out != privious_data_out) )begin
   				   	   $display("DATE_WRITE=%d <----> DATA_READ=%d",trans.data_in, trans.data_out);
   				   	   privious_data_in = trans.data_in;
   				   	   privious_data_out = trans.data_out;
   				   end
   				end

   			end
	endtask : scb_task
	
endclass : scoreboard