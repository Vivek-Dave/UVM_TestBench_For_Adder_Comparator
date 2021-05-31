
class add_comp_monitor extends uvm_monitor;
  //----------------------------------------------------------------------------
  `uvm_component_utils(add_comp_monitor)
  //----------------------------------------------------------------------------

  //------------------- constructor --------------------------------------------
  function new(string name="add_comp_monitor",uvm_component parent);
    super.new(name,parent);
  endfunction
  //----------------------------------------------------------------------------
  
  //---------------- sequence_item class ---------------------------------------
  add_comp_sequence_item  txn;
  //----------------------------------------------------------------------------
  
  //------------------------ virtual interface handle---------------------------  
  virtual interface intf vif;
  //----------------------------------------------------------------------------

  //------------------------ analysis port -------------------------------------
  uvm_analysis_port#(add_comp_sequence_item) ap_mon;
  //----------------------------------------------------------------------------
  
  //------------------- build phase --------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!(uvm_config_db#(virtual intf)::get(this,"","vif",vif)))
    begin
      `uvm_fatal("monitor","unable to get interface")
    end
    
    ap_mon=new("ap_mon",this);
  endfunction
  //----------------------------------------------------------------------------

  //-------------------- run phase ---------------------------------------------
  task run_phase(uvm_phase phase);
    txn=add_comp_sequence_item::type_id::create("txn",this);
    forever
    begin
      sample_dut(txn);
      ap_mon.write(txn);
    end
  endtask
  //----------------------------------------------------------------------------

  task sample_dut(output add_comp_sequence_item txn);
    add_comp_sequence_item t=add_comp_sequence_item::type_id::create("t");
    @(vif.n1 or vif.n2 or vif.enabel_sum);
    t.n1         = vif.n1;
    t.n2         = vif.n2;
    t.sum        = vif.sum;
    t.more       = vif.more;
    t.less       = vif.less;
    t.match      = vif.match;
    t.enabel_sum = vif.enabel_sum;
    txn = t;
  endtask

endclass:add_comp_monitor

