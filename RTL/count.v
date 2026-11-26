# RTL code for Counter
...
module count(input clock,input [3:0]din,input load,mode,rst,output reg[3:0]count);
  always @(posedge clock)
    begin
      if(rst)
        count<= 4'b0000;
      else if(load)
        count<=din;
      else if(mode==0)
        begin
          if(count>11)
            count<=4'b0;
          else
            count<=count+1'b1;
        end
      else
        begin
          if((count>10)||(count<2))
            count<=4'd10;
          else
            count<=count-1'b1;
        end
    end
endmodule
...
