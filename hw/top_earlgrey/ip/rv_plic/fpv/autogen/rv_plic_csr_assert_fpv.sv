// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

// FPV CSR read and write assertions auto-generated by `reggen` containing data structure
// Do Not Edit directly


`include "prim_assert.sv"

// Block: rv_plic
module rv_plic_csr_assert_fpv import tlul_pkg::*; (
  input clk_i,
  input rst_ni,

  //tile link ports
  input tl_h2d_t h2d,
  input tl_d2h_t d2h
);

  // mask register to convert byte to bit
  logic [31:0] a_mask_bit;

  assign a_mask_bit[7:0]   = h2d.a_mask[0] ? '1 : '0;
  assign a_mask_bit[15:8]  = h2d.a_mask[1] ? '1 : '0;
  assign a_mask_bit[23:16] = h2d.a_mask[2] ? '1 : '0;
  assign a_mask_bit[31:24] = h2d.a_mask[3] ? '1 : '0;

  // declare common read and write sequences
  sequence device_wr_S(logic [9:0] addr);
    h2d.a_address == addr && h2d.a_opcode inside {PutFullData, PutPartialData} && h2d.a_valid && h2d.d_ready && !d2h.d_valid;
  endsequence

  sequence device_rd_S(logic [9:0] addr);
    h2d.a_address == addr && h2d.a_opcode inside {Get} && h2d.a_valid && h2d.d_ready && !d2h.d_valid;
  endsequence

  // declare common read and write properties
  property wr_P(int width, bit [9:0] addr, bit [31:0] compare_data, bit regen = 1);
    logic [31:0] id;
    logic [width:0] data;
    (device_wr_S(addr),id = h2d.a_source, data = h2d.a_data & a_mask_bit) |->
        strong(##[1:$] (d2h.d_valid && d2h.d_source == id && (d2h.d_error ||
        (!d2h.d_error && compare_data == data) || !regen)));
  endproperty

  property wr_ext_P(int width, bit [9:0] addr, bit [31:0] compare_data, bit regen = 1);
    logic [31:0] id;
    logic [width:0] data;
    logic [width:0] compare_value;
    (device_wr_S(addr),id = h2d.a_source, data = h2d.a_data & a_mask_bit,
        compare_value = compare_data) |->
        strong(##[1:$] (d2h.d_valid && d2h.d_source == id && (d2h.d_error ||
        (!d2h.d_error && compare_value == data) || !regen)));
  endproperty

  property rd_P(int width, bit [9:0] addr, bit [31:0] compare_data);
    logic [31:0] id;
    logic [width:0] data;
    (device_rd_S(addr), id = h2d.a_source, data = $past(compare_data)) |->
        strong(##[1:$] (d2h.d_valid && d2h.d_source == id && (d2h.d_error ||
        (!d2h.d_error && d2h.d_data == data))));
  endproperty

  property rd_ext_P(int width, bit [9:0] addr, bit [31:0] compare_data);
    logic [31:0] id;
    logic [width:0] data;
    (device_rd_S(addr), id = h2d.a_source, data = compare_data) |->
        strong(##[1:$] (d2h.d_valid && d2h.d_source == id && (d2h.d_error ||
        (!d2h.d_error && d2h.d_data == data))));
  endproperty

  property wr_regen_stable_P(regen, compare_data);
    (!regen && $stable(regen)) |-> $stable(compare_data);
  endproperty

// for all the regsters, declare assertion

  // define local fpv variable for the multi_reg
  logic [79:0] ip_d_fpv;
  for (genvar s = 0; s <= 79; s++) begin : gen_ip_wr
    assign ip_d_fpv[s] = i_rv_plic.hw2reg.ip[s].d;
  end

  // read/write assertions for register: ip0
  `ASSERT(ip0_rd_A, rd_P(31, 10'h0, ip_d_fpv[31:0]))

  // read/write assertions for register: ip1
  `ASSERT(ip1_rd_A, rd_P(31, 10'h4, ip_d_fpv[63:32]))

  // read/write assertions for register: ip2
  `ASSERT(ip2_rd_A, rd_P(15, 10'h8, ip_d_fpv[79:64]))

  // define local fpv variable for the multi_reg
  logic [79:0] le_q_fpv;
  for (genvar s = 0; s <= 79; s++) begin : gen_le_rd
    assign le_q_fpv[s] = i_rv_plic.reg2hw.le[s].q;
  end

  // read/write assertions for register: le0
  `ASSERT(le0_wr_A, wr_P(31, 10'hc, le_q_fpv[31:0], 0))
  `ASSERT(le0_rd_A, rd_P(31, 10'hc, le_q_fpv[31:0]))

  // read/write assertions for register: le1
  `ASSERT(le1_wr_A, wr_P(31, 10'h10, le_q_fpv[63:32], 0))
  `ASSERT(le1_rd_A, rd_P(31, 10'h10, le_q_fpv[63:32]))

  // read/write assertions for register: le2
  `ASSERT(le2_wr_A, wr_P(15, 10'h14, le_q_fpv[79:64], 0))
  `ASSERT(le2_rd_A, rd_P(15, 10'h14, le_q_fpv[79:64]))

  // read/write assertions for register: prio0
  `ASSERT(prio0_wr_A, wr_P(1, 10'h18, i_rv_plic.reg2hw.prio0.q, 0))
  `ASSERT(prio0_rd_A, rd_P(1, 10'h18, i_rv_plic.reg2hw.prio0.q))

  // read/write assertions for register: prio1
  `ASSERT(prio1_wr_A, wr_P(1, 10'h1c, i_rv_plic.reg2hw.prio1.q, 0))
  `ASSERT(prio1_rd_A, rd_P(1, 10'h1c, i_rv_plic.reg2hw.prio1.q))

  // read/write assertions for register: prio2
  `ASSERT(prio2_wr_A, wr_P(1, 10'h20, i_rv_plic.reg2hw.prio2.q, 0))
  `ASSERT(prio2_rd_A, rd_P(1, 10'h20, i_rv_plic.reg2hw.prio2.q))

  // read/write assertions for register: prio3
  `ASSERT(prio3_wr_A, wr_P(1, 10'h24, i_rv_plic.reg2hw.prio3.q, 0))
  `ASSERT(prio3_rd_A, rd_P(1, 10'h24, i_rv_plic.reg2hw.prio3.q))

  // read/write assertions for register: prio4
  `ASSERT(prio4_wr_A, wr_P(1, 10'h28, i_rv_plic.reg2hw.prio4.q, 0))
  `ASSERT(prio4_rd_A, rd_P(1, 10'h28, i_rv_plic.reg2hw.prio4.q))

  // read/write assertions for register: prio5
  `ASSERT(prio5_wr_A, wr_P(1, 10'h2c, i_rv_plic.reg2hw.prio5.q, 0))
  `ASSERT(prio5_rd_A, rd_P(1, 10'h2c, i_rv_plic.reg2hw.prio5.q))

  // read/write assertions for register: prio6
  `ASSERT(prio6_wr_A, wr_P(1, 10'h30, i_rv_plic.reg2hw.prio6.q, 0))
  `ASSERT(prio6_rd_A, rd_P(1, 10'h30, i_rv_plic.reg2hw.prio6.q))

  // read/write assertions for register: prio7
  `ASSERT(prio7_wr_A, wr_P(1, 10'h34, i_rv_plic.reg2hw.prio7.q, 0))
  `ASSERT(prio7_rd_A, rd_P(1, 10'h34, i_rv_plic.reg2hw.prio7.q))

  // read/write assertions for register: prio8
  `ASSERT(prio8_wr_A, wr_P(1, 10'h38, i_rv_plic.reg2hw.prio8.q, 0))
  `ASSERT(prio8_rd_A, rd_P(1, 10'h38, i_rv_plic.reg2hw.prio8.q))

  // read/write assertions for register: prio9
  `ASSERT(prio9_wr_A, wr_P(1, 10'h3c, i_rv_plic.reg2hw.prio9.q, 0))
  `ASSERT(prio9_rd_A, rd_P(1, 10'h3c, i_rv_plic.reg2hw.prio9.q))

  // read/write assertions for register: prio10
  `ASSERT(prio10_wr_A, wr_P(1, 10'h40, i_rv_plic.reg2hw.prio10.q, 0))
  `ASSERT(prio10_rd_A, rd_P(1, 10'h40, i_rv_plic.reg2hw.prio10.q))

  // read/write assertions for register: prio11
  `ASSERT(prio11_wr_A, wr_P(1, 10'h44, i_rv_plic.reg2hw.prio11.q, 0))
  `ASSERT(prio11_rd_A, rd_P(1, 10'h44, i_rv_plic.reg2hw.prio11.q))

  // read/write assertions for register: prio12
  `ASSERT(prio12_wr_A, wr_P(1, 10'h48, i_rv_plic.reg2hw.prio12.q, 0))
  `ASSERT(prio12_rd_A, rd_P(1, 10'h48, i_rv_plic.reg2hw.prio12.q))

  // read/write assertions for register: prio13
  `ASSERT(prio13_wr_A, wr_P(1, 10'h4c, i_rv_plic.reg2hw.prio13.q, 0))
  `ASSERT(prio13_rd_A, rd_P(1, 10'h4c, i_rv_plic.reg2hw.prio13.q))

  // read/write assertions for register: prio14
  `ASSERT(prio14_wr_A, wr_P(1, 10'h50, i_rv_plic.reg2hw.prio14.q, 0))
  `ASSERT(prio14_rd_A, rd_P(1, 10'h50, i_rv_plic.reg2hw.prio14.q))

  // read/write assertions for register: prio15
  `ASSERT(prio15_wr_A, wr_P(1, 10'h54, i_rv_plic.reg2hw.prio15.q, 0))
  `ASSERT(prio15_rd_A, rd_P(1, 10'h54, i_rv_plic.reg2hw.prio15.q))

  // read/write assertions for register: prio16
  `ASSERT(prio16_wr_A, wr_P(1, 10'h58, i_rv_plic.reg2hw.prio16.q, 0))
  `ASSERT(prio16_rd_A, rd_P(1, 10'h58, i_rv_plic.reg2hw.prio16.q))

  // read/write assertions for register: prio17
  `ASSERT(prio17_wr_A, wr_P(1, 10'h5c, i_rv_plic.reg2hw.prio17.q, 0))
  `ASSERT(prio17_rd_A, rd_P(1, 10'h5c, i_rv_plic.reg2hw.prio17.q))

  // read/write assertions for register: prio18
  `ASSERT(prio18_wr_A, wr_P(1, 10'h60, i_rv_plic.reg2hw.prio18.q, 0))
  `ASSERT(prio18_rd_A, rd_P(1, 10'h60, i_rv_plic.reg2hw.prio18.q))

  // read/write assertions for register: prio19
  `ASSERT(prio19_wr_A, wr_P(1, 10'h64, i_rv_plic.reg2hw.prio19.q, 0))
  `ASSERT(prio19_rd_A, rd_P(1, 10'h64, i_rv_plic.reg2hw.prio19.q))

  // read/write assertions for register: prio20
  `ASSERT(prio20_wr_A, wr_P(1, 10'h68, i_rv_plic.reg2hw.prio20.q, 0))
  `ASSERT(prio20_rd_A, rd_P(1, 10'h68, i_rv_plic.reg2hw.prio20.q))

  // read/write assertions for register: prio21
  `ASSERT(prio21_wr_A, wr_P(1, 10'h6c, i_rv_plic.reg2hw.prio21.q, 0))
  `ASSERT(prio21_rd_A, rd_P(1, 10'h6c, i_rv_plic.reg2hw.prio21.q))

  // read/write assertions for register: prio22
  `ASSERT(prio22_wr_A, wr_P(1, 10'h70, i_rv_plic.reg2hw.prio22.q, 0))
  `ASSERT(prio22_rd_A, rd_P(1, 10'h70, i_rv_plic.reg2hw.prio22.q))

  // read/write assertions for register: prio23
  `ASSERT(prio23_wr_A, wr_P(1, 10'h74, i_rv_plic.reg2hw.prio23.q, 0))
  `ASSERT(prio23_rd_A, rd_P(1, 10'h74, i_rv_plic.reg2hw.prio23.q))

  // read/write assertions for register: prio24
  `ASSERT(prio24_wr_A, wr_P(1, 10'h78, i_rv_plic.reg2hw.prio24.q, 0))
  `ASSERT(prio24_rd_A, rd_P(1, 10'h78, i_rv_plic.reg2hw.prio24.q))

  // read/write assertions for register: prio25
  `ASSERT(prio25_wr_A, wr_P(1, 10'h7c, i_rv_plic.reg2hw.prio25.q, 0))
  `ASSERT(prio25_rd_A, rd_P(1, 10'h7c, i_rv_plic.reg2hw.prio25.q))

  // read/write assertions for register: prio26
  `ASSERT(prio26_wr_A, wr_P(1, 10'h80, i_rv_plic.reg2hw.prio26.q, 0))
  `ASSERT(prio26_rd_A, rd_P(1, 10'h80, i_rv_plic.reg2hw.prio26.q))

  // read/write assertions for register: prio27
  `ASSERT(prio27_wr_A, wr_P(1, 10'h84, i_rv_plic.reg2hw.prio27.q, 0))
  `ASSERT(prio27_rd_A, rd_P(1, 10'h84, i_rv_plic.reg2hw.prio27.q))

  // read/write assertions for register: prio28
  `ASSERT(prio28_wr_A, wr_P(1, 10'h88, i_rv_plic.reg2hw.prio28.q, 0))
  `ASSERT(prio28_rd_A, rd_P(1, 10'h88, i_rv_plic.reg2hw.prio28.q))

  // read/write assertions for register: prio29
  `ASSERT(prio29_wr_A, wr_P(1, 10'h8c, i_rv_plic.reg2hw.prio29.q, 0))
  `ASSERT(prio29_rd_A, rd_P(1, 10'h8c, i_rv_plic.reg2hw.prio29.q))

  // read/write assertions for register: prio30
  `ASSERT(prio30_wr_A, wr_P(1, 10'h90, i_rv_plic.reg2hw.prio30.q, 0))
  `ASSERT(prio30_rd_A, rd_P(1, 10'h90, i_rv_plic.reg2hw.prio30.q))

  // read/write assertions for register: prio31
  `ASSERT(prio31_wr_A, wr_P(1, 10'h94, i_rv_plic.reg2hw.prio31.q, 0))
  `ASSERT(prio31_rd_A, rd_P(1, 10'h94, i_rv_plic.reg2hw.prio31.q))

  // read/write assertions for register: prio32
  `ASSERT(prio32_wr_A, wr_P(1, 10'h98, i_rv_plic.reg2hw.prio32.q, 0))
  `ASSERT(prio32_rd_A, rd_P(1, 10'h98, i_rv_plic.reg2hw.prio32.q))

  // read/write assertions for register: prio33
  `ASSERT(prio33_wr_A, wr_P(1, 10'h9c, i_rv_plic.reg2hw.prio33.q, 0))
  `ASSERT(prio33_rd_A, rd_P(1, 10'h9c, i_rv_plic.reg2hw.prio33.q))

  // read/write assertions for register: prio34
  `ASSERT(prio34_wr_A, wr_P(1, 10'ha0, i_rv_plic.reg2hw.prio34.q, 0))
  `ASSERT(prio34_rd_A, rd_P(1, 10'ha0, i_rv_plic.reg2hw.prio34.q))

  // read/write assertions for register: prio35
  `ASSERT(prio35_wr_A, wr_P(1, 10'ha4, i_rv_plic.reg2hw.prio35.q, 0))
  `ASSERT(prio35_rd_A, rd_P(1, 10'ha4, i_rv_plic.reg2hw.prio35.q))

  // read/write assertions for register: prio36
  `ASSERT(prio36_wr_A, wr_P(1, 10'ha8, i_rv_plic.reg2hw.prio36.q, 0))
  `ASSERT(prio36_rd_A, rd_P(1, 10'ha8, i_rv_plic.reg2hw.prio36.q))

  // read/write assertions for register: prio37
  `ASSERT(prio37_wr_A, wr_P(1, 10'hac, i_rv_plic.reg2hw.prio37.q, 0))
  `ASSERT(prio37_rd_A, rd_P(1, 10'hac, i_rv_plic.reg2hw.prio37.q))

  // read/write assertions for register: prio38
  `ASSERT(prio38_wr_A, wr_P(1, 10'hb0, i_rv_plic.reg2hw.prio38.q, 0))
  `ASSERT(prio38_rd_A, rd_P(1, 10'hb0, i_rv_plic.reg2hw.prio38.q))

  // read/write assertions for register: prio39
  `ASSERT(prio39_wr_A, wr_P(1, 10'hb4, i_rv_plic.reg2hw.prio39.q, 0))
  `ASSERT(prio39_rd_A, rd_P(1, 10'hb4, i_rv_plic.reg2hw.prio39.q))

  // read/write assertions for register: prio40
  `ASSERT(prio40_wr_A, wr_P(1, 10'hb8, i_rv_plic.reg2hw.prio40.q, 0))
  `ASSERT(prio40_rd_A, rd_P(1, 10'hb8, i_rv_plic.reg2hw.prio40.q))

  // read/write assertions for register: prio41
  `ASSERT(prio41_wr_A, wr_P(1, 10'hbc, i_rv_plic.reg2hw.prio41.q, 0))
  `ASSERT(prio41_rd_A, rd_P(1, 10'hbc, i_rv_plic.reg2hw.prio41.q))

  // read/write assertions for register: prio42
  `ASSERT(prio42_wr_A, wr_P(1, 10'hc0, i_rv_plic.reg2hw.prio42.q, 0))
  `ASSERT(prio42_rd_A, rd_P(1, 10'hc0, i_rv_plic.reg2hw.prio42.q))

  // read/write assertions for register: prio43
  `ASSERT(prio43_wr_A, wr_P(1, 10'hc4, i_rv_plic.reg2hw.prio43.q, 0))
  `ASSERT(prio43_rd_A, rd_P(1, 10'hc4, i_rv_plic.reg2hw.prio43.q))

  // read/write assertions for register: prio44
  `ASSERT(prio44_wr_A, wr_P(1, 10'hc8, i_rv_plic.reg2hw.prio44.q, 0))
  `ASSERT(prio44_rd_A, rd_P(1, 10'hc8, i_rv_plic.reg2hw.prio44.q))

  // read/write assertions for register: prio45
  `ASSERT(prio45_wr_A, wr_P(1, 10'hcc, i_rv_plic.reg2hw.prio45.q, 0))
  `ASSERT(prio45_rd_A, rd_P(1, 10'hcc, i_rv_plic.reg2hw.prio45.q))

  // read/write assertions for register: prio46
  `ASSERT(prio46_wr_A, wr_P(1, 10'hd0, i_rv_plic.reg2hw.prio46.q, 0))
  `ASSERT(prio46_rd_A, rd_P(1, 10'hd0, i_rv_plic.reg2hw.prio46.q))

  // read/write assertions for register: prio47
  `ASSERT(prio47_wr_A, wr_P(1, 10'hd4, i_rv_plic.reg2hw.prio47.q, 0))
  `ASSERT(prio47_rd_A, rd_P(1, 10'hd4, i_rv_plic.reg2hw.prio47.q))

  // read/write assertions for register: prio48
  `ASSERT(prio48_wr_A, wr_P(1, 10'hd8, i_rv_plic.reg2hw.prio48.q, 0))
  `ASSERT(prio48_rd_A, rd_P(1, 10'hd8, i_rv_plic.reg2hw.prio48.q))

  // read/write assertions for register: prio49
  `ASSERT(prio49_wr_A, wr_P(1, 10'hdc, i_rv_plic.reg2hw.prio49.q, 0))
  `ASSERT(prio49_rd_A, rd_P(1, 10'hdc, i_rv_plic.reg2hw.prio49.q))

  // read/write assertions for register: prio50
  `ASSERT(prio50_wr_A, wr_P(1, 10'he0, i_rv_plic.reg2hw.prio50.q, 0))
  `ASSERT(prio50_rd_A, rd_P(1, 10'he0, i_rv_plic.reg2hw.prio50.q))

  // read/write assertions for register: prio51
  `ASSERT(prio51_wr_A, wr_P(1, 10'he4, i_rv_plic.reg2hw.prio51.q, 0))
  `ASSERT(prio51_rd_A, rd_P(1, 10'he4, i_rv_plic.reg2hw.prio51.q))

  // read/write assertions for register: prio52
  `ASSERT(prio52_wr_A, wr_P(1, 10'he8, i_rv_plic.reg2hw.prio52.q, 0))
  `ASSERT(prio52_rd_A, rd_P(1, 10'he8, i_rv_plic.reg2hw.prio52.q))

  // read/write assertions for register: prio53
  `ASSERT(prio53_wr_A, wr_P(1, 10'hec, i_rv_plic.reg2hw.prio53.q, 0))
  `ASSERT(prio53_rd_A, rd_P(1, 10'hec, i_rv_plic.reg2hw.prio53.q))

  // read/write assertions for register: prio54
  `ASSERT(prio54_wr_A, wr_P(1, 10'hf0, i_rv_plic.reg2hw.prio54.q, 0))
  `ASSERT(prio54_rd_A, rd_P(1, 10'hf0, i_rv_plic.reg2hw.prio54.q))

  // read/write assertions for register: prio55
  `ASSERT(prio55_wr_A, wr_P(1, 10'hf4, i_rv_plic.reg2hw.prio55.q, 0))
  `ASSERT(prio55_rd_A, rd_P(1, 10'hf4, i_rv_plic.reg2hw.prio55.q))

  // read/write assertions for register: prio56
  `ASSERT(prio56_wr_A, wr_P(1, 10'hf8, i_rv_plic.reg2hw.prio56.q, 0))
  `ASSERT(prio56_rd_A, rd_P(1, 10'hf8, i_rv_plic.reg2hw.prio56.q))

  // read/write assertions for register: prio57
  `ASSERT(prio57_wr_A, wr_P(1, 10'hfc, i_rv_plic.reg2hw.prio57.q, 0))
  `ASSERT(prio57_rd_A, rd_P(1, 10'hfc, i_rv_plic.reg2hw.prio57.q))

  // read/write assertions for register: prio58
  `ASSERT(prio58_wr_A, wr_P(1, 10'h100, i_rv_plic.reg2hw.prio58.q, 0))
  `ASSERT(prio58_rd_A, rd_P(1, 10'h100, i_rv_plic.reg2hw.prio58.q))

  // read/write assertions for register: prio59
  `ASSERT(prio59_wr_A, wr_P(1, 10'h104, i_rv_plic.reg2hw.prio59.q, 0))
  `ASSERT(prio59_rd_A, rd_P(1, 10'h104, i_rv_plic.reg2hw.prio59.q))

  // read/write assertions for register: prio60
  `ASSERT(prio60_wr_A, wr_P(1, 10'h108, i_rv_plic.reg2hw.prio60.q, 0))
  `ASSERT(prio60_rd_A, rd_P(1, 10'h108, i_rv_plic.reg2hw.prio60.q))

  // read/write assertions for register: prio61
  `ASSERT(prio61_wr_A, wr_P(1, 10'h10c, i_rv_plic.reg2hw.prio61.q, 0))
  `ASSERT(prio61_rd_A, rd_P(1, 10'h10c, i_rv_plic.reg2hw.prio61.q))

  // read/write assertions for register: prio62
  `ASSERT(prio62_wr_A, wr_P(1, 10'h110, i_rv_plic.reg2hw.prio62.q, 0))
  `ASSERT(prio62_rd_A, rd_P(1, 10'h110, i_rv_plic.reg2hw.prio62.q))

  // read/write assertions for register: prio63
  `ASSERT(prio63_wr_A, wr_P(1, 10'h114, i_rv_plic.reg2hw.prio63.q, 0))
  `ASSERT(prio63_rd_A, rd_P(1, 10'h114, i_rv_plic.reg2hw.prio63.q))

  // read/write assertions for register: prio64
  `ASSERT(prio64_wr_A, wr_P(1, 10'h118, i_rv_plic.reg2hw.prio64.q, 0))
  `ASSERT(prio64_rd_A, rd_P(1, 10'h118, i_rv_plic.reg2hw.prio64.q))

  // read/write assertions for register: prio65
  `ASSERT(prio65_wr_A, wr_P(1, 10'h11c, i_rv_plic.reg2hw.prio65.q, 0))
  `ASSERT(prio65_rd_A, rd_P(1, 10'h11c, i_rv_plic.reg2hw.prio65.q))

  // read/write assertions for register: prio66
  `ASSERT(prio66_wr_A, wr_P(1, 10'h120, i_rv_plic.reg2hw.prio66.q, 0))
  `ASSERT(prio66_rd_A, rd_P(1, 10'h120, i_rv_plic.reg2hw.prio66.q))

  // read/write assertions for register: prio67
  `ASSERT(prio67_wr_A, wr_P(1, 10'h124, i_rv_plic.reg2hw.prio67.q, 0))
  `ASSERT(prio67_rd_A, rd_P(1, 10'h124, i_rv_plic.reg2hw.prio67.q))

  // read/write assertions for register: prio68
  `ASSERT(prio68_wr_A, wr_P(1, 10'h128, i_rv_plic.reg2hw.prio68.q, 0))
  `ASSERT(prio68_rd_A, rd_P(1, 10'h128, i_rv_plic.reg2hw.prio68.q))

  // read/write assertions for register: prio69
  `ASSERT(prio69_wr_A, wr_P(1, 10'h12c, i_rv_plic.reg2hw.prio69.q, 0))
  `ASSERT(prio69_rd_A, rd_P(1, 10'h12c, i_rv_plic.reg2hw.prio69.q))

  // read/write assertions for register: prio70
  `ASSERT(prio70_wr_A, wr_P(1, 10'h130, i_rv_plic.reg2hw.prio70.q, 0))
  `ASSERT(prio70_rd_A, rd_P(1, 10'h130, i_rv_plic.reg2hw.prio70.q))

  // read/write assertions for register: prio71
  `ASSERT(prio71_wr_A, wr_P(1, 10'h134, i_rv_plic.reg2hw.prio71.q, 0))
  `ASSERT(prio71_rd_A, rd_P(1, 10'h134, i_rv_plic.reg2hw.prio71.q))

  // read/write assertions for register: prio72
  `ASSERT(prio72_wr_A, wr_P(1, 10'h138, i_rv_plic.reg2hw.prio72.q, 0))
  `ASSERT(prio72_rd_A, rd_P(1, 10'h138, i_rv_plic.reg2hw.prio72.q))

  // read/write assertions for register: prio73
  `ASSERT(prio73_wr_A, wr_P(1, 10'h13c, i_rv_plic.reg2hw.prio73.q, 0))
  `ASSERT(prio73_rd_A, rd_P(1, 10'h13c, i_rv_plic.reg2hw.prio73.q))

  // read/write assertions for register: prio74
  `ASSERT(prio74_wr_A, wr_P(1, 10'h140, i_rv_plic.reg2hw.prio74.q, 0))
  `ASSERT(prio74_rd_A, rd_P(1, 10'h140, i_rv_plic.reg2hw.prio74.q))

  // read/write assertions for register: prio75
  `ASSERT(prio75_wr_A, wr_P(1, 10'h144, i_rv_plic.reg2hw.prio75.q, 0))
  `ASSERT(prio75_rd_A, rd_P(1, 10'h144, i_rv_plic.reg2hw.prio75.q))

  // read/write assertions for register: prio76
  `ASSERT(prio76_wr_A, wr_P(1, 10'h148, i_rv_plic.reg2hw.prio76.q, 0))
  `ASSERT(prio76_rd_A, rd_P(1, 10'h148, i_rv_plic.reg2hw.prio76.q))

  // read/write assertions for register: prio77
  `ASSERT(prio77_wr_A, wr_P(1, 10'h14c, i_rv_plic.reg2hw.prio77.q, 0))
  `ASSERT(prio77_rd_A, rd_P(1, 10'h14c, i_rv_plic.reg2hw.prio77.q))

  // read/write assertions for register: prio78
  `ASSERT(prio78_wr_A, wr_P(1, 10'h150, i_rv_plic.reg2hw.prio78.q, 0))
  `ASSERT(prio78_rd_A, rd_P(1, 10'h150, i_rv_plic.reg2hw.prio78.q))

  // read/write assertions for register: prio79
  `ASSERT(prio79_wr_A, wr_P(1, 10'h154, i_rv_plic.reg2hw.prio79.q, 0))
  `ASSERT(prio79_rd_A, rd_P(1, 10'h154, i_rv_plic.reg2hw.prio79.q))

  // define local fpv variable for the multi_reg
  logic [79:0] ie0_q_fpv;
  for (genvar s = 0; s <= 79; s++) begin : gen_ie0_rd
    assign ie0_q_fpv[s] = i_rv_plic.reg2hw.ie0[s].q;
  end

  // read/write assertions for register: ie00
  `ASSERT(ie00_wr_A, wr_P(31, 10'h200, ie0_q_fpv[31:0], 0))
  `ASSERT(ie00_rd_A, rd_P(31, 10'h200, ie0_q_fpv[31:0]))

  // read/write assertions for register: ie01
  `ASSERT(ie01_wr_A, wr_P(31, 10'h204, ie0_q_fpv[63:32], 0))
  `ASSERT(ie01_rd_A, rd_P(31, 10'h204, ie0_q_fpv[63:32]))

  // read/write assertions for register: ie02
  `ASSERT(ie02_wr_A, wr_P(15, 10'h208, ie0_q_fpv[79:64], 0))
  `ASSERT(ie02_rd_A, rd_P(15, 10'h208, ie0_q_fpv[79:64]))

  // read/write assertions for register: threshold0
  `ASSERT(threshold0_wr_A, wr_P(1, 10'h20c, i_rv_plic.reg2hw.threshold0.q, 0))
  `ASSERT(threshold0_rd_A, rd_P(1, 10'h20c, i_rv_plic.reg2hw.threshold0.q))

  // read/write assertions for register: cc0
  `ASSERT(cc0_wr_A, wr_ext_P(6, 10'h210, i_rv_plic.reg2hw.cc0.q, 0))
  `ASSERT(cc0_rd_A, rd_ext_P(6, 10'h210, i_rv_plic.hw2reg.cc0.d))

  // read/write assertions for register: msip0
  `ASSERT(msip0_wr_A, wr_P(0, 10'h214, i_rv_plic.reg2hw.msip0.q, 0))
  `ASSERT(msip0_rd_A, rd_P(0, 10'h214, i_rv_plic.reg2hw.msip0.q))

endmodule