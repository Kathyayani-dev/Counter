# code for write driver
...
   class count_driver;
         virtual count_if.drv dr_if;
         count_trans data2duv;
         mailbox #(count_trans)gen2dr;
         function new(virtual count_if.drv dr_if, mailbox #(count_trans)gen2dr);
           begin
             this.dr_if=dr_if;
             this.gen2dr=gen2dr;
           end
         endfunction
         virtual task drive();
           begin
             @(dr_if.dr_cb);
             dr_if.dr_cb.load<=data2duv.load;
             dr_if.dr_cb.din<=data2duv.din;
             dr_if.dr_cb.mode<=data2duv.mode;
             dr_if.dr_cb.rst<=data2duv.rst;
             repeat(2)
                @(dr_if.dr_cb);
           end
         endtask
         virtual task start();
           fork
             forever
               begin
                 gen2dr.get(data2duv);
                 //$display("driver %p",data2duv);
                 drive();
               end
           join_none
         endtask
   endclass
...
