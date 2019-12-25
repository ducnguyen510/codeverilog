`timescale 1ns / 10ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2019 04:19:54 PM
// Design Name: 
// Module Name: mul_fp_tb
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


module mul_fp_tb(

    );
    reg [31:0] a,b;
    reg reset,clk;
    reg en;
    wire done_tick,NaN,inf;
    wire [31:0] o;
    
    mul_fp uut(.a(a),
               .b(b),
               .reset(reset),
               .clk(clk),
               .en(en),
               .done_tick(done_tick),
               .NaN(NaN),
               .inf(inf),
               .o(o));
    always begin
            clk=1'b0;
            #10
            clk=1'b1;
            #10;
           end     
           
   initial
          begin
          reset=1'b1;
          #10;
          reset=1'b0;
          #10;
          en=1'b1;
          a=32'b00111111110000000000000000000000;//1.5
          b=32'b00111111110000000000000000000000;//-1.5
          #100;
          a=32'b00111111111111111111111111111111;//1.999999999
          b=32'b10111111110000000000000000000000;//-1.5
          #100;
          a=32'b00000000000000000000000001111111;
          b=32'b00000000000001000000000000000000;
          #200;
          $stop;
          end
endmodule
