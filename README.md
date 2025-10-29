<h1>
  Design and Verification of Async FIFO Design with CDC.
</h1>
<p>
  This repo contains Verilog and SystemVerilog code for an async FIFO.
</p>

<body>
  <!-- Table of Contents -->
  <h2>Table of Contents</h2>
  <ul>
    <li><a href="#author">Author</a></li>
    <li><a href="#introduction">Introduction</a></li>
    <li>
      <a href="#design">Design Space Exploration and Design Strategies</a>
      <ul>
        <li>
          <a href="#readwrite">Read and Write Operations</a>
          <ul>
            <li><a href="#operations">Operations</a></li>
            <li><a href="#conditions">Full, Empty and Wrapping Condition</a></li>
          </ul>
        </li>
        <li><a href="#signals">Signals Definition</a></li>
        <li>
          <a href="#modules">Dividing System Into Modules</a>
            <ul>
              <li><a href="#main">main.v</a></li>
              <li><a href="#fifo_mem">FIFO.v</a></li>
              <li><a href="#fifo_write">fifo_write.v</a></li>
              <li><a href="#fifo_read">fifo_read.sv</a></li>
              <li><a href="#write_2FF">write_2FF.sv</a></li>
              <li><a href="#write_2FF">read_2FF.sv</a></li>
            </ul>
        </li>
      </ul>
    </li>
    <li>
      <a href="#testbench">Testbench Case Implementation</a>
      <ul>
        <li><a href="#waveforms">Waveforms</a></li>
      </ul>
    </li>
    <li>
      <a href="#systemverilog">System Verilog Enviroment Verification</a>
      <ul>
        <li><a href="#verification">Verification Waveform</a></li>
      </ul> 
    <li><a href="#results">Results</a></li>
    <li><a href="#conclusion">Conclusion</a></li>
    <li><a href="#references">References</a></li>
  </ul>

  <!-- Sections -->
  <h2 id="author">Author</h2>
  <p>Vinayak Ghate</p>


<h2 id="introduction">Introduction</h2>
<p style="text-align: justify;">
  This project presents the design and verification of an <strong>Asynchronous FIFO (First-In, First-Out)</strong> memory structure,
  developed to achieve reliable <strong>Clock Domain Crossing (CDC)</strong> between two asynchronous clock domains. The main objective
  is to ensure safe and efficient data transfer while minimizing synchronization errors and avoiding metastability issues.
</p>

<p style="text-align: justify;">
  The FIFO employs independent <strong>read</strong> and <strong>write pointers</strong>, each operating in separate clock domains.
  To prevent metastability during pointer synchronization, a <strong>Gray code counter</strong> is implemented, ensuring only one bit
  changes during transitions. The design also includes <strong>Gray-to-Binary conversion</strong> logic for accurate address calculation
  and status flag generation, such as <code>full</code> and <code>empty</code> conditions.
</p>

<p style="text-align: justify;">
  A <strong>two-flip-flop (2FF) synchronizer</strong> technique is used to synchronize pointer values across clock domains, effectively
  reducing the chances of metastable behavior. The design is modular, consisting of multiple Verilog files that handle specific
  functionalities such as memory storage, pointer control, and synchronization.
</p>

<ul style="text-align: justify;">
  <li>The FIFO design ensures reliable CDC and stable data transfer under asynchronous clock operation.</li>
  <li>SystemVerilog-based testbench verification validates functionality across different timing scenarios.</li>
  <li>The approach demonstrates a practical and reusable solution for FPGA and SoC-based system integration.</li>
</ul>

<p style="text-align: justify;">
  Overall, this Asynchronous FIFO design provides a robust mechanism for handling data communication between independent clock domains,
  combining efficient synchronization techniques with thorough functional verification.
</p>




<h2 id="design">Design Space Exploration and Design Strategies</h2>
<p style="text-align: justify;">
 The block diagram of async. The FIFO implementation in this repository is as follows. Thin lines represent a single-bit signal, as thick lines represent a multi-bit signal.
</p>

<!-- 🖼️ Example image block -->
<div style="text-align: center; margin: 20px 0;">
  <img src="Design_Verification_Result/Async_FIFO.png" alt="Async_FIFO" width="1000" style="border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.2);" />
  <p style=" text-align: center; font-style: italic; font-size: 14px;">Figure 1: Asynchronous FIFO Architecture showing CDC and module interactions.</p>
</div>

  <h3 id="readwrite">Read and Write Operations</h3>
  <h4 id="operations">Operations</h4>
