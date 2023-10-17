class sb;
	mailbox #(apb_txn)opFrmDut;
	mailbox #(apb_txn)opFrmRm;
	
	event DONE;
	
	apb_txn txnFrmDUT, txnFrmRm;
	
	const int no_of_testcase;
	
	function new(mailbox #(apb_txn)opFrmDut, mailbox #(apb_txn)opFrmRm);
		this.opFrmDut=opFrmDut;
		this.opFrmRm=opFrmRm
		this.no_of_testcase=no_of_testcase;
		txnFrmDUT=new();
		txnFrmRm=new();
	endfunction
	
	function void compare();
		if(txnFrmDUT.compare(txnFrmRm))begin
			$display("Packet ID: %0d \tPASSED",txnFrmDUT.txn_id);
		end
		else begin
			$display("Packet ID: %0d \tFAILED",txnFrmDUT.txn_id);
		end
	endfunction
	task start();
		fork
			forever begin
				opFrmDut.get(txnFrmDUT);
				opFrmRm.get(txnFrmRm);
				compare();
				int i++;
				if(i>=no_of_testcase)
					->DONE;
			end
		join_none
	endtask
endclass: sb
