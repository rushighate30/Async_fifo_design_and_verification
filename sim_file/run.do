# Compiling and Generating the Simulation Waveforms Files: It's step-by-step 

# compile RTL Design files
vlog ../rtl_file/main.v
vlog ../rtl_file/fifo_write.v
vlog ../rtl_file/fifo_read.sv
vlog ../rtl_file/read_2FF.sv
vlog ../rtl_file/write_2FF.sv
vlog ../rtl_file/FIFO.v

#compile SystemVerilog Verification Files

# Compile package first
vlog -sv ../sv_file/all_file.sv      
vlog -sv ../sv_file/transaction.sv 

# Compile interface
vlog -sv ../sv_file/interface.sv

# Compile all environment classes
vlog -sv ../sv_file/generator.sv
vlog -sv ../sv_file/driver.sv
vlog -sv ../sv_file/monitor.sv
vlog -sv ../sv_file/scoreboard.sv

# Compile environment container
vlog -sv ../sv_file/enviroment.sv

# Compile test module
vlog -sv ../sv_file/test.sv

# Compile testbench last
vlog -sv ../sv_file/testbench.sv

# Run simulation
vsim -novopt work.testbench

# Open waveform
view wave
add wave -r /*

# Run all
run -all


