`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2019 09:43:50 AM
// Design Name: 
// Module Name: ad_fp_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ad_fp_tb(

    );
    reg [31:0] a,b;
    reg clk,reset;
    reg en,op;
    wire done_tick,NaN,inf;
    wire [31:0] o;
    
    add_fp uut(.a(a),
               .b(b),
               .clk(clk),
               .reset(reset),
               .en(en),
               .op(op),
               .done_tick(done_tick),
               .NaN(NaN),
               .inf(inf),
               .o(o));
               
     always begin
            clk=1'b0;
            #10;
            clk=1'b1;
            #10;
     end
     
     initial begin
     reset=1'b1;
     #10;
     reset=1'b0;
     #10;
     en=1'b1;
     op=1'b0;
       a=32'b00111111110000000000000000000000;//1.5
       b=32'b00111111110000000000000000000000;//1.5
       #100;
       a=32'b00111111110000000000000000000000;//1.5
       b=32'b10111111111000000000000000000000;//-1.75
       #100;
       a=32'b01111111100000000000000000000000; //a=inf
       b=32'b00111111110000000000000000000000; //1.5
       #100;
       a=32'b01111111110000000000000000000000;//a=NaN
       b=32'b00111111110000000000000000000000; //b=1.5;     
       #100;
     $stop;
     end
endmodule
