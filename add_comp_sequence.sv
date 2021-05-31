
/***************************************************
** class name  : add_comp_sequence
** description : generate input between 0 to 24 for
                 both n1 and n2, enabel_sum==1
***************************************************/
class add_comp_sequence extends uvm_sequence#(add_comp_sequence_item);
  //----------------------------------------------------------------------------
  `uvm_object_utils(add_comp_sequence)            
  //----------------------------------------------------------------------------

  add_comp_sequence_item txn;
  int unsigned REPEAT=25;

  //----------------------------------------------------------------------------
  function new(string name="add_comp_sequence");  
    super.new(name);
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  virtual task body();
    repeat(REPEAT) begin
      txn=add_comp_sequence_item::type_id::create("txn");
      start_item(txn);
      txn.randomize()with{txn.n1<25; txn.n2<25; txn.enabel_sum==1;};
      #5;
      finish_item(txn);
    end
  endtask:body
  //----------------------------------------------------------------------------
endclass:add_comp_sequence

/***************************************************
** class name  : add_comp_match
** description : n1==25 and n2==25 , enabel_sum==1
***************************************************/
class add_comp_match extends add_comp_sequence;
  //----------------------------------------------------------------------------   
  `uvm_object_utils(add_comp_match)      
  //----------------------------------------------------------------------------
  
  add_comp_sequence_item txn;
  int unsigned REPEAT=25;
  
  //----------------------------------------------------------------------------
  function new(string name="add_comp_match");
      super.new(name);
  endfunction
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  task body();
    repeat(REPEAT) begin
      txn=add_comp_sequence_item::type_id::create("txn");
      start_item(txn);
      txn.randomize()with{txn.n1+txn.n2==50; txn.enabel_sum==1;};
      #5;
      finish_item(txn);
    end
  endtask:body
  //----------------------------------------------------------------------------
  
endclass

/***************************************************
** class name  : add_comp_more
** description : n1>25 and n2>25 , eneble_sum==1;
***************************************************/
class add_comp_more extends add_comp_sequence;
  //----------------------------------------------------------------------------   
  `uvm_object_utils(add_comp_more)      
  //----------------------------------------------------------------------------
  
  add_comp_sequence_item txn;
  int unsigned REPEAT=25;
  //----------------------------------------------------------------------------
  function new(string name="add_comp_more");
      super.new(name);
  endfunction
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  task body();
    repeat(REPEAT) begin
    txn=add_comp_sequence_item::type_id::create("txn");
      start_item(txn);
      txn.randomize()with{txn.n1>25; txn.n2>25; txn.enabel_sum==1;};
      #5;
      finish_item(txn);
    end
  endtask:body
  //----------------------------------------------------------------------------
endclass

/***************************************************
** class name  : add_comp_enabel_0
** description : enebel_sum==0;
***************************************************/
class add_comp_enabel_0 extends add_comp_sequence;
  //----------------------------------------------------------------------------   
  `uvm_object_utils(add_comp_enabel_0)      
  //----------------------------------------------------------------------------
  
  add_comp_sequence_item txn;
  int unsigned REPEAT=25;
  
  //----------------------------------------------------------------------------
  function new(string name="add_comp_enabel_0");
      super.new(name);
  endfunction
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  task body();
    repeat(REPEAT) begin
      txn=add_comp_sequence_item::type_id::create("txn");
      start_item(txn);
      txn.randomize()with{txn.enabel_sum==0;};
      #5;
      finish_item(txn);
    end
  endtask:body
  //----------------------------------------------------------------------------
  
endclass

