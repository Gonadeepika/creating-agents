/************************************************************************
  
Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
  
www.maven-silicon.com 
  
All Rights Reserved. 
This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd. 
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.
  
Filename		:   ram_wr_seqs.sv

Description 	:	Write sequence class for Dual Port RAM TB
  
Author Name		:   Putta Satish

Support e-mail	: 	For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version			:	1.0

************************************************************************/


//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

 
// Extend ram_wbase_seq from uvm_sequence parameterized by write_xtn 
class ram_wbase_seq extends uvm_sequence #(write_xtn);  
	
  // Factory registration using `uvm_object_utils

	`uvm_object_utils(ram_wbase_seq)  
	//------------------------------------------
	// METHODS
	//------------------------------------------

	// Standard UVM Methods:
    extern function new(string name ="ram_wbase_seq");
	
endclass

//-----------------  constructor new method  -------------------//
function ram_wbase_seq::new(string name ="ram_wbase_seq");
	super.new(name);
endfunction

//------------------------------------------------------------------------------
//
// SEQUENCE: Random Write Transactions - Use with write_rand_xtn  
//
//------------------------------------------------------------------------------


//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------


//Extend ram_rand_wr_xtns from ram_wbase_seq;
class ram_rand_wr_xtns extends ram_wbase_seq;

  	// Factory registration using `uvm_object_utils
	`uvm_object_utils(ram_rand_wr_xtns)

	//------------------------------------------
	// METHODS
	//------------------------------i------------

	// Standard UVM Methods:
    extern function new(string name ="ram_rand_wr_xtns");
    extern task body();
	
endclass
//-----------------  constructor new method  -------------------//
function ram_rand_wr_xtns::new(string name = "ram_rand_wr_xtns");
	super.new(name);
endfunction

	  
//-----------------  task body method  -------------------//
//Generate 10 transactions of type write_xtn 
//create req instance
//start_item(req)
//assert for randomization
//finish_item(req)

task ram_rand_wr_xtns::body();
    repeat(10)
	begin
		req=write_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize());
		finish_item(req); 	
	end
endtask

