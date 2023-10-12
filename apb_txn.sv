class apb_txn;
	rand bit[3:0] psel;
	rand bit pwrite;
	rand bit [31:0]paddr,pwdata,prdata;
	bit pready,penable;
	
	function void post_randomize();
		$display("%h,%h",paddr,pwdata);
	endfunction
	
endclass
