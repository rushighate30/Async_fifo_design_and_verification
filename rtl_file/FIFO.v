module FIFO#(parameter DATA_WIDTH = 8, DEEP_WIDTH = 16, ADD_WIDTH = 3)
     (wr_clk, rd_clk, rst_n, wr_addrs, rd_addrs, data_in, data_out);

//   Input Pins
     input wr_clk;
     input rst_n;
     // input wr_rst;
     input rd_clk;
     // input rd_rst;
     input [ADD_WIDTH-1:0] wr_addrs;
     input [ADD_WIDTH-1:0] rd_addrs;
     input [DATA_WIDTH-1:0] data_in;

//   Output Pin
     output reg [DATA_WIDTH-1:0] data_out;
     
     
     reg [DATA_WIDTH-1:0] fifo_mem [0:DEEP_WIDTH-1];  //  this is fifo memeory  16 deep and each row have  7:0 if i am chnage value of the addres 
                                                        //   then automatically chnage fifo depth with repect to adress size 
    
//   pointer to reset memory  
     integer i = 0;

//   write data in the fifo memory
     always @(posedge wr_clk or negedge rst_n)begin
          
          if(~rst_n)begin

            for( i=0; i<(DEEP_WIDTH); i = i + 1)
              fifo_mem[i] <= 8'b0;

          end else begin

             fifo_mem[wr_addrs] <= data_in;            // Write Data in FIFO memory

          end
     end
    

//   read the memory here
     always @(posedge rd_clk or negedge rst_n)begin
     
        if(~rst_n) begin

          data_out <= 8'b0;

        end
        else begin

          data_out <= fifo_mem[rd_addrs];            // Read Data From FIFO memory

        end
     end
    
endmodule
