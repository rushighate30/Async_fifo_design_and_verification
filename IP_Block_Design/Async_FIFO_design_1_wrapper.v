//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2024.2 (win64) Build 5239630 Fri Nov 08 22:35:27 MST 2024
//Date        : Sat Feb 28 10:54:17 2026
//Host        : DESKTOP-H8M2GFQ running 64-bit major release  (build 9200)
//Command     : generate_target Async_FIFO_design_1_wrapper.bd
//Design      : Async_FIFO_design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module Async_FIFO_design_1_wrapper
   (data_in,
    data_out,
    fifo_empty,
    fifo_full,
    rd_clk,
    rd_en,
    rst_n,
    wr_clk,
    wr_en);
  input [7:0]data_in;
  output [7:0]data_out;
  output fifo_empty;
  output fifo_full;
  input rd_clk;
  input rd_en;
  input rst_n;
  input wr_clk;
  input wr_en;

  wire [7:0]data_in;
  wire [7:0]data_out;
  wire fifo_empty;
  wire fifo_full;
  wire rd_clk;
  wire rd_en;
  wire rst_n;
  wire wr_clk;
  wire wr_en;

  Async_FIFO_design_1 Async_FIFO_design_1_i
       (.data_in(data_in),
        .data_out(data_out),
        .fifo_empty(fifo_empty),
        .fifo_full(fifo_full),
        .rd_clk(rd_clk),
        .rd_en(rd_en),
        .rst_n(rst_n),
        .wr_clk(wr_clk),
        .wr_en(wr_en));
endmodule
