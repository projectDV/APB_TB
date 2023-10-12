class apb_txn;
	//rand bit[3:0] psel;
	rand bit penable,pwrite;
	rand bit [31:0]paddr,pwdata,prdata;
	
	function void post_randomize();
		$display("%h,%h",paddr,pwdata);
	endfunction
	
endclass