<p>In an asynchronous FIFO, the read and write operations are managed by separate clock domains. The write pointer always points to the next word to be written. On a FIFO-write operation, the memory location pointed to by the write pointer is written, and then the write pointer is incremented to point to the next location to be written. Similarly, the read pointer always points to the current FIFO word to be read. On reset, both pointers are set to zero. When the first data word is written to the FIFO, the write pointer increments, the empty flag is cleared, and the read pointer, which is still addressing the contents of the first FIFO memory word, immediately drives that first valid word onto the FIFO data output port to be read by the receiver logic. The FIFO is empty when the read and write pointers are both equal, and it is full when the write pointer has wrapped around and caught up to the read pointer.</p>

  <h4 id="conditions">Full, Empty and Wrapping Condition</h4>
<p align="justify">
  The conditions for the FIFO to be full or empty are as follows:
</p>

<ul>
  <li>
    <strong>Empty Condition:</strong>  
    The FIFO is empty when the read and write pointers are both equal. This condition happens when both pointers are reset to zero during a reset operation, or when the read pointer catches up to the write pointer, having read the last word from the FIFO.
  </li>

  <li>
    <strong>Full Condition:</strong>  
    The FIFO is full when the write pointer has wrapped around and caught up to the read pointer. This means that the write pointer has incremented past the final FIFO address and has wrapped around to the beginning of the FIFO memory buffer.
  </li>

  <li>
    <strong>Wrapping Around Condition:</strong>  
    To distinguish between the full and empty conditions when the pointers are equal, an extra bit is added to each pointer. This extra bit helps in identifying whether the pointers have wrapped around:
    <ul>
      <li>
        When the write pointer increments past the final FIFO address, it will increment the unused Most Significant Bit (MSB) while setting the rest of the bits back to zero.
      </li>
      <li>
        The same is done with the read pointer. If the MSBs of the two pointers are different, it means that the write pointer has wrapped one more time than the read pointer.
      </li>
      <li>
        If the MSBs of the two pointers are the same, it means that both pointers have wrapped the same number of times.
      </li>
    </ul>
  </li>
</ul>

<p align="justify">
  This design technique helps in accurately determining the full and empty conditions of the FIFO.
</p>

  <h3 id="signals">Signals Definition</h3>
  <h3 id="signals">Signals Definition</h3>

<p style="text-align: justify;">
  The following signals are used in the asynchronous FIFO design:
</p>

<p style="text-align: justify;">
  <strong><code>wr_clk</code></strong> : Write clock signal.<br>
  <strong><code>rd_clk</code></strong> : Read clock signal.<br>
  <strong><code>data_in</code></strong> : Write data bits.<br>
  <strong><code>data_out</code></strong> : Read data bits.<br>
  <strong><code>wr_en</code></strong> : Write clock enable. Controls the write operation to the FIFO memory. 
  Data must not be written if the FIFO is full (<code>fifo_full = 1</code>).<br>
  <strong><code>wr_ptr_bin_gry</code></strong> : Write pointer (Gray code).<br>
  <strong><code>rd_ptr_bin_gry</code></strong> : Read pointer (Gray code).<br>
  <strong><code>wr_ptr_bin</code></strong> : Write pointer increment. Controls the increment of <code>wr_ptr</code>.<br>
  <strong><code>rd_ptr_bin</code></strong> : Read pointer increment. Controls the increment of <code>rd_ptr</code>.<br>
  <strong><code>wr_addrs</code></strong> : Binary write pointer address. Location in FIFO memory to which <code>data_in</code> is written.<br>
  <strong><code>rd_addrs</code></strong> : Binary read pointer address. Location in FIFO memory from which <code>rdata_out</code> is read.<br>
  <strong><code>fifo_full</code></strong> : FIFO full flag. Goes high when the FIFO memory is full.<br>
  <strong><code>fifo_empty</code></strong> : FIFO empty flag. Goes high when the FIFO memory is empty.<br>
  <strong><code>wr_rst</code></strong> : Active low asynchronous reset for the write pointer handler.<br>
  <strong><code>rd_rst</code></strong> : Active low asynchronous reset for the read pointer handler.<br>
  <strong><code>wr_gry_sync</code></strong> : Read pointer synchronized to the <code>wr_clk</code> domain via 2 flip-flop synchronizer.<br>
  <strong><code>rd_gry_sync</code></strong> : Write pointer synchronized to the <code>rd_clk</code> domain via 2 flip-flop synchronizer.
</p>

<h3 id="modules">Dividing System Into Modules</h3>
<p>For implementing this FIFO, I have divided the design into <strong>6 modules</strong>:</p>

