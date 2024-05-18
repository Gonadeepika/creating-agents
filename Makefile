#Makefile for UVM Testbench - Lab 04

# SIMULATOR = Questa for Mentor's Questasim
# SIMULATOR = VCS for Synopsys's VCS

SIMULATOR = VCS


INC = +incdir+../wr_agt_top +incdir+../test +incdir+../packages +incdir+../tb 
work= work #library name
SVTB1 =  ../tb/top.sv
SVTB2 = ../test/ram_test_pkg.sv
COVOP = -coveropt 3 +cover=bcft 
VSIMOPT= -vopt -voptargs=+acc  
VSIMBATCH= -c -do  " log -r /* ;run -all; exit"

help:
	@echo =================================================================================
	@echo "! USAGE   	--  make target                             				!"
	@echo "! clean   	=>  clean the earlier log and intermediate files.       	!"
	@echo "! sv_cmp    	=>  Create library and compile the code.                   	!"
	@echo "! run_test	=>  clean, compile & run the simulation in batch mode.		!" 
	@echo =================================================================================

clean : clean_$(SIMULATOR)
sv_cmp : sv_cmp_$(SIMULATOR)
run_test : run_test_$(SIMULATOR)

# ----------------------------- Start of Definitions for Mentor's Questa Specific Targets -------------------------------#

sv_cmp_Questa:
	vlib $(work)
	vmap work $(work)
	vlog -work $(work) $(INC) $(SVTB2) $(SVTB1) 	
	
run_test_Questa: sv_cmp
	vsim  $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH)  -l test1.log  -sv_seed random  work.top 
		
clean_Questa:
	rm -rf transcript* *log*  vsim.wlf fcover* covhtml* mem_cov* *.wlf modelsim.ini work
	clear

# ----------------------------- End of Definitions for Mentor's Questa Specific Targets -------------------------------#

# ----------------------------- Start of Definitions for Synopsys's VCS Specific Targets -------------------------------#

sv_cmp_VCS:
	vcs -l vcs.log -timescale=1ns/1ps -sverilog -ntb_opts uvm -debug_access+all -full64 $(RTL) $(INC) $(SVTB2) $(SVTB1)
	      
run_test_VCS:	clean  sv_cmp_VCS
	./simv -a vcs.log +ntb_random_seed_automatic	
	
clean_VCS:
	rm -rf simv* csrc* *.tmp *.vpd *.vdb *.key *.log *hdrs.h
	clear

# ----------------------------- END of Definitions for Synopsys's VCS Specific Targets -------------------------------#
