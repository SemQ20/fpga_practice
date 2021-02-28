vlib work
vlog tb_main.v ../main.v
vsim work.tb_main
add wave sim:/tb_main/*
run -all
wave zoom full