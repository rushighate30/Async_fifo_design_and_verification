`include "enviroment.sv"

module test(intf_Async fifo);

	// we are all to enviroment in the test class 
	enviroment env;

	initial begin
		
		env = new(fifo.wr_mp_drv,
		          fifo.rd_mp_drv, 
		          fifo.wr_mp_mon,
		          fifo.rd_mp_mon);

		env.env_task();

	end

endmodule : test
