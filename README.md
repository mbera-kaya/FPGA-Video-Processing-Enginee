# FPGA-based Real-Time Video Processing Engine

This repository contains a modular video processing pipeline implemented in VHDL. The system is designed to process video streams using the **AXI4-Stream** protocol, suitable for high-performance FPGA applications like autonomous vehicles.

## Features
- **AXI4-Stream Integration:** Fully compliant interfaces for seamless data flow.
- **Grayscale Conversion:** Efficient RGB to Y (Grayscale) conversion core.
- **Sobel Edge Detection:** Hardware-accelerated 3x3 convolution engine with dual-line buffers.
- **Real-Time Performance:** Designed for high-definition video throughput.

## Simulation & Verification
The Sobel Edge Detection core has been verified using **Vivado Simulator**. The simulation confirms that the hardware logic correctly identifies edges by calculating Gx and Gy gradients.

### Waveform Analysis
![Sobel Verification](sobel_waveform.png)

*The waveform shows the **Gsum** signal peaking at **1020** when an edge is detected, confirming the thresholding logic and mathematical accuracy of the core.*

## Project Structure
- `src/`: VHDL source files for Grayscale and Sobel cores.
- `sim/`: Testbench files for verification.
