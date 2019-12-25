//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
//Date        : Wed Nov  6 18:24:50 2019
//Host        : DESKTOP-T3C5JMR running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (default_250mhz_clk1_clk_n,
    default_250mhz_clk1_clk_p,
    reset,
    rs232_uart_rxd,
    rs232_uart_txd);
  input default_250mhz_clk1_clk_n;
  input default_250mhz_clk1_clk_p;
  input reset;
  input rs232_uart_rxd;
  output rs232_uart_txd;

  wire default_250mhz_clk1_clk_n;
  wire default_250mhz_clk1_clk_p;
  wire reset;
  wire rs232_uart_rxd;
  wire rs232_uart_txd;

  design_1 design_1_i
       (.default_250mhz_clk1_clk_n(default_250mhz_clk1_clk_n),
        .default_250mhz_clk1_clk_p(default_250mhz_clk1_clk_p),
        .reset(reset),
        .rs232_uart_rxd(rs232_uart_rxd),
        .rs232_uart_txd(rs232_uart_txd));
endmodule
