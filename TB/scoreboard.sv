# code for scoreboard class
...
    class count_sb;
         count_trans rm_data;
         count_trans sb_data;
         event done;
         static int ref_data,r_data,data_verified;
         mailbox #(count_trans)ref2sb;
         mailbox #(count_trans)rdm2sb;
         covergroup cg;
           c1:coverpoint rm_data.din
           {
             bins b1[]={[2:8]};
             bins b2=default;}
           c2:coverpoint rm_data.load;
           c3:coverpoint rm_data.mode;
         endgroup
         function new(mailbox #(count_trans)ref2sb,mailbox #(count_trans)rdm2sb);
           this.ref2sb=ref2sb;
           this.rdm2sb=rdm2sb;
           cg=new();
         endfunction
         virtual task start();
           fork
             forever
               begin
                 ref2sb.get(rm_data);
                 cg.sample();
                 ref_data++;
                 rdm2sb.get(sb_data);
                 check(rm_data,sb_data);
                 report();
               end
           join_none
         endtask
         virtual task check(count_trans rmdata,count_trans rdata);
            begin
             if(rm_data.count===rdata.count)
               $display("count matches");
             else
               $display("count not matching");
           end
           data_verified++;
           if(data_verified>=150)
             begin
               ->done;
             end
           $display("coverage %d",cg.get_coverage());
         endtask
         virtual function void report();
           $display("-----------scoreboard report-------");
           $display("data generated=%0d",ref_data);
           $display("data verified=%0d",data_verified);
           $display("ref count=%0d",rm_data.count);
           $display("dut count=%0d",sb_data.count);
           $display("------------------------------------");
         endfunction
endclass
...
