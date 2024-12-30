import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, Timer

@cocotb.test()
async def ocx_dlx_xlx_if_tb(dut):
    """Cocotb testbench for ocx_dlx_xlx_if."""

    # Generate clock for clk_156_25MHz (156.25 MHz => 3.2 ns period)
    clock_156 = Clock(dut.clk_156_25MHz, 3.2, units="ns")
    cocotb.start_soon(clock_156.start())

    # Generate clock for opt_gckn (402 MHz => ~1.24 ns period)
    clock_opt = Clock(dut.opt_gckn, 1.24, units="ns")
    cocotb.start_soon(clock_opt.start())

    # Initialize all inputs
    dut.ocde.value = 0
    dut.hb_gtwiz_reset_all_in.value = 0
    dut.gtwiz_reset_tx_done_in.value = 0
    dut.gtwiz_reset_rx_done_in.value = 0
    dut.gtwiz_buffbypass_tx_done_in.value = 0
    dut.gtwiz_buffbypass_rx_done_in.value = 0
    dut.gtwiz_userclk_tx_active_in.value = 0
    dut.gtwiz_userclk_rx_active_in.value = 0
    dut.pb_io_o0_rx_run_lane.value = 0x00
    dut.send_first.value = 0

    for i in range(8):
        getattr(dut, f"ln{i}_rx_valid_in").value = 0

    # Wait for a stable simulation environment
    await Timer(10, units="ns")

    # Reset sequence
    dut.hb_gtwiz_reset_all_in.value = 1
    await Timer(20, units="ns")
    dut.hb_gtwiz_reset_all_in.value = 0
    dut.send_first.value = 1

    # Simulate sync and retrain
    await Timer(50, units="ns")
    dut.pb_io_o0_rx_run_lane.value = 0xFF  # All lanes active
    await Timer(100, units="ns")
    dut.ocde.value = 1
    dut.gtwiz_reset_tx_done_in.value = 0
    dut.gtwiz_buffbypass_tx_done_in.value = 0
    dut.gtwiz_reset_rx_done_in.value = 1
    dut.gtwiz_buffbypass_rx_done_in.value = 1
    dut.gtwiz_userclk_tx_active_in.value = 0
    dut.gtwiz_userclk_rx_active_in.value = 1

    await Timer(50, units="ns")
    dut.gtwiz_reset_tx_done_in.value = 1
    dut.gtwiz_buffbypass_tx_done_in.value = 0
    dut.gtwiz_userclk_rx_active_in.value = 0
    

    # Test RX valid propagation
    await Timer(50, units="ns")
    dut.ln0_rx_valid_in.value = 1
    dut.ln1_rx_valid_in.value = 0
    dut.ln2_rx_valid_in.value = 0
    dut.ln3_rx_valid_in.value = 1
    dut.ln4_rx_valid_in.value = 1
    dut.ln5_rx_valid_in.value = 1
    dut.ln6_rx_valid_in.value = 1
    dut.ln7_rx_valid_in.value = 1

    dut.gtwiz_reset_tx_done_in.value = 1
    dut.gtwiz_buffbypass_tx_done_in.value = 1

    await Timer(100, units="ns")
    dut.gtwiz_reset_rx_done_in.value = 0
    dut.gtwiz_buffbypass_rx_done_in.value = 0

    # Add assertions to verify outputs
    assert dut.ln0_rx_valid_out.value == 1, "ln0_rx_valid_out did not propagate correctly"
    assert dut.ln3_rx_valid_out.value == 1, "ln3_rx_valid_out did not propagate correctly"

    # Finish simulation
    await Timer(500, units="ns")