<ol>
  <li><strong><code>main.v</code></strong>: The top-level wrapper module includes all clock domains and is used to instantiate all other FIFO modules. In a larger ASIC or FPGA design, this wrapper would likely be discarded to group the FIFO modules by clock domain for better synthesis and static timing analysis.</li>

  <li><strong><code>FIFO.v</code></strong>: This module contains the buffer or the memory of the FIFO, which has both clocks. This is a <strong>dual-port RAM</strong>.</li>

  <li><strong><code>write_2FF.sv</code></strong>: This module consists of two flip-flops connected to form a 2 flip-flop synchronizer. It is used to safely transfer the <strong>Gray-coded write pointer</strong> from the write clock domain to the read clock domain.</li>

  <li><strong><code>read_2FF.sv</code></strong>: This module consists of two flip-flops connected to form a 2 flip-flop synchronizer. It is used to safely transfer the <strong>Gray-coded read pointer</strong> from the read clock domain to the write clock domain.</li>

  <li><strong><code>fifo_read.sv</code></strong>: This module consists of the logic for the Read pointer handler. It is completely synchronized by the read clock and consists of the logic for the generation of the FIFO <strong>empty signal</strong>.</li>

  <li><strong><code>fifo_write.v</code></strong>: This module consists of the logic for the Write pointer handler. It is completely synchronized by the write clock and consists of the logic for the generation of the FIFO <strong>full signal</strong>.</li>
</ol>


<h3 id="main">main.v</h3>
<p style="text-align: justify;">
  <a href="rtl_file/main.v">
   <code>./rtl_file/main.v</code></a>
is the code of this module. This module is a FIFO implementation with configurable data and address sizes. It consists of a memory module, read and write pointer handling modules, and read and write pointer synchronization modules. The read and write pointers are synchronized to the respective clock domains, and the read and write pointers are checked for empty and full conditions, respectively. The FIFO memory module stores the data and handles the read and write operations. The RTL schematics of this module is given below.</p>
</p>
<div style="text-align: center; margin: 20px 0;">
  <img src="Design_Verification_Result/Schematic.png" alt="main.v RTL Schematic" width="1000" style="border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.2);" />
  <p style="text-align: center; font-style: italic; font-size: 14px;">Figure 2 : RTL Schematic of main.v (Generated by Vivado schematic)</p>
</div>


<h3 id="fifo_mem">FIFO.v</h3>
<p style="text-align: justify;">
  <a href="rtl_file/FIFO.v">
    <code>./rtl_file/FIFO.v</code></a>
  is the code of this module. The module has a memory array (FIFO_MEM) with a depth of 2^ADDR_SIZE. The read and write addresses are used to access the memory array. The write enable (wr_en) and write full (fifo_full) signals are used to control the writing process. The write data is stored in the memory array on the rising edge of the write clock (wr_clk). The RTL schematics of this module is given below.
</p>

<div style="text-align: center; margin: 20px 0;">
  <img src="Design_Verification_Result/fifo_mem_schematic.png" alt="FIFO.v RTL Schematic" width="1000" style="border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.2);" />
  <p style="text-align: center; font-style: italic; font-size: 14px;">Figure 3 : RTL Schematic of FIFO.v (Generated by Vivado schematic)</p>
</div>


<h3 id="write_2FF"> write_2FF.sv & read_2FF.sv </h3>
<p style="text-align: justify;">
  <a href="rtl_file/write_2FF.sv">
   <code>./rtl_file/write_2FF.sv</code></a>
  <a href="rtl_file/read_2FF.sv">
    <code>./rtl_file/read_2FF.sv</code></a>
  Individual 2-flip-flop synchronizer modules are used to eliminate metastability when transferring Gray-coded pointers across clock domains.
  The <code>write_2FF</code> module safely passes the Gray-coded write pointer from the write clock domain to the read clock domain. Similarly, <code>read_2FF</code> transfers the Gray-coded read pointer from the read clock domain to the write clock domain. Both modules ensure reliable CDC synchronization, enabling accurate detection of FIFO full and empty conditions.
</p>

<div style="text-align: center; margin: 20px 0;">
  <img src="Design_Verification_Result/read_write_2FF.png" alt=" write_2FF.sv read_2FF.sv RTL Schematic" width="1000" style="border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.2);" />
  <p style="text-align: center; font-style: italic; font-size: 14px;">Figure 4 : RTL Schematic of write_2FF.sv & read_2FF.sv (Generated by Vivado schematic)</p>
</div>

<h3 id="fifo_write"> fifo_write.v </h3>
<p style="text-align: justify;">
  <a href="rtl_file/fifo_write.v">
   <code>./rtl_file/fifo_write.v</code></a>
