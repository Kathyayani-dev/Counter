# code for counter interface class
...
  interface count_if(input bit clock);
  //interface signals
  logic [3:0]din;
  logic [3:0]count;
  logic mode;
  logic rst;
  logic load;
  //driver clocking block
  clocking dr_cb @(posedge clock);
    default input #1 output #1;
    output din;
    output load;
    output mode;
    output rst;
  endclocking
  //write monitor clocking block
  clocking wr_cb@(posedge clock);
    default input #1 output #1;
    input din;
    input load;
    input mode;
    input rst;
  endclocking
  // read monitor clocking block
  clocking rd_cb@(posedge clock);
    default input #1 output #1;
    input count;
  endclocking
  // driver modport
        modport drv (clocking dr_cb);
  // write monitor modport
         modport wr_mon(clocking wr_cb);
  // read monitor modport
         modport rd_mon(clocking rd_cb);
endinterface
...
