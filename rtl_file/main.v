// `include "FIFO.v"
// `include "fifo_write.v"
// `include "fifo_read.sv"
// `include "read_2FF.sv"
// `include "write_2FF.sv"

module main#(parameter DATA_WIDTH = 8, ADD_WIDTH = 3)
  (wr_clk, wr_rst, wr_en, rd_clk, rd_rst, data_in, data_out, rd_en, fifo_full, fifo_empty);
  
  //   read domain signlas here
       input rd_clk, rd_rst, rd_en;
       output [DATA_WIDTH-1:0] data_out;
       output fifo_empty;
   
  
 // write domain signals  
       input wr_clk, wr_rst, wr_en;
       input [DATA_WIDTH-1:0]data_in;
       output fifo_full;
         
        // read internal wires
        wire [ADD_WIDTH-1:0] rd_addrs;
        wire [ADD_WIDTH:0] rd_ptr_bin_gry;
        wire [ADD_WIDTH:0] rd_gry_sync;
        
        // write internal wires
        wire [ADD_WIDTH-1:0] wr_addrs;
        wire [ADD_WIDTH:0] wr_ptr_bin_gry;
        wire [ADD_WIDTH:0] wr_gry_sync;
    
  
  
  // main fifo memory instance create here
    
    FIFO #(.DATA_WIDTH(DATA_WIDTH), .ADD_WIDTH(ADD_WIDTH))
    FIFO_MEM(
           .wr_clk(wr_clk),
           .rd_clk(rd_clk),
           .wr_rst(wr_rst),
           .rd_rst(rd_rst),
           .wr_addrs(wr_addrs),
           .rd_addrs(rd_addrs),
           .data_in(data_in),
           .data_out(data_out)
          );
  
  //  instance of the write fifo
 fifo_write #(.ADD_WIDTH(ADD_WIDTH))
    write_fifo(
     .wr_clk(wr_clk),
     .wr_rst(wr_rst),
     .wr_en(wr_en),
     .rd_gry_sync(rd_gry_sync),    // input 
     .wr_addrs(wr_addrs),
     .fifo_full(fifo_full), 
     .wr_ptr_bin_gry(wr_ptr_bin_gry)
     );  
     
    // write fifo of 2flop synchronounce
    write_2FF #(.ADD_WIDTH(ADD_WIDTH))
    write_2ff1(.wr_2ff_in(wr_ptr_bin_gry), .wr_2ff_sync(wr_gry_sync), .wr_clk(wr_clk), .wr_rst(wr_rst));
   
   
 //    // instance of the fifo_read
    fifo_read #(.ADD_WIDTH(ADD_WIDTH))
     read_fifo(.rd_clk(rd_clk), 
          .rd_rst(rd_rst),
          .rd_en(rd_en), 
          .wr_gry_sync(wr_gry_sync),   // input 
          .rd_addrs(rd_addrs), 
          .rd_ptr_bin_gry(rd_ptr_bin_gry), 
          .fifo_empty(fifo_empty)
      );     

     //  read fifo 2 flop syncr instance
    read_2FF #(.ADD_WIDTH(ADD_WIDTH))
    read_2ff1(.rd_2ff_in(rd_ptr_bin_gry), .rd_2ff_sync(rd_gry_sync), .rd_clk(rd_clk), .rd_rst(rd_rst));
   
 initial begin       
    // $monitor("wr_rst=%b, rd_rst=%b",wr_rst,rd_rst);
  end
   
endmodule
