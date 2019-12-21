`timescale 1ns / 1ps
//encout- manchester encoded data
//decout- manchester decoded data
module enc_dec_man(inp,clk,encout,decout);
//manchester encoder
//clock period- 10ns
//input period is assigned to be 1 Mb/s
//so 100 clock cycle correspond to 1 input cycle
input inp,clk;
output wire encout;
reg trig11=0;
reg trig21=0;
assign encout=trig11^trig21;
integer i1=0;
integer j1=49;
always @(negedge clk)
begin
i1=i1+1;
if(i1==100) begin
i1=0;
if(inp==1)
begin
if(trig11==0)
begin
trig21<=0;
end
else
begin
trig21<=1;
end
end
else
begin
if(trig11==0)
begin
trig21<=1;
end
else
begin
trig21<=0;
end
end
end
end
always @(posedge clk)
begin
j1=j1+1;
if(j1==100)
begin
j1=0;
trig11=~trig11;
end
end
// Manchester Decoder
output wire decout;
assign iinp=encout;
integer i=0;
reg trig1=0;
reg trig2=0;
assign decout=trig1^trig2;
wire ninp=~iinp;
reg trig3=1;
reg trig5=0,trig6=0,trig7=0;
wire trig4=trig5^trig6^trig7;
always @(posedge iinp)
begin
if(trig3==1)
begin
if(trig1==0)
begin
trig2<=1;
end
else
begin
trig2<=0;
end
trig7=~trig7;
end
end
always@(posedge ninp)
begin
if(trig3==1)
begin
if(trig2==0)
begin
trig1<=0;
end
else
begin
trig1<=1;
end
trig6=~trig6;
end
end
always @ (posedge clk)
begin
if(i==70)
begin
trig3<=1;
end
if(i==0 || i==1)
begin
trig3<=0;
end
if(trig4==1)
begin 
i=0;
trig5=~trig5;
end
i=i+1;
end
endmodule
