
/***************************************************
  analysis_port from driver
  analysis_port from monitor
***************************************************/

`uvm_analysis_imp_decl( _drv )
`uvm_analysis_imp_decl( _mon )

class add_comp_scoreboard extends uvm_scoreboard;
  //----------------------------------------------------------------------------
  `uvm_component_utils(add_comp_scoreboard)
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  uvm_analysis_imp_drv #(add_comp_sequence_item, add_comp_scoreboard) aport_drv;
  uvm_analysis_imp_mon #(add_comp_sequence_item, add_comp_scoreboard) aport_mon;
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  uvm_tlm_fifo #(add_comp_sequence_item) expfifo;
  uvm_tlm_fifo #(add_comp_sequence_item) outfifo;
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  int VECT_CNT, PASS_CNT, ERROR_CNT;
  logic [7:0]   t_n1;
  logic [7:0]   t_n2;
  logic t_enabel_sum;
  logic [8:0]  t_sum,temp_sum;
  logic       t_more,temp_more;
  logic       t_less,temp_less;
  logic      t_match,temp_match;

  function new(string name="add_comp_scoreboard",uvm_component parent);
    super.new(name,parent);
  endfunction
  //----------------------------------------------------------------------------


  //----------------------------------------------------------------------------  
  function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	aport_drv = new("aport_drv", this);
	aport_mon = new("aport_mon", this);
	expfifo= new("expfifo",this);
	outfifo= new("outfifo",this);
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function void write_drv(add_comp_sequence_item tr);
    `uvm_info("write_drv STIM", tr.input2string(), UVM_MEDIUM)
    //write scoreboard code here
    t_n1 = tr.n1;
    t_n2 = tr.n2;
    t_enabel_sum = tr.enabel_sum;
    temp_sum=t_sum;
    temp_more=t_more;
    temp_less=t_less;
    temp_match=t_match;
    if(t_enabel_sum==1) begin
      t_sum=t_n1+t_n2;
      if(t_sum==50) begin
        t_match=1;
        t_less=0;
        t_more=0;
      end
      else if(t_sum<50) begin
        t_match=0;
        t_less=1;
        t_more=0;
      end
      else begin
        t_match=0;
        t_less=0;
        t_more=1;
      end
    end
    else begin 
      t_sum=0;
      t_less=0;
      t_more=0;
      t_match=0;
    end
    tr.sum   = temp_sum;
    tr.more  = temp_more;
    tr.less  = temp_less;
    tr.match = temp_match;
    void'(expfifo.try_put(tr));
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function void write_mon(add_comp_sequence_item tr);
    `uvm_info("write_mon OUT ", tr.convert2string(), UVM_MEDIUM)
    void'(outfifo.try_put(tr));
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  task run_phase(uvm_phase phase);
    static int unsigned count=0;
	add_comp_sequence_item exp_tr, out_tr;
	forever begin
	    `uvm_info("scoreboard run task","WAITING for expected output", UVM_DEBUG)
	    expfifo.get(exp_tr);
	    `uvm_info("scoreboard run task","WAITING for actual output", UVM_DEBUG)
	    outfifo.get(out_tr);
        
      if (out_tr.sum===exp_tr.sum && out_tr.more===exp_tr.more && out_tr.less===exp_tr.less && out_tr.match===exp_tr.match && count>2) begin
            PASS();
           `uvm_info ("PASS ",out_tr.convert2string() , UVM_MEDIUM)
      	end
      
      else if(out_tr.sum!==exp_tr.sum && out_tr.more!==exp_tr.more && out_tr.less!==exp_tr.less && out_tr.match!==exp_tr.match && count>2)
        begin
	        ERROR();
          `uvm_info ("ERROR [ACTUAL_OP]",out_tr.convert2string() , UVM_MEDIUM)
          `uvm_info ("ERROR [EXPECTED_OP]",exp_tr.convert2string() , UVM_MEDIUM)
          `uvm_warning("ERROR",exp_tr.convert2string())
	      end
      count++;
    end
  endtask
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        if (VECT_CNT && !ERROR_CNT)
            `uvm_info("PASSED",$sformatf("*** TEST PASSED - %0d vectors ran, %0d vectors passed ***",
            VECT_CNT, PASS_CNT), UVM_LOW)

        else
            `uvm_info("FAILED",$sformatf("*** TEST FAILED - %0d vectors ran, %0d vectors passed, %0d vectors failed ***",
            VECT_CNT, PASS_CNT, ERROR_CNT), UVM_LOW)
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function void PASS();
	VECT_CNT++;
	PASS_CNT++;
  endfunction

  function void ERROR();
  	VECT_CNT++;
  	ERROR_CNT++;
  endfunction
  //----------------------------------------------------------------------------

endclass

