logic [7:0]   n1;
    logic [7:0]   n2;
    logic enabel_sum;
    logic [8:0]  sum;
    logic       more;
    logic       less;
    logic      match;

class add_comp_sequence_item extends uvm_sequence_item;

  //------------ i/p || o/p field declaration-----------------

  rand logic [7:0]   n1;  //i/p
  rand logic [7:0]   n2;
  rand logic enabel_sum;

  logic [8:0] sum;        //o/p
  logic      more;
  logic      less;
  logic      match;
  
  //---------------- register add_comp_sequence_item class with factory --------
  `uvm_object_utils_begin(add_comp_sequence_item) 
     `uvm_field_int( n1         ,UVM_ALL_ON)
     `uvm_field_int( n2         ,UVM_ALL_ON)
     `uvm_field_int( enabel_sum ,UVM_ALL_ON)
     `uvm_field_int( sum        ,UVM_ALL_ON)
     `uvm_field_int( more       ,UVM_ALL_ON)
     `uvm_field_int( less       ,UVM_ALL_ON)
     `uvm_field_int( match      ,UVM_ALL_ON)
  `uvm_object_utils_end
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function new(string name="add_comp_sequence_item");
    super.new(name);
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // write DUT inputs here for printing
  function string input2string();
    return($sformatf("n1=%3d  n2=%3d enabel_sum=%0b", n1,n2,enabel_sum));
  endfunction
  
  // write DUT outputs here for printing
  function string output2string();
    return($sformatf("sum=%3d less=%0b match=%0b more=%0b",sum,less,match,more));
  endfunction
    
  function string convert2string();
    return($sformatf({input2string(), " || ", output2string()}));
  endfunction
  //----------------------------------------------------------------------------

endclass:add_comp_sequence_item
