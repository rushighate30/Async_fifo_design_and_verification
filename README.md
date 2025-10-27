<h1>
  Design and Verification of Async FIFO Design with CDC.
</h1>
<p>
  This repo contains Verilog and SystemVerilog code for an async FIFO.
</p>

<h2> Table of Contents</h2>

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

  <h2 id="introduction">Introduction</h2>
  <p>Introduction text here...</p>

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