This module increments the write pointer whenever a valid write enable (wr_en) is asserted in the write clock domain. It converts the updated binary pointer into Gray code and forwards it to the 2-flip-flop synchronizer for safe cross-domain transfer. It also handles pointer wrapping and generates the FIFO full signal by comparing the synchronized read pointer with the local write pointer. The current write address is continuously supplied to the FIFO memory module for data write operations.</p>
</p>
<div style="text-align: center; margin: 20px 0;">
  <img src="Design_Verification_Result/fifo_write.png" alt="fifo_write.v RTL Schematic" width="1000" style="border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.2);" />
  <p style="text-align: center; font-style: italic; font-size: 14px;">Figure 5 : RTL Schematic of fifo_write.v (Generated by Vivado schematic)</p>
</div>

<h3 id="fifo_read"> fifo_read.sv </h3>
<p style="text-align: justify;">
  <a href="rtl_file/fifo_read.sv">
   <code>./rtl_file/fifo_read.sv</code></a>
This module increments the read pointer whenever a valid read enable (rd_en) is asserted in the read clock domain. It converts the updated binary pointer into Gray code and forwards it to the 2-flip-flop synchronizer for safe cross-domain transfer. It also handles pointer wrapping and generates the FIFO empty signal by comparing the synchronized write pointer with the local read pointer. The current read address is continuously supplied to the FIFO memory module for data read operations.
</p>
<div style="text-align: center; margin: 20px 0;">
  <img src="Design_Verification_Result/fifo_read.png" alt="fifo_read.v RTL Schematic" width="1000" style="border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.2);" />
  <p style="text-align: center; font-style: italic; font-size: 14px;">Figure 6 : RTL Schematic of fifo_read.v (Generated by Vivado schematic)</p>
</div>

  <h2 id="testbench">Testbench Case Implementation</h2>
  <h3 id="testbench">tb_Async_fifo.v</h3>

<p style="text-align: justify;">
  <a href="rtl_file/tb_Async_fifo.v">
    <code>./rtl_fifo/tb_Async_fifo.v</code></a>
  is the testbench for the FIFO module. It generates random data and writes it to the FIFO, then reads it back and compares the results.
</p>

<p style="text-align: justify;">
  The testbench includes <strong>three test cases</strong>:
</p>

<ol>
  <li><strong>Write data and read it back</strong> – Verifies basic FIFO functionality.</li>
  <li><strong>Write data to make the FIFO full and try to write more data</strong> – Checks full flag behavior and write protection.</li>
  <li><strong>Read data from an empty FIFO and try to read more data</strong> – Checks empty flag behavior and read protection.</li>
</ol>

<p style="text-align: justify;">
  The testbench uses clock signals for writing and reading, and includes reset signals to initialize the FIFO. The testbench finishes after running all test cases.
</p>

  <h3 id="waveforms">Waveforms</h3>
  <p><img src="Design_Verification_Result/Waveform.png" alt="Simulation waveform" width="1000"></p>
  <div style="text-align: center; margin: 20px 0;">
  <p style="text-align: center; font-style: italic; font-size: 14px;">Figure 7 : RTL simulation waveform of the tb_Async_fifo.v (Generated by Vivado schematic)</p>
</div>


  <h2 id="systemverilog">System Verilog Enviroment Verification</h2>
  <h3 id="testbench">sv_file/testbench.sv</h3>

<p style="text-align: justify;">
  <a href="sv_file/testbench.sv">
    <code>./rtl_fifo/tb_Async_fifo.v</code></a>
  is the testbench for the FIFO module. It generates random data and writes it to the FIFO, then reads it back and compares the results.
</p>

<p style="text-align: justify;">
  The testbench includes <strong>three test cases</strong>:
</p>

<ol>
  <li><strong>Write data and read it back</strong> – Verifies basic FIFO functionality.</li>
  <li><strong>Write data to make the FIFO full and try to write more data</strong> – Checks full flag behavior and write protection.</li>
  <li><strong>Read data from an empty FIFO and try to read more data</strong> – Checks empty flag behavior and read protection.</li>
</ol>

<p style="text-align: justify;">
  The testbench uses clock signals for writing and reading, and includes reset signals to initialize the FIFO. The testbench finishes after running all test cases.
</p>

  <h3 id="waveforms">Waveforms</h3>
  <p><img src="Design_Verification_Result/Waveform.png" alt="Verification Wavefrom" width="1000"></p>
  <div style="text-align: center; margin: 20px 0;">
  <p style="text-align: center; font-style: italic; font-size: 14px;">Figure 8 : Verification Waveform of the testbench.sv (Generated by Modulesim Waveform)</p>
</div>

  <h2 id="results">Results</h2>
  <p>Results description...</p>

  <h2 id="conclusion">Conclusion</h2>
  <p>Conclusion text...</p>

  <h2 id="references">References</h2>
  <ul>
    <li>Clifford Cummings, “Simulation and Synthesis Techniques for Asynchronous FIFO Design.”</li>
    <li>Xilinx App Notes — FIFO Design Guidelines</li>
  </ul>

</body>


