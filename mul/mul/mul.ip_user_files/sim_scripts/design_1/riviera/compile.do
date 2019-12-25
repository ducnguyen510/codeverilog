vlib work
vlib riviera

vlib riviera/microblaze_v10_0_7
vlib riviera/xil_defaultlib
vlib riviera/axi_lite_ipif_v3_0_4
vlib riviera/mdm_v3_2_14
vlib riviera/lib_cdc_v1_0_2
vlib riviera/proc_sys_reset_v5_0_12
vlib riviera/lib_pkg_v1_0_2
vlib riviera/lib_srl_fifo_v1_0_2
vlib riviera/axi_uartlite_v2_0_21
vlib riviera/generic_baseblocks_v2_1_0
vlib riviera/axi_infrastructure_v1_1_0
vlib riviera/axi_register_slice_v2_1_17
vlib riviera/fifo_generator_v13_2_2
vlib riviera/axi_data_fifo_v2_1_16
vlib riviera/axi_crossbar_v2_1_18
vlib riviera/lmb_v10_v3_0_9
vlib riviera/lmb_bram_if_cntlr_v4_0_15
vlib riviera/blk_mem_gen_v8_4_1

vmap microblaze_v10_0_7 riviera/microblaze_v10_0_7
vmap xil_defaultlib riviera/xil_defaultlib
vmap axi_lite_ipif_v3_0_4 riviera/axi_lite_ipif_v3_0_4
vmap mdm_v3_2_14 riviera/mdm_v3_2_14
vmap lib_cdc_v1_0_2 riviera/lib_cdc_v1_0_2
vmap proc_sys_reset_v5_0_12 riviera/proc_sys_reset_v5_0_12
vmap lib_pkg_v1_0_2 riviera/lib_pkg_v1_0_2
vmap lib_srl_fifo_v1_0_2 riviera/lib_srl_fifo_v1_0_2
vmap axi_uartlite_v2_0_21 riviera/axi_uartlite_v2_0_21
vmap generic_baseblocks_v2_1_0 riviera/generic_baseblocks_v2_1_0
vmap axi_infrastructure_v1_1_0 riviera/axi_infrastructure_v1_1_0
vmap axi_register_slice_v2_1_17 riviera/axi_register_slice_v2_1_17
vmap fifo_generator_v13_2_2 riviera/fifo_generator_v13_2_2
vmap axi_data_fifo_v2_1_16 riviera/axi_data_fifo_v2_1_16
vmap axi_crossbar_v2_1_18 riviera/axi_crossbar_v2_1_18
vmap lmb_v10_v3_0_9 riviera/lmb_v10_v3_0_9
vmap lmb_bram_if_cntlr_v4_0_15 riviera/lmb_bram_if_cntlr_v4_0_15
vmap blk_mem_gen_v8_4_1 riviera/blk_mem_gen_v8_4_1

vcom -work microblaze_v10_0_7 -93 \
"../../../../mul.srcs/sources_1/bd/design_1/ipshared/b649/hdl/microblaze_v10_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/design_1/ip/design_1_microblaze_0_0/sim/design_1_microblaze_0_0.vhd" \

vcom -work axi_lite_ipif_v3_0_4 -93 \
"../../../../mul.srcs/sources_1/bd/design_1/ipshared/cced/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \

vcom -work mdm_v3_2_14 -93 \
"../../../../mul.srcs/sources_1/bd/design_1/ipshared/5125/hdl/mdm_v3_2_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/design_1/ip/design_1_mdm_1_0/sim/design_1_mdm_1_0.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/b65a" "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/b65a" "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"../../../bd/design_1/ip/design_1_clk_wiz_1_0/design_1_clk_wiz_1_0_clk_wiz.v" \
"../../../bd/design_1/ip/design_1_clk_wiz_1_0/design_1_clk_wiz_1_0.v" \

vcom -work lib_cdc_v1_0_2 -93 \
"../../../../mul.srcs/sources_1/bd/design_1/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work proc_sys_reset_v5_0_12 -93 \
"../../../../mul.srcs/sources_1/bd/design_1/ipshared/f86a/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/design_1/ip/design_1_rst_clk_wiz_1_100M_0/sim/design_1_rst_clk_wiz_1_100M_0.vhd" \

vcom -work lib_pkg_v1_0_2 -93 \
"../../../../mul.srcs/sources_1/bd/design_1/ipshared/0513/hdl/lib_pkg_v1_0_rfs.vhd" \

