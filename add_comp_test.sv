
class add_comp_test extends uvm_test;

    //--------------------------------------------------------------------------
    `uvm_component_utils(add_comp_test)
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    function new(string name="add_comp_test",uvm_component parent);
	      super.new(name,parent);
    endfunction
    //--------------------------------------------------------------------------

    add_comp_env env_h;
    int file_h;

    //--------------------------------------------------------------------------
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      env_h = add_comp_env::type_id::create("env_h",this);
    endfunction
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    function void end_of_elobartion_phase(uvm_phase phase);
      //factory.print();
      $display("End of eleboration phase in agent");
    endfunction
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    function void start_of_simulation_phase(uvm_phase phase);
      $display("start_of_simulation_phase");
      file_h=$fopen("LOG_FILE.log","w");
      set_report_default_file_hier(file_h);
      set_report_severity_action_hier(UVM_INFO,UVM_DISPLAY+UVM_LOG);
      set_report_verbosity_level_hier(UVM_MEDIUM);
    endfunction
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    task run_phase(uvm_phase phase);
        add_comp_sequence seq;
        add_comp_more seq_more;
        add_comp_match seq_match;
        add_comp_enabel_0 seq_enabel;
        
	      phase.raise_objection(this);
            seq= add_comp_sequence::type_id::create("seq");
            seq_more= add_comp_more::type_id::create("seq_more");
            seq_match= add_comp_match::type_id::create("seq_match");
            seq_enabel= add_comp_enabel_0::type_id::create("seq_enabel");

            seq.start(env_h.agent_h.sequencer_h);
            seq_more.start(env_h.agent_h.sequencer_h);
            seq_match.start(env_h.agent_h.sequencer_h);
            seq_enabel.start(env_h.agent_h.sequencer_h);
            #10;
	      phase.drop_objection(this);
    endtask
    //--------------------------------------------------------------------------

endclass:add_comp_test

