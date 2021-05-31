

class add_comp_sequencer extends uvm_sequencer#(add_comp_sequence_item);
  //----------------------------------------------------------------------------
  `uvm_component_utils(add_comp_sequencer)  
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function new(string name="add_comp_sequencer",uvm_component parent);  
    super.new(name,parent);
  endfunction
  //----------------------------------------------------------------------------
  
endclass:add_comp_sequencer

