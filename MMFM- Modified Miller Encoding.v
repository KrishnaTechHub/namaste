//Verilog implemntation on FPGA
//clock 10 ns
//input 1Mb/s
`timescale 1ns / 1ps
module modmill(inp,clk,out);
input inp;
 input clk;
output wire out;
reg prev=0;
reg trig1=0;
reg trig2=0;
assign out=trig1^trig2;
integer i=99;
integer j=49;
always @(negedge clk)
begin
i=i+1;
if(i==100)
begin
i=0;
if(inp==1)
begin
if(out==1)
begin
trig1=~trig1;
end
end
else
begin
if(prev==1)
begin
if(out==1)
begin
trig1=~trig1;
end
end
else 
begin
if(out==0)
begin
trig1=~trig1;
end
end
end
end
end

always @(posedge clk)
begin
j=j+1;
if(j==100)
begin
j=0;
if(inp==1)
begin
trig2=~trig2;
prev<=1;
end
else
begin
if(prev==0)
begin
trig2=~trig2;
end
else
begin
prev<=0;
end
end
end
end
endmodule
