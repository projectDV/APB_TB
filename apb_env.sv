`include "apb_gen"
`include "apb_drv"
`include "apb_mon"
//`include "apb_txn" | not required
`include "apb_sb"
//`include "apb_if" | not required
`include "apb_rm"
class apb_env;

	apb_drv drv;
	apb_gen gen;
	apb_mon mon;
	apb_sb sb;
	apb_rm rm;
	apb_txn txn;
	
	virtual apb_if.master_mp mmp;
	virtual apb_if.slave_mp smp;
	
	mailbox #(txn) gen2drv=new();
	mailbox #(txn) mon2sb=new();
	mailbox #(txn) mon2rm=new();
	mailbox #(txn) opFrmDut=new();
	mailbox #(txn) opFrmRm=new();
	mailbox #(txn) rm2sb=new();
	
	function new(	virtual apb_if.master_mp mmp;
					virtual apb_if.slave_mp smp;)
		
		this.mmp=mmp;
		this.smp=smp;
	endfunction
	
	task build();
		
		drv=new(gen2drv);
		gen=new(gen2drv);
		mon=new(mon2rm, mon2sb);
		sb=new(opFrmDut,opFrmRm);
		rm=new(rm2sb);
	endtask
	
	task start();
		gen.start();
		drv.start();
		mon.start();
		sb.start();
		rm.start();
	endtask
	
	task stop();
	
		wait(sb.DONE.triggered);
		$display("TEST COMPLETE");
		sb.print_report();
	endtask
	
	task run();
		start();
		stop();
	endtask
endclass
