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
            <li><a href="#graycode">Gray Code Counter</a></li>
          </ul>
        </li>
        <li><a href="#signals">Signals Definition</a></li>
        <li>
          <a href="#modules">Dividing System Into Modules</a>
          <ul>
            <li><a href="#fifo">FIFO.v</a></li>
            <li><a href="#fifo_memory">FIFO_memory.v</a></li>
            <li><a href="#two_ff_sync">two_ff_sync.v</a></li>
            <li><a href="#rptr_empty">rptr_empty.v</a></li>
            <li><a href="#wptr_full">wptr_full.v</a></li>
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
    <li><a href="#results">Results</a></li>
    <li><a href="#conclusion">Conclusion</a></li>
    <li><a href="#references">References</a></li>
  </ul>

  <!-- Sections -->
  <h2 id="author">Author</h2>
  <p>Vinayak Ghate</p>

 # instruction writing here 
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

  <h3 id="readwrite">Read and Write Operations</h3>
  <h4 id="operations">Operations</h4>
  <p>Details about read/write operations...</p>

  <h4 id="conditions">Full, Empty and Wrapping Condition</h4>
  <p>Explanation...</p>

  <h4 id="graycode">Gray Code Counter</h4>
  <p>Explanation...</p>

  <h3 id="signals">Signals Definition</h3>
  <p>Signals table goes here...</p>

  <h3 id="modules">Dividing System Into Modules</h3>
  <ul>
    <li id="fifo"><strong>FIFO.v</strong> — Main FIFO integration module</li>
    <li id="fifo_memory"><strong>FIFO_memory.v</strong> — Memory array file</li>
    <li id="two_ff_sync"><strong>two_ff_sync.v</strong> — Synchronizer module</li>
    <li id="rptr_empty"><strong>rptr_empty.v</strong> — Read pointer & empty flag</li>
    <li id="wptr_full"><strong>wptr_full.v</strong> — Write pointer & full flag</li>
  </ul>

  <h2 id="testbench">Testbench Case Implementation</h2>
  <h3 id="waveforms">Waveforms</h3>
  <p><img src="waveform.png" alt="Simulation waveform" width="600"></p>

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


