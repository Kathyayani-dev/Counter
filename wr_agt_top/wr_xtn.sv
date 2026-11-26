# code for write Transaction class
...
  class count_trans;
         //interface signals
         rand logic[3:0]din;
         rand logic load;
         rand logic mode;
         logic rst;
         logic [3:0]count;
         //constraints
         constraint c1{din inside{[2:8]};}
         constraint c2{load dist{1:=30,0:=70};}
         constraint c3{mode dist{1:=50,0:=50};}
         //display methods
         virtual function void display(input string s);
           begin
             $display("-------------%s---------------",s);
             $display("mode=%0d",mode);
             $display("load=%0d",load);
             $display("din=%0d",din);
             $display("count=%0d",count);
             $display("rst=%0d",rst);
             $display("--------------------------------");
           end
         endfunction
  endclass
...
