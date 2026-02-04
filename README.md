# FPGA-based Real-Time Video Processing Engine

This repository contains a modular video processing pipeline implemented in **VHDL**. The project focuses on hardware-accelerated image processing using industry-standard **AXI4-Stream** protocols, specifically designed for high-performance applications like autonomous vehicle perception.

## Key Features
* **AXI4-Stream Protocol:** Fully compliant master/slave interfaces for high-bandwidth data streaming and seamless IP integration.
* **Modular Architecture:** Independent and reusable cores for Grayscale conversion and Sobel Edge Detection.
* **Sobel Core:** Hardware-accelerated 3x3 convolution engine utilizing dual-line buffers for real-time pixel processing.
* **Efficient Resource Usage:** Optimized VHDL implementation designed for low-latency FPGA execution.

---

## Simulation & Verification
The design has been rigorously verified using the **Vivado Simulator**. The testbench feeds a raw pixel stream into the Sobel core to validate the mathematical accuracy of the gradients ($G_x$ and $G_y$) and the final edge detection thresholding logic.



### Waveform Analysis

#### 1. General Stream Overview
![Sobel Overview](simulation_waveform.png)
*This view demonstrates the stability of the AXI-Stream control signals (**TVALID**, **TREADY**) and the continuous, synchronized processing of the pixel stream.*

#### 2. Detailed Edge Detection (Zoomed)
![Sobel Detail](sobel_simulation_result.png)
*Detailed verification: The **Gsum** signal effectively peaks at **1020** when a sharp intensity change (edge) is detected, confirming the thresholding logic and mathematical accuracy of the convolution engine.*

---

## Project Structure
* **`src/`**: VHDL source files (Grayscale, Sobel, and Top-level modules).
* **`sim/`**: Testbench files and simulation scripts for verification.
* **`images/`**: Verification waveforms and architectural documentation.

---

## Future Work
- [ ] Integration of a Median Filter for salt-and-pepper noise reduction.
- [ ] Implementation of a Frame Buffer for multi-frame analysis.
- [ ] Hardware-in-the-loop (HIL) testing on a physical FPGA development board (e.g., Zybo or Nexys).

---
**Author:** Mehmet Bera Kaya
