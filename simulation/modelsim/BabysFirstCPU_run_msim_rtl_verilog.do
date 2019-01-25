transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/CPU {C:/CPU/regfile32x64.v}

vlog -vlog01compat -work work +incdir+C:/CPU/Testbenches {C:/CPU/Testbenches/regfile32x64_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneiii_ver -L rtl_work -L work -voptargs="+acc"  regfile32x64_tb

add wave *
view structure
view signals
run -all
