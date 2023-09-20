`include apb_tnx;
class apb_drv;

	mailbox #(apb_tnx) gen2drv;
	
	virtual apb_if if;
	
	apb_tnx txn;
	
	funtion new (mailbox #(apb_tnx) gen2drv, virtual apb_if.master_mp if);
		this.if=if;
		this.gen2drv=gen2drv;
		txn=new();
	endfunction
	
	//For 2 states of APB separate tasks would be needed.
	task idle();
		if.master_cb.penable	<=0;
		if.master_cb.psel		<=0;
	endtask
	
	task setup();
		if.master_cb.preset_n	<=txn.preset_n;
		if.master_cb.penable	<=0;
		if.master_cb.psel		<=1;
		if.master_cb.pwrite		<=1; //for WRITE operation
		if.master_cb.paddr		<=txn.paddr;
		if.master_cb.pwdata		<=txn.pwdata;
	endtask
	
	task access();
		if.master_cb.penable	<=1;
		if.master_cb.psel		<=1;
	endtask
	
	task drive();
		if(!txn.preset_n)begin
			@(if.master_cb)
				txn.preset_n	<=1;
			@(if.master_cb)
				setup();
			@(if.master_cb)
				access();
			wait(if.master_cb.pready==1);
			@(if.master_cb)
				setup();			
		end
		idle();
		
	task start();
		fork
			forever begin
				idle();
				gen2drv.get(txn);
				drive();
			end
		join_none
	endtask
endclass
		
