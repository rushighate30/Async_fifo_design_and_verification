
module FIFO#(parameter DATA_WIDTH = 8, ADD_WIDTH = 3)
     (wr_clk, rd_clk, wr_rst, rd_rst, wr_addrs, rd_addrs, data_in, data_out);
     input wr_clk, wr_rst;
     input rd_clk, rd_rst;
     input [ADD_WIDTH-1:0] wr_addrs;
     input [ADD_WIDTH-1:0] rd_addrs;
     input [DATA_WIDTH-1:0] data_in;
     output reg [DATA_WIDTH-1:0] data_out;
     
     
     // we are modify the dept of the memory 
//   desing the memory here
    reg [DATA_WIDTH-1:0] fifo_mem [0:2**ADD_WIDTH-1];  //  this is fifo memeory  2^3-1:0 = 7:0 if i am chnage value of the addres 
                                                      //   then automatically chnage fifo depth with repect to adress size 
    
    // pointer to reset vlaues 
     integer i = 0;
    //  write data in the fifo memory
    
    always @(posedge wr_clk or negedge wr_rst)begin
          
          if(~wr_rst)begin
            for( i=0; i<(2**ADD_WIDTH); i = i + 1)
              fifo_mem[i] <= 8'b0;
          end else begin
             fifo_mem[wr_addrs] <= data_in;
          end

   end
    
    // read the memory here
    always @(posedge rd_clk or negedge rd_rst)begin
     
        if(~rd_rst) begin
          data_out <= 8'b0;
        end
        else begin
          data_out <= fifo_mem[rd_addrs];   
        end
    end
    

  // initial begin
  //      $monitor("wr_data=%d <--||--> rd_data=%d",fifo_mem[wr_addrs], fifo_mem[rd_addrs]);

  //  end
    
endmodule
