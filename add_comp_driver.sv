
class add_comp_driver extends uvm_driver #(add_comp_sequence_item);
  //----------------------------------------------------------------------------
  `uvm_component_utils(add_comp_driver)
  //----------------------------------------------------------------------------

  uvm_analysis_port #(add_comp_sequence_item) drv2sb;

  //----------------------------------------------------------------------------
  function new(string name="add_comp_driver",uvm_component parent);
    super.new(name,parent);
  endfunction
  //---------------------------------------------------------------------------- 

  //--------------------------  virtual interface handel -----------------------  
  virtual interface intf vif;
  //----------------------------------------------------------------------------
  
  //-------------------------  get interface handel from top -------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!(uvm_config_db#(virtual intf)::get(this,"","vif",vif))) begin
      `uvm_fatal("driver","unable to get interface");
    end
    drv2sb=new("drv2sb",this);
  endfunction
  //----------------------------------------------------------------------------
  
  //---------------------------- run task --------------------------------------
  task run_phase(uvm_phase phase);
    add_comp_sequence_item txn=add_comp_sequence_item::type_id::create("txn");
    initilize(); // initilize dut at time 0
    forever begin
      seq_item_port.get_next_item(txn);
      drive_item(txn);
      drv2sb.write(txn);
      seq_item_port.item_done();    
    end
  endtask
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  task initilize();
    vif.n1         = 0;
    vif.n2         = 0;
    vif.enabel_sum = 0;
  endtask
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  task drive_item(add_comp_sequence_item txn);
    vif.n1         = txn.n1;
    vif.n2         = txn.n2;
    vif.enabel_sum = txn.enabel_sum;
  endtask
  //----------------------------------------------------------------------------
endclass:add_comp_driver

