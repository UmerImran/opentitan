// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// Testbench module for padctrl. Intended to use with a formal tool.

module padctrl_tb #(
  parameter Impl = "generic"
) (
  input wire                                    clk_i,
  input wire                                    rst_ni,
  output logic                                  clk_o,
  output logic                                  rst_no,
  input  tlul_pkg::tl_h2d_t                     tl_i,
  output tlul_pkg::tl_d2h_t                     tl_o,
  inout  wire  [padctrl_reg_pkg::NMioPads-1:0]  mio_io,
  inout  wire  [padctrl_reg_pkg::NDioPads-1:0]  dio_io,
  input        [padctrl_reg_pkg::NMioPads-1:0]  mio_out_i,
  input        [padctrl_reg_pkg::NMioPads-1:0]  mio_oe_i,
  output logic [padctrl_reg_pkg::NMioPads-1:0]  mio_in_o,
  input        [padctrl_reg_pkg::NDioPads-1:0]  dio_out_i,
  input        [padctrl_reg_pkg::NDioPads-1:0]  dio_oe_i,
  output logic [padctrl_reg_pkg::NDioPads-1:0]  dio_in_o,
  // symbolic inputs for FPV
  input [$clog2(padctrl_reg_pkg::NMioPads)-1:0] mio_sel_i,
  input [$clog2(padctrl_reg_pkg::NDioPads)-1:0] dio_sel_i
);

  logic [padctrl_reg_pkg::NMioPads-1:0][padctrl_reg_pkg::AttrDw-1:0] mio_attr;
  logic [padctrl_reg_pkg::NDioPads-1:0][padctrl_reg_pkg::AttrDw-1:0] dio_attr;

  padctrl i_padctrl (
    .clk_i     ,
    .rst_ni    ,
    .tl_i      ,
    .tl_o      ,
    .mio_attr_o(mio_attr),
    .dio_attr_o(dio_attr)
  );

  padring #(
    .Impl(Impl)
  ) i_padring (
    .clk_i     ,
    .rst_ni    ,
    .clk_o     ,
    .rst_no    ,
    .mio_io    ,
    .dio_io    ,
    .mio_out_i ,
    .mio_oe_i  ,
    .mio_in_o  ,
    .dio_out_i ,
    .dio_oe_i  ,
    .dio_in_o  ,
    .mio_attr_i(mio_attr),
    .dio_attr_i(dio_attr)
  );

endmodule : padctrl_tb
