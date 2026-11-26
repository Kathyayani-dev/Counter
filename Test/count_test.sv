# code for Testcases of counter
...
   class test;
         virtual count_if.drv rd_if;
         virtual count_if.wr_mon wrmon_if;
         virtual count_if.rd_mon rdmon_if;
         count_env env_h;
         function new(virtual count_if.drv rd_if,
         virtual count_if.wr_mon wrmon_if,
                      virtual count_if.rd_mon rdmon_if);
           this.rd_if=rd_if;
           this.wrmon_if=wrmon_if;
           this.rdmon_if=rdmon_if;
           env_h = new(rd_if,wrmon_if,rdmon_if);
         endfunction
         virtual task build();
           env_h.build();
         endtask
         virtual task run();
           env_h.run();
         endtask
   endclass
...
