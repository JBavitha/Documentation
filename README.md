# Documentation on ocx_dlx_xlx_if.v
The **ocx_dlx_xlx_if** module acts as a bridge between the OpenCAPI Data Link Exchange (DLX) layer and the Xilinx PHY interface. It facilitates the seamless transfer of data, control signals, and configuration between the OpenCAPI TLx interface and the physical (PHY) layer of a Xilinx transceiver.
### Schematic Diagram

The schematic diagram provides a detailed view of the OCX_DLX_XLX_IF module's architecture.  
[View the Schematic Diagram PDF](./schematic_xlx_if.pdf)

### Signal Descriptions

The detailed documentation of all signals in the `ocx_dlx_xlx_if` module is available here: [Signal Descriptions](./Signal_Descriptions.pdf)

### Logic of Each Test Case

<details>

<summary>Verification of Output Signals (ln0_rx_valid_out to ln7_rx_valid_out)</summary>

## Overview

This section describes the behavior of the outputs `ln0_rx_valid_out`, `ln1_rx_valid_out`, ..., `ln7_rx_valid_out` in relation to the **select line**. The output is driven based on the select line, which is controlled by the AND operation of two input signals (`gtwiz_reset_rx_done_in` and `gtwiz_buffbypass_rx_done_in`)

The following outputs are controlled by the select line:

- `ln0_rx_valid_out`
- `ln1_rx_valid_out`
- `ln2_rx_valid_out`
- `ln3_rx_valid_out`
- `ln4_rx_valid_out`
- `ln5_rx_valid_out`
- `ln6_rx_valid_out`
- `ln7_rx_valid_out`

### Select Line Logic

Each of the above outputs is passed through only if its corresponding **select line** is set to `1`. Otherwise, the output is set to `0`.

### Select Line Condition

The **select line** for each output is determined by the logical AND of two input signals:`gtwiz_reset_rx_done_in` and `gtwiz_buffbypass_rx_done_in`

***case1: select line = 1***
![image](https://github.com/user-attachments/assets/ed1ff6d2-64fd-450e-b556-4c18640addb2)

***case2: select line = 0***
![image](https://github.com/user-attachments/assets/05986343-6377-4ed6-9c12-215b17c13112)

</details>


