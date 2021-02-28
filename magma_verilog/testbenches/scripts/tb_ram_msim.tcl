vlib work
vlog tb_ram.v ../ram_16x8.v
vsim work.tb_ram
add wave sim:/tb_ram/*
run -all
wave zoom full