
module Async_FIFO#(parameter DATA_WIDTH = 8, DEEP_WIDTH = 8)
  (rst_n, wr_clk, wr_en, rd_clk, rd_en, data_in, data_out, fifo_full, fifo_empty);
    
   
  // global reset
      input rst_n;

  //   read domain signlas here
       input rd_clk, rd_en;
       output [DATA_WIDTH-1:0] data_out;
       output fifo_empty;
   
  
 // write domain signals  
       input wr_clk, wr_en;
       input [DATA_WIDTH-1:0]data_in;
       output fifo_full;
         

//         // we are create the clog2 function that calulated the adress size based on deepth

         function integer clog2;
             input integer deep_value;
             integer i;
             begin
                clog2 = 0;
                 for( i = deep_value-1; i > 0; i = i >> 1)begin  
                     clog2 = clog2 + 1;
                 end
             end
             
         endfunction 


         // this is local parameter to assign adress size
         localparam ADD_WIDTH = clog2(DEEP_WIDTH);
         
         
         // wire we are speperated the reset for read and write
    wire rd_rst = rst_n;
    wire wr_rst = rst_n;
    
    
        // read internal wires
        wire [ADD_WIDTH:0] rd_addrs;
        wire [ADD_WIDTH:0] rd_ptr_bin_gry;
        wire [ADD_WIDTH:0] rd_gry_sync;
        
        // write internal wires
        wire [ADD_WIDTH:0] wr_addrs;
        wire [ADD_WIDTH:0] wr_ptr_bin_gry;
        wire [ADD_WIDTH:0] wr_gry_sync;
    
  
  
  // main fifo memory instance create here
    
    FIFO #(.DATA_WIDTH(DATA_WIDTH), .ADD_WIDTH(ADD_WIDTH), .DEEP_WIDTH(DEEP_WIDTH))
    FIFO_MEM(
           .wr_clk(wr_clk),
           .rd_clk(rd_clk),
           .rst_n(rst_n),
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
// write_2FF write_2ff2(.wr_2ff_in(wr_ptr_bin_gry[1]), .wr_2ff_sync(wr_gry_sync[1]), .wr_clk(wr_clk), .wr_rst(wr_rst));   
// write_2FF write_2ff3(.wr_2ff_in(wr_ptr_bin_gry[2]), .wr_2ff_sync(wr_gry_sync[2]), .wr_clk(wr_clk), .wr_rst(wr_rst));   
// write_2FF write_2ff4(.wr_2ff_in(wr_ptr_bin_gry[3]), .wr_2ff_sync(wr_gry_sync[3]), .wr_clk(wr_clk), .wr_rst(wr_rst));   
   
   
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
//  read_2FF read_2ff2(.rd_2ff_in(rd_ptr_bin_gry[1]), .rd_2ff_sync(rd_gry_sync[1]), .rd_clk(rd_clk), .rd_rst(rd_rst));
//  read_2FF read_2ff3(.rd_2ff_in(rd_ptr_bin_gry[3]), .rd_2ff_sync(rd_gry_sync[2]), .rd_clk(rd_clk), .rd_rst(rd_rst));
//  read_2FF read_2ff4(.rd_2ff_in(rd_ptr_bin_gry[3]), .rd_2ff_sync(rd_gry_sync[3]), .rd_clk(rd_clk), .rd_rst(rd_rst));
   
// initial begin       
  
//  $monitor("[time=%t]wr_clk=%b, rd_clk=%b,wr_rst=%b wr_addrs=%b, rd_rst=%b rd_addrs=%b, wr_ptr_bin_gry=%b, rd_gry_sync=%b, rd_ptr_bin_gry=%b, wr_gry_sync=%b, fifo_fill=%b, fifo_empty=%b",
//      $time,wr_clk,rd_clk,wr_rst,wr_addrs,rd_rst,rd_addrs,wr_ptr_bin_gry,rd_gry_sync,rd_ptr_bin_gry,wr_gry_sync,fifo_full,fifo_empty);
//  end
   
   
endmodule
