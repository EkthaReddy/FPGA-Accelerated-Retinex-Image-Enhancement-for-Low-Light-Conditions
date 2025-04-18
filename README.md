# FPGA-Accelerated Retinex Image Enhancement for Low-Light Conditions

## Authors
- Ektha Sudhakar Reddy (111721104036)  
- Anusri G S (111721104010)  
- Aswini R (111721104014)  

**Supervisor:** Mr. Siva Kumar A, Associate Professor, Department of ECE  
**Institution:** R.M.K. Engineering College, Tamil Nadu  
**Academic Year:** 2024–2025  
**Platform:** Xilinx Vivado 2023.2  
**Target FPGA:** Artix-7 (Basys 3 Board)

---

## Abstract

This project addresses the challenge of real-time image enhancement in low-light conditions through a hardware-accelerated implementation of a Retinex-based algorithm on an FPGA. The proposed method leverages the Retinex theory, which models an image as the product of illumination and reflectance components. The algorithm performs illumination estimation through a hardware-friendly edge-preserving filter, enabling effective contrast enhancement and detail preservation. The implementation uses fixed-point arithmetic and parallel processing to reduce computational load, making it suitable for power-constrained, real-time applications in surveillance, autonomous vehicles, and medical imaging.

---

## Objectives

1. To implement a Retinex-based image enhancement algorithm on FPGA for real-time low-light image enhancement.
2. To reduce the hardware complexity of conventional Retinex methods through approximation and filter simplification.
3. To ensure accurate edge preservation while eliminating block artifacts in illumination estimation.
4. To optimize the algorithm for energy efficiency and low latency using Verilog HDL and Vivado Design Suite.
5. To validate the system’s effectiveness through simulation, synthesis, and comparison with traditional software-based methods.

---

## Literature Review

Conventional methods for low-light image enhancement, including Histogram Equalization and Gamma Correction, are computationally simple but often fail to preserve details or introduce visual artifacts. More advanced methods include:

![image](https://github.com/user-attachments/assets/0d8531fa-a564-4c98-991d-1673b17a5323)


---

## Proposed Method

### Theoretical Background

According to Retinex theory, an image \( P(x, y) \) is expressed as:
\[ P(x, y) = E(x, y) \cdot R(x, y) \]
where:
- \( E(x, y) \): Illumination component (smooth, low-frequency)
- \( R(x, y) \): Reflectance component (fine details, edges)

### Algorithm Overview

1. **Illumination Estimation:** Extracted using the maximum of the RGB channels in a local region. Initial estimation introduces blocky artifacts due to max-pooling.
2. **Edge-Preserving Filtering:** An edge-preserving filter is used to refine illumination based on a guidance image. Simplification from 2D to 1D reduces the number of multipliers and adders required, improving hardware efficiency.
3. **Reflectance Computation:** Reflectance is obtained by dividing the original image by the refined illumination map.
4. **Contrast Enhancement:** A contrast stretch function modifies the illumination to improve brightness and naturalness.
5. **Final Reconstruction:** The enhanced image is obtained by combining the reflectance and enhanced illumination.


---

## Block Diagram

The block diagram consists of the following stages:

- Input Image
- Channel Maximum Estimation (Guidance Image)
- Coarse Illumination Estimation
- Edge-Preserving Filter
- Illumination Refinement
- Reflectance Estimation
- Contrast Enhancement
- Final Image Output

![image](https://github.com/user-attachments/assets/b3c02e72-be09-441b-b1f6-b23eb3320f0a)


Each stage is mapped to Verilog modules and synthesized using Vivado for FPGA deployment.

---

### Optimization Techniques

- Use of fixed-point representation to minimize hardware resource usage.
- Conversion of 2D filtering to 1D to reduce computation.
- Efficient memory access and scheduling for real-time image streaming.

---

## Results
![image](https://github.com/user-attachments/assets/354e39ca-1aea-419b-b594-e80a3d16764a)

**Circuit Diagram**
![image](https://github.com/user-attachments/assets/0f07ff1a-4c3b-4439-9b14-8c74b17b17bb)

---

## Advantages

- Real-time enhancement suitable for embedded platforms.
- Reduced computational load due to fixed-point and 1D filter design.
- Accurate edge preservation with low memory usage.
- Enhanced image quality with natural contrast and reduced artifacts.
- Scalable architecture for variable image resolutions.
- Energy-efficient implementation for portable and battery-powered devices.

---

## Applications

- Night vision and surveillance systems
- Low-light assistance for autonomous vehicles
- Medical imaging (e.g., X-ray, endoscopy)
- Satellite and drone-based remote sensing
- Underwater image enhancement
- Industrial inspection and robotics
- Forensic image processing
- Consumer photography in low-light conditions

---

## References

1. H. Wang et al., “SFNet-N: An improved SFNet algorithm for semantic segmentation of low-light autonomous driving road scenes,” IEEE Transactions on Intelligent Transportation Systems, 2022.
2. D. J. Jobson, Z. Rahman, and G. A. Woodell, “Properties and performance of a center/surround retinex,” IEEE Transactions on Image Processing, 1997.
3. D. J. Jobson et al., “A multiscale retinex for bridging the gap between color images and the human observation of scenes,” IEEE Transactions on Image Processing, 1997.
4. W. Wang et al., “An experiment-based review of low-light image enhancement methods,” IEEE Access, 2020.
5. X. Guo et al., “LIME: Low-light image enhancement via illumination map estimation,” IEEE Transactions on Image Processing, 2017.

> For full references and source material, see the attached Report and Journal Paper in this repository.

