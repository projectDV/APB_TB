`include apb_txn;
class apb_gen;
	mailbox #(apb_txn) gen2drv;
	event gen2drv_done;
	
	apb_txn txn, txn2drv;
	
	function new(mailbox #(apb_txn) gen2drv);
	
		txn=new();
		this.gen2drv=gen2drv;
	endfunction
	
	task run();
		txn.randomize();
	endtask
	
	//initializing to default value
	task start();
		fork
			begin
			txn.paddr={32'0};
			txn.pwdata={32'0};
			txn.penable=0;
			txn.pwrite=0;
			txn2drv=new.txn
			gen2drv.put(txn2drv);
			run();
			->gen2drv_done;
			end
		join_none
	endtask
endclass : apb_gen
			
	
