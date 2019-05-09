## Generated SDC file "BabysFirstProcessor.out.sdc"

## Copyright (C) 1991-2013 Altera Corporation
## Your use of Altera Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Altera Program License 
## Subscription Agreement, Altera MegaCore Function License 
## Agreement, or other applicable license agreement, including, 
## without limitation, that your use is for the sole purpose of 
## programming logic devices manufactured by Altera and sold by 
## Altera or its authorized distributors.  Please refer to the 
## applicable agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus II"
## VERSION "Version 13.1.0 Build 162 10/23/2013 SJ Web Edition"

## DATE    "Sat May 04 12:43:45 2019"

##
## DEVICE  "EP3C16F484C6"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {Fib:inst|Clock_divider:b2v_inst6|clock_out} -period 1.000 -waveform { 0.000 0.500 } [get_registers {Fib:inst|Clock_divider:b2v_inst6|clock_out}]
create_clock -name {CLOCK_50} -period 1.000 -waveform { 0.000 0.500 } [get_ports {CLOCK_50}]


#**************************************************************
# Create Generated Clock
#**************************************************************



#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {Fib:inst|Clock_divider:b2v_inst6|clock_out}] -rise_to [get_clocks {Fib:inst|Clock_divider:b2v_inst6|clock_out}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {Fib:inst|Clock_divider:b2v_inst6|clock_out}] -fall_to [get_clocks {Fib:inst|Clock_divider:b2v_inst6|clock_out}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {Fib:inst|Clock_divider:b2v_inst6|clock_out}] -rise_to [get_clocks {CLOCK_50}]  0.030  
set_clock_uncertainty -rise_from [get_clocks {Fib:inst|Clock_divider:b2v_inst6|clock_out}] -fall_to [get_clocks {CLOCK_50}]  0.030  
set_clock_uncertainty -fall_from [get_clocks {Fib:inst|Clock_divider:b2v_inst6|clock_out}] -rise_to [get_clocks {Fib:inst|Clock_divider:b2v_inst6|clock_out}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {Fib:inst|Clock_divider:b2v_inst6|clock_out}] -fall_to [get_clocks {Fib:inst|Clock_divider:b2v_inst6|clock_out}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {Fib:inst|Clock_divider:b2v_inst6|clock_out}] -rise_to [get_clocks {CLOCK_50}]  0.030  
set_clock_uncertainty -fall_from [get_clocks {Fib:inst|Clock_divider:b2v_inst6|clock_out}] -fall_to [get_clocks {CLOCK_50}]  0.030  
set_clock_uncertainty -rise_from [get_clocks {CLOCK_50}] -rise_to [get_clocks {Fib:inst|Clock_divider:b2v_inst6|clock_out}]  0.030  
set_clock_uncertainty -rise_from [get_clocks {CLOCK_50}] -fall_to [get_clocks {Fib:inst|Clock_divider:b2v_inst6|clock_out}]  0.030  
set_clock_uncertainty -rise_from [get_clocks {CLOCK_50}] -rise_to [get_clocks {CLOCK_50}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {CLOCK_50}] -fall_to [get_clocks {CLOCK_50}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {CLOCK_50}] -rise_to [get_clocks {Fib:inst|Clock_divider:b2v_inst6|clock_out}]  0.030  
set_clock_uncertainty -fall_from [get_clocks {CLOCK_50}] -fall_to [get_clocks {Fib:inst|Clock_divider:b2v_inst6|clock_out}]  0.030  
set_clock_uncertainty -fall_from [get_clocks {CLOCK_50}] -rise_to [get_clocks {CLOCK_50}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {CLOCK_50}] -fall_to [get_clocks {CLOCK_50}]  0.020  


#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

