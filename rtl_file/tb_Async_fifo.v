`timescale 1ns/ 1ps 

module tb;

  parameter ADD_WIDTH = 4;
  parameter DATA_WIDTH = 8;
  reg wr_clk, rd_clk;
  reg wr_rst, rd_rst;
  reg wr_en,  rd_en;
  reg [DATA_WIDTH-1:0] data_in;
  wire [DATA_WIDTH-1:0] data_out;
  wire fifo_full, fifo_empty;
  
  integer i;
  
  // instacne of the Main DUT all
 main #(.DATA_WIDTH(DATA_WIDTH), .ADD_WIDTH(ADD_WIDTH))
 DUT(
      .wr_clk(wr_clk),
      .wr_rst(wr_rst),
      .wr_en(wr_en),
      .rd_clk(rd_clk),
      .rd_rst(rd_rst),
      .rd_en(rd_en),
      .fifo_full(fifo_full), 
      .fifo_empty(fifo_empty),
      .data_in(data_in),
      .data_out(data_out)
      );


//  writting the actual testing the maodule here
   
    task write_data(input [DATA_WIDTH-1:0] din);
        begin
         $display("Write data in FIFO");
         @(posedge  wr_clk);
         data_in = din;
         wr_en = 1;
         @(posedge wr_clk);
         wr_en = 0;
        end
    endtask
    
    
    task read_data;
      begin
        @(posedge rd_clk);
         rd_en = 1;
        @(posedge rd_clk);
         rd_en = 0;      
      end
    endtask
    
  initial begin
    {wr_clk, rd_clk, wr_rst, rd_rst, data_in} = 0;
    #5 wr_rst = 1; rd_rst = 1;  
    
  end
  
  always #5 wr_clk = ~wr_clk;   // fast clk
  always #10 rd_clk = ~rd_clk; // slow clock
  
  initial begin

    for(i=0; i<32; i = i+1)begin
        write_data(i*3);
        read_data();
    end
    
   #300 $finish;
  end


endmodule