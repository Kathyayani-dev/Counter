# code for Top Module
...
   module top;
         reg clk;
         count_if duv_if(clk);
         test t_h;
         count DUV(.clock(clk),.din(duv_if.din),.load(duv_if.load),.mode(duv_if.mode),.rst(duv_if.rst),.count(duv_if.count));
         initial
           begin
             clk=1'b0;
             forever
               #10 clk=~clk;
           end
         initial
           begin
             t_h = new(duv_if,duv_if,duv_if);
             //no_of_transactions=200;
             t_h.build();
             t_h.run();
             $finish;
           end
        // end
  endmodule
  ...