vcom -work lib_srl_fifo_v1_0_2 -93 \
"../../../../mul.srcs/sources_1/bd/design_1/ipshared/51ce/hdl/lib_srl_fifo_v1_0_rfs.vhd" \

vcom -work axi_uartlite_v2_0_21 -93 \
"../../../../mul.srcs/sources_1/bd/design_1/ipshared/a15e/hdl/axi_uartlite_v2_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/design_1/ip/design_1_axi_uartlite_0_0/sim/design_1_axi_uartlite_0_0.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/b65a" "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/b65a" "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"../../../bd/design_1/ipshared/718f/hdl/mymulfp_v1_0_S00_AXI.v" \
"../../../bd/design_1/ipshared/718f/hdl/mymulfp_v1_0.v" \
"../../../bd/design_1/ipshared/718f/mul_fp.v" \
"../../../bd/design_1/ip/design_1_mymulfp_0_0/sim/design_1_mymulfp_0_0.v" \

vlog -work generic_baseblocks_v2_1_0  -v2k5 "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/b65a" "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/b65a" "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"../../../../mul.srcs/sources_1/bd/design_1/ipshared/b752/hdl/generic_baseblocks_v2_1_vl_rfs.v" \

vlog -work axi_infrastructure_v1_1_0  -v2k5 "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/b65a" "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/b65a" "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"../../../../mul.srcs/sources_1/bd/design_1/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_register_slice_v2_1_17  -v2k5 "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/b65a" "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/b65a" "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"../../../../mul.srcs/sources_1/bd/design_1/ipshared/6020/hdl/axi_register_slice_v2_1_vl_rfs.v" \

vlog -work fifo_generator_v13_2_2  -v2k5 "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/b65a" "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/b65a" "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"../../../../mul.srcs/sources_1/bd/design_1/ipshared/7aff/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_2_2 -93 \
"../../../../mul.srcs/sources_1/bd/design_1/ipshared/7aff/hdl/fifo_generator_v13_2_rfs.vhd" \

vlog -work fifo_generator_v13_2_2  -v2k5 "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/b65a" "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/b65a" "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"../../../../mul.srcs/sources_1/bd/design_1/ipshared/7aff/hdl/fifo_generator_v13_2_rfs.v" \

vlog -work axi_data_fifo_v2_1_16  -v2k5 "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/b65a" "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/b65a" "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"../../../../mul.srcs/sources_1/bd/design_1/ipshared/247d/hdl/axi_data_fifo_v2_1_vl_rfs.v" \

vlog -work axi_crossbar_v2_1_18  -v2k5 "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/b65a" "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/b65a" "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"../../../../mul.srcs/sources_1/bd/design_1/ipshared/15a3/hdl/axi_crossbar_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/b65a" "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/b65a" "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"../../../bd/design_1/ip/design_1_xbar_0/sim/design_1_xbar_0.v" \

vcom -work lmb_v10_v3_0_9 -93 \
"../../../../mul.srcs/sources_1/bd/design_1/ipshared/78eb/hdl/lmb_v10_v3_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/design_1/ip/design_1_dlmb_v10_0/sim/design_1_dlmb_v10_0.vhd" \
"../../../bd/design_1/ip/design_1_ilmb_v10_0/sim/design_1_ilmb_v10_0.vhd" \

vcom -work lmb_bram_if_cntlr_v4_0_15 -93 \
"../../../../mul.srcs/sources_1/bd/design_1/ipshared/92fd/hdl/lmb_bram_if_cntlr_v4_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/design_1/ip/design_1_dlmb_bram_if_cntlr_0/sim/design_1_dlmb_bram_if_cntlr_0.vhd" \
"../../../bd/design_1/ip/design_1_ilmb_bram_if_cntlr_0/sim/design_1_ilmb_bram_if_cntlr_0.vhd" \

vlog -work blk_mem_gen_v8_4_1  -v2k5 "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/b65a" "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/b65a" "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"../../../../mul.srcs/sources_1/bd/design_1/ipshared/67d8/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/b65a" "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/b65a" "+incdir+../../../../mul.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"../../../bd/design_1/ip/design_1_lmb_bram_0/sim/design_1_lmb_bram_0.v" \
"../../../bd/design_1/sim/design_1.v" \

vlog -work xil_defaultlib \
"glbl.v"

