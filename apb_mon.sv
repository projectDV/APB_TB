`include apb_txn;
class apb_mon_sb;
	virtual apb_if.monitor_ip_mp if;
	mailbox #(apb_txn) mon2sb,mon2rm;
	
	apb_txn txn,txn2sb,txn2rm;
	
	function new(mailbox#(apb_txn) mon2rm,mon2sb, virtual apb_if.monitor_ip_mp if);
		this.if=if;
		this.mon2rm=mon2rm;
		this.mon2sb=mon2sb;
		txn=new();
	endfunction
	
	task monitor();
		@(if.monitor_ip_cb)
			if(if.monitor_ip_cb.penable==1 && if.monitor_ip_cb.pready==1)begin
			txn.prdata[i]=if.monitor_ip_cb.prdata;
			txn.penable=if.monitor_ip_cb.penable;
			txn.pready=if.monitor_ip_cb.pready;
			txn.psel=if.monitor_ip_cb.psel;
			txn.ready=if.monitor_ip_cb.pready;
			txn.pwdata=if.monitor_ip_cb.pwdata;
			txn.pwrite=if.monitor_ip_cb.pwrite;
			txn.presetn=if.monitor_ip_cb.presetn;
			i++;
			end
	endtask: monitor
	
	task start();
		fork
			i=0;
			forever begin
				monitor();
				txn2sb=new txn;
				txn2rm=new txn;
				mon2sb.put(txn2sb);
				mon2rm.put(txn2rm)
				txn=new();
			end
		join_none
	endtask
endclass
