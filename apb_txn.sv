class apb_txn;
	rand bit[3:0] psel;
	rand bit pwrite,presetn;
	rand bit [31:0]paddr,pwdata;
	bit pready,penable;
	bit [31:0] prdata;

	static int txn_id;
	
	function void post_randomize();
		$display("%h,%h",paddr,pwdata);
		txn_id++;
	endfunction

	function bit compare(apb_txn txn);
		if(this.pready==trans.pready)begin
			foreach(this.prdata[i])begin
				if(this.prdata[i]!=txn.prdata[i])
					return 0;
				else
					return 1;
			end
			else
				return 0;
		end
	endfunction:compare
endclass
