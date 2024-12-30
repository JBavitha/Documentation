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

### Overview

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



<details>

<summary>Verification of dlx_reset</summary>

### When send_first = 1'b1:
- The DLx immediately starts transmitting pattern 'A' as soon as the Xilinx transmitter is initialized.
- This is determined by checking ~(gtwiz_reset_tx_done_in & gtwiz_buffbypass_tx_done_in).
- If both signals are asserted (1), it indicates the transmitter is fully initialized and ready to transmit.

### When send_first = 1'b0:

- The DLx waits until the Xilinx receiver is initialized before transmitting pattern 'A'.
- The logic checks the state of rec_first_xtsm_q.
  - If rec_first_xtsm_q = 0, the DLx asserts dlx_reset low only when gtwiz_reset_rx_done_in & gtwiz_buffbypass_rx_done_in are both asserted.
  - This indicates the receiver has completed initialization.
- If rec_first_xtsm_q = 1, it monitors the transmitter signals to reset again if necessary.

![image](https://github.com/user-attachments/assets/b1e5e889-edcb-4685-bd33-eb9e4dec1f3a)

</details>


<details>

<summary>Verification of io_pb_o0_rx_init_done</summary>

Each bit in the vector represents the initialization status of a lane (io_pb_o0_rx_init_done[n] for lane n). The signal is updated based on a lane’s training and synchronization status, driven by the FSM logic for RX training.

- xtsm_q: State variable controlling the transceiver's receiver initialization process.
  - The output becomes high when the state machine enters the pulse_done state, provided the following conditions are met:
    - gtwiz_reset_rx_done_in: Receiver reset is complete.
    - gtwiz_buffbypass_rx_done_in: Buffer bypass is complete.
    - gtwiz_userclk_rx_active_in: Receiver user clock is active.

- If the state machine is not in pulse_done, the signal remains 8'b0.

</details>




<details>

<summary>Verification of gtwiz_reset_rx_datapath_out</summary>

### The FSM operates in three states:
- find_sync (State 0):
  - The FSM waits for all lanes to detect the sync pattern.
  - Transition to hold_pulse occurs when all lanes (pb_io_o0_rx_run_lane) are active.

- hold_pulse (State 1):
  - The FSM asserts gtwiz_reset_rx_datapath_out (set to 1'b1) to reset the receiver datapath.
  - A counter (pulse_count_q) ensures the reset signal remains asserted for 7 clock cycles of opt_gckn (the 156.25 MHz clock).
  - Transition to pulse_done occurs after the counter reaches the maximum value.

- pulse_done (State 2):
  - The FSM deasserts gtwiz_reset_rx_datapath_out (set to 1'b0), completing the reset process.
  - The FSM transitions back to find_sync if the transceiver reset conditions (~gtwiz_reset_tx_done_in and ~gtwiz_buffbypass_tx_done_in) are met.
 
![image](https://github.com/user-attachments/assets/be139978-d467-4120-8a8f-4e15ca9b95d5)


</details>






