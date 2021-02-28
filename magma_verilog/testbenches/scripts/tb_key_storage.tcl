vlib work
vlog tb_key.v ../key.v
vsim work.tb_key
add wave sim:/tb_key/*
run -all
wave zoom full