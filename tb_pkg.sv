
`ifndef TB_PKG
`define TB_PKG
`include "uvm_macros.svh"
package tb_pkg;
 import uvm_pkg::*;
 `include "add_comp_sequence_item.sv"        // transaction class
 `include "add_comp_sequence.sv"             // sequence class
 `include "add_comp_sequencer.sv"            // sequencer class
 `include "add_comp_driver.sv"               // driver class
 `include "add_comp_monitor.sv"
 `include "add_comp_agent.sv"                // agent class  
 `include "add_comp_coverage.sv"             // coverage class
 `include "add_comp_scoreboard.sv"           // scoreboard class
 `include "add_comp_env.sv"                  // environment class

 `include "add_comp_test.sv"                         // test1
 //`include "test2.sv"
 //`include "test3.sv"

endpackage
`endif 


