// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

class flash_ctrl_env_cfg extends cip_base_env_cfg #(.RAL_T(flash_ctrl_reg_block));

  // vifs
  mem_bkdr_vif      mem_bkdr_vifs[NUM_FLASH_BANKS];

  // additional RAL
  rand flash_ctrl_eflash_reg_block eflash_ral;

  // ext component cfgs
  rand tl_agent_cfg m_eflash_tl_agent_cfg;

  // knobs
  // ral.status[init_wip] status is set for the very first clock cycle right out of reset.
  // This causes problems in the read value especially in CSR tests.
  int post_reset_delay_clks = 1;

  `uvm_object_utils_begin(flash_ctrl_env_cfg)
    `uvm_field_object(m_eflash_tl_agent_cfg, UVM_DEFAULT)
  `uvm_object_utils_end

  `uvm_object_new

  virtual function void initialize_csr_addr_map_size();
    this.csr_addr_map_size = FLASH_CTRL_ADDR_MAP_SIZE;
  endfunction : initialize_csr_addr_map_size

  virtual function void initialize(bit [31:0] csr_base_addr = '1);
    super.initialize(csr_base_addr);
    // create tl agent config obj
    m_eflash_tl_agent_cfg = tl_agent_cfg::type_id::create("m_eflash_tl_agent_cfg");
    m_eflash_tl_agent_cfg.if_mode = dv_utils_pkg::Host;

    // set num_interrupts & num_alerts
    begin
      uvm_reg rg = ral.get_reg_by_name("intr_state");
      if (rg != null) begin
        num_interrupts = ral.intr_state.get_n_used_bits();
      end
    end

    // Create the eflash RAL model.
    eflash_ral = flash_ctrl_eflash_reg_block::type_id::create("eflash_ral");
    // TODO: randomize upper bits of the memory
    eflash_ral.build(0, null);
    ral_models.push_back(eflash_ral);
  endfunction

endclass
