<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Asynchronous FIFO Project README</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 40px;
      background-color: #f9f9f9;
      color: #222;
    }
    h1, h2, h3 {
      color: #333;
    }
    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 10px;
    }
    th, td {
      border: 1px solid #ccc;
      padding: 8px;
      text-align: left;
    }
    th {
      background-color: #eaeaea;
    }
    img {
      max-width: 600px;
      border-radius: 8px;
      margin: 10px 0;
    }
    p {
      line-height: 1.6;
    }
  </style>
</head>

<body>

  <h1>Asynchronous FIFO Design — README</h1>

  <h2>Author</h2>
  <p><strong>Name:</strong> Vinayak Ghate</p>
  <p><strong>Email:</strong> <a href="mailto:vinayak@example.com">vinayak@example.com</a></p>

  <h2>Introduction</h2>
  <p>
    This project implements an <strong>Asynchronous FIFO (First In, First Out)</strong> design for 
    clock domain crossing (CDC) applications. The FIFO uses Gray code counters to avoid metastability 
    issues and ensures reliable data transfer between write and read clock domains.
  </p>

  <h2>Design Space Exploration and Design Strategies</h2>

  <h3>Read and Write Operations</h3>

  <h4>Operations</h4>
  <p>
    The FIFO supports independent read and write operations controlled by separate clock signals.
    Synchronization logic ensures data integrity when transferring data between two asynchronous clocks.
  </p>

  <h4>Full, Empty and Wrapping Conditions</h4>
  <p>
    The FIFO asserts <code>full</code> when the next write address matches the read pointer, 
    and <code>empty</code> when the read pointer equals the synchronized write pointer. 
    Address wrapping is handled through binary-to-Gray conversion logic.
  </p>

  <h4>Gray Code Counter</h4>
  <p>
    The Gray code counter ensures only one bit changes between consecutive values, minimizing 
    metastability risks during pointer synchronization between clock domains.
  </p>

  <h3>Signals Definition</h3>
  <table>
    <tr>
      <th>Signal</th>
      <th>Direction</th>
      <th>Description</th>
    </tr>
    <tr><td>wclk</td><td>Input</td><td>Write clock signal</td></tr>
    <tr><td>rclk</td><td>Input</td><td>Read clock signal</td></tr>
    <tr><td>wr_en</td><td>Input</td><td>Write enable signal</td></tr>
    <tr><td>rd_en</td><td>Input</td><td>Read enable signal</td></tr>
    <tr><td>full</td><td>Output</td><td>Indicates FIFO is full</td></tr>
    <tr><td>empty</td><td>Output</td><td>Indicates FIFO is empty</td></tr>
  </table>

  <h3>Dividing System Into Modules</h3>
  <ul>
    <li><strong>FIFO.v</strong> — Top-level FIFO integration module</li>
    <li><strong>FIFO_memory.v</strong> — Memory array for data storage</li>
    <li><strong>two_ff_sync.v</strong> — Two flip-flop synchronizer to handle CDC</li>
    <li><strong>rptr_empty.v</strong> — Logic for read pointer and empty flag generation</li>
    <li><strong>wptr_full.v</strong> — Logic for write pointer and full flag generation</li>
  </ul>

  <h2>Testbench Case Implementation</h2>
  <p>
    The testbench validates FIFO operation by simulating various conditions such as normal data flow, 
    full and empty transitions, and read/write clock frequency mismatches.
  </p>

  <h3>Waveforms</h3>
  <p>
    The waveforms below show data write and read operations under asynchronous clock conditions.
  </p>
  <!-- Add your waveform image here -->
  <img src="waveform.png" alt="FIFO Simulation Waveform Example">

  <h2>Results</h2>
  <p>
    The design successfully handles asynchronous read and write operations without data loss or corruption.
    Both <code>full</code> and <code>empty</code> signals perform correctly under all tested conditions.
  </p>

  <h2>Conclusion</h2>
  <p>
    The asynchronous FIFO design demonstrates reliable clock domain crossing using Gray code counters 
    and synchronizer logic. It provides a solid foundation for data buffering in SoC and FPGA systems.
  </p>

  <h2>References</h2>
  <ul>
    <li>Clifford E. Cummings, “Simulation and Synthesis Techniques for Asynchronous FIFO Design.”</li>
    <li>Xilinx Application Notes — FIFO Design Guidelines</li>
    <li>Verilog HDL Reference Manual</li>
  </ul>

</body>
</html>
