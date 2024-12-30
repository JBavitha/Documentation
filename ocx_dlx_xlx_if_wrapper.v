`timescale 1ns/1ps

module ocx_dlx_xlx_if_wrapper (
    input clk_156_25MHz,
    input opt_gckn,
    input ocde,
    input hb_gtwiz_reset_all_in,
    output gtwiz_reset_all_out,
    output gtwiz_reset_rx_datapath_out,
    input gtwiz_reset_tx_done_in,
    input gtwiz_reset_rx_done_in,
    input gtwiz_buffbypass_tx_done_in,
    input gtwiz_buffbypass_rx_done_in,
    input gtwiz_userclk_tx_active_in,
    input gtwiz_userclk_rx_active_in,
    output dlx_reset,
    output [7:0] io_pb_o0_rx_init_done,
    input [7:0] pb_io_o0_rx_run_lane,
    input send_first,
    input ln0_rx_valid_in,
    input ln1_rx_valid_in,
    input ln2_rx_valid_in,
    input ln3_rx_valid_in,
    input ln4_rx_valid_in,
    input ln5_rx_valid_in,
    input ln6_rx_valid_in,
    input ln7_rx_valid_in,
    output ln0_rx_valid_out,
    output ln1_rx_valid_out,
    output ln2_rx_valid_out,
    output ln3_rx_valid_out,
    output ln4_rx_valid_out,
    output ln5_rx_valid_out,
    output ln6_rx_valid_out,
    output ln7_rx_valid_out
);

    // Instantiate the DUT
    ocx_dlx_xlx_if dut (
        .clk_156_25MHz(clk_156_25MHz),
        .opt_gckn(opt_gckn),
        .ocde(ocde),
        .hb_gtwiz_reset_all_in(hb_gtwiz_reset_all_in),
        .gtwiz_reset_all_out(gtwiz_reset_all_out),
        .gtwiz_reset_rx_datapath_out(gtwiz_reset_rx_datapath_out),
        .gtwiz_reset_tx_done_in(gtwiz_reset_tx_done_in),
        .gtwiz_reset_rx_done_in(gtwiz_reset_rx_done_in),
        .gtwiz_buffbypass_tx_done_in(gtwiz_buffbypass_tx_done_in),
        .gtwiz_buffbypass_rx_done_in(gtwiz_buffbypass_rx_done_in),
        .gtwiz_userclk_tx_active_in(gtwiz_userclk_tx_active_in),
        .gtwiz_userclk_rx_active_in(gtwiz_userclk_rx_active_in),
        .dlx_reset(dlx_reset),
        .io_pb_o0_rx_init_done(io_pb_o0_rx_init_done),
        .pb_io_o0_rx_run_lane(pb_io_o0_rx_run_lane),
        .send_first(send_first),
        .ln0_rx_valid_in(ln0_rx_valid_in),
        .ln1_rx_valid_in(ln1_rx_valid_in),
        .ln2_rx_valid_in(ln2_rx_valid_in),
        .ln3_rx_valid_in(ln3_rx_valid_in),
        .ln4_rx_valid_in(ln4_rx_valid_in),
        .ln5_rx_valid_in(ln5_rx_valid_in),
        .ln6_rx_valid_in(ln6_rx_valid_in),
        .ln7_rx_valid_in(ln7_rx_valid_in),
        .ln0_rx_valid_out(ln0_rx_valid_out),
        .ln1_rx_valid_out(ln1_rx_valid_out),
        .ln2_rx_valid_out(ln2_rx_valid_out),
        .ln3_rx_valid_out(ln3_rx_valid_out),
        .ln4_rx_valid_out(ln4_rx_valid_out),
        .ln5_rx_valid_out(ln5_rx_valid_out),
        .ln6_rx_valid_out(ln6_rx_valid_out),
        .ln7_rx_valid_out(ln7_rx_valid_out)
    );

    // Waveform Dumping
    initial begin
        $dumpfile("ocx_dlx_xlx_if_wrapper.vcd"); // Specify the VCD file name
        $dumpvars(0, ocx_dlx_xlx_if_wrapper);     // Dump all variables in the module
    end

endmodule

