class apb_test;

	apb_env env;
	
	write_txn wr_txn;
	read_txn read_txn;
	
	virtual apb_if.master_mp mmp;
	virtual apb_if.slave_mp smp;
	
	function new(	virtual apb_if.master_mp mmp;
					virtual apb_if.slave_mp smp;)
					
				this.mmp=mmp;
				this.smp=smp;
				env=new(mmp,smp);
				wr_txn=new();
				read_txn=new();
	endfunction
	
	task run();
		begin;
		env.build();
		env.run();
		$finish();
		end
	endtask
endclass
	
