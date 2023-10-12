class apb_txn;
	rand bit[3:0] psel;
	rand bit pwrite,presetn;
	rand bit [31:0]paddr,pwdata;
	bit pready,penable;
	bit [31:0] prdata;
	
	function void post_randomize();
		$display("%h,%h",paddr,pwdata);
	endfunction
	
endclass
