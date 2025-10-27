<h1 align="center">🧠 Async FIFO (Asynchronous First-In First-Out Buffer)</h1>
<p align="center">
RTL Design and Verification Project using SystemVerilog  
Safe Data Transfer Between Clock Domains
</p>

---

## Overview
This project implements an **Asynchronous FIFO (First-In First-Out)** buffer that allows
reliable data transfer between two independent clock domains.  
It uses **Gray-coded pointers** and **multi-stage synchronizers** to prevent metastability
and ensure proper full/empty flag detection.

## Features
- Parameterized data width and depth  
- Independent read and write clock domains  
- Gray-code pointer synchronization  
- Verified using SystemVerilog testbench  

## Project Structure

