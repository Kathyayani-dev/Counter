# code for counter reference model
...
  class count_model;
         count_trans w_data;
         static logic[3:0]ref_count;
         mailbox #(count_trans)wrmon2rm;
         mailbox #(count_trans)rm2sb;
         function new(mailbox #(count_trans)wrmon2rm,mailbox #(count_trans)rm2sb);
           this.wrmon2rm=wrmon2rm;
           this.rm2sb=rm2sb;
         endfunction
         virtual task count_mod(count_trans model_counter);
           //begin
             if(model_counter.rst)
                ref_count<=1'b0;
             else if(model_counter.load)
               ref_count<=model_counter.din;
             //wait(model_counter.load==0)
             //begin
               else if(model_counter.mode==0)
                 begin
                   if(ref_count>11)
                     ref_count<=4'd0;
                   else
                     ref_count<=ref_count+1'b1;
                 end
               else if(model_counter.mode==1)
                 begin
                   if((ref_count>10)||(ref_count<2))
                     ref_count<=4'd10;
                   else
                     ref_count<=ref_count-1'b1;
                 end
             //end
           //end
           //#20;
          model_counter.count<=ref_count;
           //$display("ref count %d",ref_count);
         endtask
         virtual task start();
           fork
             begin
               forever
                 begin
                   wrmon2rm.get(w_data);
                   count_mod(w_data);
                   w_data.count=ref_count;
                   rm2sb.put(w_data);
                 end
             end
           join_none
         endtask
endclass
...
