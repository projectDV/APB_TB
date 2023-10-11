interface apb_if;

	logic pclk;
	logic preset_n;
	logic [3:0] psel;
	logic pwrite; //HIGH-write operation; LOW-read operation
	logic penable;
	logic [31:0]pwdata,prdata,paddr;
	logic pready;
	
	clocking master_cb@(posedge pclk);
		output psel,pwrite,penable,pwdata,paddr;
		input pready,prdata;
	endclocking
	
	clocking slave_cb@(posedge pclk);
		input psel,pwrite,penable,pwdata,paddr,pready;
		output prdata;
	endclocking
	
	modport master_mp(clocking master_cb);
	modport slave_mp(clocking slave_cb);
endinterface
