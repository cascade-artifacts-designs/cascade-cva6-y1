// Copyright Flavien Solt, ETH Zurich.
// Licensed under the General Public License, Version 3.0, see LICENSE for details.
// SPDX-License-Identifier: GPL-3.0-only

// Toplevel module.

module ariane_tiny_soc #(
    parameter int unsigned NumWords = 1 << 20,
    parameter int unsigned AddrWidth = 64,
    parameter int unsigned DataWidth = 64,

    parameter int unsigned StrbWidth = DataWidth >> 3,
    localparam type addr_t = logic [AddrWidth-1:0],
    localparam type data_t = logic [DataWidth-1:0],
    localparam type strb_t = logic [StrbWidth-1:0]
) (
  input logic clk_i,
  input logic rst_ni,

  ///////////
  // RFUZZ //
  ///////////

  input logic meta_rst_ni,
  input logic [197:0] fuzz_in,
  output logic [3836:0] auto_cover_out
);

  ariane_mem_top i_ariane_mem_top (
    .clk_i,
    .rst_ni,
    .mem_req_o(),
    .mem_addr_o(),
    .mem_wdata_o(),
    .mem_strb_o(),
    .mem_we_o(),

    // RFUZZ output
    .fuzz_in(fuzz_in),
    .metaReset(~meta_rst_ni),
    .auto_cover_out(auto_cover_out)
  );

endmodule
