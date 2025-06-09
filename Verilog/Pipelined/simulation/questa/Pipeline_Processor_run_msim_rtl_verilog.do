transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/dmart/SonC/Verilog/Pipelined/pipelined_processor {C:/Users/dmart/SonC/Verilog/Pipelined/pipelined_processor/riscvpipeline.v}
vlog -vlog01compat -work work +incdir+C:/Users/dmart/SonC/Verilog/Pipelined/pipelined_processor {C:/Users/dmart/SonC/Verilog/Pipelined/pipelined_processor/regfile.v}
vlog -vlog01compat -work work +incdir+C:/Users/dmart/SonC/Verilog/Pipelined/pipelined_processor {C:/Users/dmart/SonC/Verilog/Pipelined/pipelined_processor/pipelined_datapath.v}
vlog -vlog01compat -work work +incdir+C:/Users/dmart/SonC/Verilog/Pipelined/pipelined_processor {C:/Users/dmart/SonC/Verilog/Pipelined/pipelined_processor/flopenr.v}
vlog -vlog01compat -work work +incdir+C:/Users/dmart/SonC/Verilog/Pipelined/pipelined_processor {C:/Users/dmart/SonC/Verilog/Pipelined/pipelined_processor/extend.v}
vlog -vlog01compat -work work +incdir+C:/Users/dmart/SonC/Verilog/Pipelined/pipelined_processor {C:/Users/dmart/SonC/Verilog/Pipelined/pipelined_processor/alu.v}
vlog -vlog01compat -work work +incdir+C:/Users/dmart/SonC/Verilog/Pipelined/control_unit {C:/Users/dmart/SonC/Verilog/Pipelined/control_unit/maindec.v}
vlog -vlog01compat -work work +incdir+C:/Users/dmart/SonC/Verilog/Pipelined/control_unit {C:/Users/dmart/SonC/Verilog/Pipelined/control_unit/controller.v}
vlog -vlog01compat -work work +incdir+C:/Users/dmart/SonC/Verilog/Pipelined/control_unit {C:/Users/dmart/SonC/Verilog/Pipelined/control_unit/aludec.v}
vlog -vlog01compat -work work +incdir+C:/Users/dmart/SonC/Verilog/Pipelined/pipeline_registers {C:/Users/dmart/SonC/Verilog/Pipelined/pipeline_registers/mem_wb.v}
vlog -vlog01compat -work work +incdir+C:/Users/dmart/SonC/Verilog/Pipelined/pipeline_registers {C:/Users/dmart/SonC/Verilog/Pipelined/pipeline_registers/id_ex.v}
vlog -vlog01compat -work work +incdir+C:/Users/dmart/SonC/Verilog/Pipelined/pipeline_registers {C:/Users/dmart/SonC/Verilog/Pipelined/pipeline_registers/ex_mem.v}

vlog -sv -work work +incdir+C:/Users/dmart/SonC/Verilog/Pipelined/testbenches {C:/Users/dmart/SonC/Verilog/Pipelined/testbenches/riscvpipeline_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  riscvpipeline_tb

add wave *
view structure
view signals
run -all
