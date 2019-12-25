`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2019 04:43:55 PM
// Design Name: 
// Module Name: add_fp
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


module add_fp(
 input wire [31:0] a,b,
 input wire clk,reset,
 input wire en,op,
 output reg done_tick,
 output reg NaN,inf,
 output wire [31:0] o
 );
 reg a_sign,b_sign;
 reg [7:0] a_exponent,b_exponent;
 reg [26:0] a_mantissa,b_mantissa;
//    reg o_sign;
//    reg [7:0] o_mantissa;
//    reg [27:0] o_exponent;
 reg [7:0] diff;
 reg [26:0] tmp_mantissa;
 
 localparam [2:0] idle=3'h0,
                  exception=3'h1,
                  add=3'h2,
                  normalized=3'h3,
                  rounding=3'h4,
                  done=3'h5;
 reg [2:0] state_reg,state_next;
 reg [26:0] am_reg,am_next,bm_reg,bm_next;
 reg [27:0] om_reg,om_next;
 reg [7:0] oe_reg,oe_next;
 reg os_reg,os_next;

 //unpackage
 always @*
   begin
   if(op==0) // phep cong a+b
   begin
    a_sign=a[31];
    if(a[30:23]==0)
      begin
       a_exponent=8'b00000001;
       a_mantissa={1'b0,a[22:0],3'b000};
      end
     else
      begin
       a_exponent=a[30:23];
       a_mantissa={1'b1,a[22:0],3'b000};
      end
     b_sign=b[31];
      if(b[30:23]==0)
        begin
         b_exponent=8'b00000001;
         b_mantissa={1'b0,b[22:0],3'b000};
        end
       else
        begin
         b_exponent=b[30:23];
         b_mantissa={1'b1,b[22:0],3'b000};
        end 
       end
   else    //phep tru a-b
       begin
              a_sign=a[31];
       if(a[30:23]==0)
         begin
          a_exponent=8'b00000001;
          a_mantissa={1'b0,a[22:0],3'b000};
         end
        else
         begin
          a_exponent=a[30:23];
          a_mantissa={1'b1,a[22:0],3'b000};
         end
        b_sign=~b[31];
         if(b[30:23]==0)
           begin
            b_exponent=8'b00000001;
            b_mantissa={1'b0,b[22:0],3'b000};
           end
          else
           begin
            b_exponent=b[30:23];
            b_mantissa={1'b1,b[22:0],3'b000};
           end 
       end     
   end
  //state_reg
  always @(posedge clk,posedge reset)
     begin
      if(reset)
        begin
         state_reg=idle;
         am_reg<=0;
         bm_reg<=0;
         om_reg<=0;
         oe_reg<=0;
         os_reg<=0;
        end
       else
        begin
         state_reg<=state_next;
         am_reg<=am_next;
         bm_reg<=bm_next;
         om_reg<=om_next;
         oe_reg<=oe_next;
         os_reg<=os_next;
        end
     end               
   //state_next
  always @*
    begin
     //default
     state_next=state_reg;
     am_next=am_reg;
     bm_next=bm_reg;
     om_next=om_reg;
     oe_next=oe_reg;
     os_next=os_reg;
     done_tick=1'b0;
     NaN=1'b0;
     inf=1'b0;
     //
     case(state_reg)
       idle:
           begin
           if(en)
            begin
             am_next=a_mantissa;
             bm_next=b_mantissa;
             om_next=0;
             oe_next=0;
             os_next=0;
             state_next=exception;
            end
           end
        exception:
             begin
              //if a=NaN or b=0 return a
              if((a_exponent==255 && am_reg !==0)||(b_exponent==0 && bm_reg==0))
               begin
                oe_next=a_exponent;
                om_next=am_reg;
                os_next =a_sign;
                NaN=1'b1;
                state_next=done;       
               end
               //if b=NaN or a=0 return b
              else if((b_exponent==255 && bm_reg !==0)||(a_exponent==0 && am_reg==0))
               begin
                oe_next=b_exponent;
                om_next =bm_reg;
                os_next =b_sign;
                NaN=1'b1;
                state_next=done;
               end
               //if a or b = infinity
              else if((a_exponent==255)||(b_exponent==255))
               begin
                os_next =a_sign^b_sign;
                oe_next=255;
                om_next=0;
                inf=1'b1;
                state_next=done;
               end
              else
               state_next=add;
             end
         add:
          begin
          //eA=eB
           if(a_exponent==b_exponent)
            begin
              oe_next=a_exponent;
           //a,b cung dau
             if(a_sign==b_sign)
              begin
               om_next=am_reg+bm_reg;
            //carry
               om_next[27]=1;
               os_next=a_sign;
              end
             else                               //a,b khac dau
              begin
               if(am_reg>bm_reg)                 //|a|>|b|
                 begin
                  om_next=am_reg-bm_reg;
                  os_next=a_sign;
                 end
                else if (am_reg<bm_reg)          //|a|<|b|
                  begin
                   om_next=bm_reg-am_reg;
                   os_next=b_sign;
                  end
                else
                  begin
                   om_next=0;
                   oe_next=0;
                   os_next=1'b0;
                  end
              end
            end  
          else if(a_exponent>b_exponent)          //eA>eB    
             begin
              os_next =a_sign;
              oe_next=a_exponent;
              diff =a_exponent-b_exponent;
              tmp_mantissa=bm_reg>>diff;
              if(a_sign==b_sign)                //a,b cung dau
               om_next=am_reg+tmp_mantissa;
              else                              //khac dau
               om_next=am_reg-tmp_mantissa;
             end  
            else                                   //eA<eB
             begin
              os_next=b_sign;
              oe_next=b_exponent;
              diff=b_exponent-a_exponent;
              tmp_mantissa=am_reg>>diff;
              if(a_sign==b_sign)
               om_next=bm_reg+tmp_mantissa;
             else
              om_next=bm_reg-tmp_mantissa;
             end
           state_next=normalized;
         end
       normalized:
         begin
         if(om_reg[27]==1)
            begin
             oe_next=oe_reg+1;
             om_next=om_reg>>1;
            end
         else if((om_reg[26]!=1)&(oe_reg!=0))
          begin
         if (om_reg[26:1] == 26'h1) begin
             oe_next = oe_reg - 25;
             om_next = om_reg << 25;
         end  else if (om_reg[26:2] == 25'h1) begin
             oe_next = oe_reg - 24;
             om_next = om_reg << 24;
         end  else if (om_reg[26:3] == 24'h1) begin
             oe_next = oe_reg - 23;
             om_next = om_reg << 23;
         end  else if (om_reg[26:4] == 23'h1) begin
             oe_next = oe_reg - 22;
             om_next = om_reg << 22;
         end  else if (om_reg[26:5] == 22'h1) begin
             oe_next = oe_reg - 21;
             om_next = om_reg << 21;                                                                         
          end  else if (om_reg[26:6] == 21'h1) begin
              oe_next = oe_reg - 20;
              om_next = om_reg << 20;
          end else if (om_reg[26:7] == 20'h1) begin
              oe_next = oe_reg - 19;
              om_next = om_reg << 19;
          end else if (om_reg[26:8] == 19'h1) begin
              oe_next = oe_reg - 18;
              om_next = om_reg << 18;
          end else if (om_reg[26:9] == 18'h1) begin
              oe_next = oe_reg - 17;
              om_next= om_reg << 17;
          end else if (om_reg[26:10] == 17'h1) begin
              oe_next = oe_reg - 16;
              om_next= om_reg << 16;
          end else if (om_reg[26:11] == 16'h1) begin
              oe_next = oe_reg - 15;
              om_next = om_reg << 15;
          end else if (om_reg[26:12] == 15'h1) begin
              oe_next = oe_reg - 14;
              om_next = om_reg << 14;
          end else if (om_reg[26:13] == 14'h1) begin
              oe_next = oe_reg - 13;
              om_next = om_reg<< 13;
          end else if (om_reg[26:14] == 13'h1) begin
              oe_next =  oe_reg - 12;
              om_next = om_reg << 12;
          end else if (om_reg[26:15] == 12'h1) begin
              oe_next = oe_reg - 11;
              om_next = om_reg<< 11;
          end else if (om_reg[26:16] == 11'h1) begin
              oe_next = oe_reg - 10;
              om_next = om_reg << 10;
          end else if (om_reg[26:17] == 10'h1) begin
              oe_next = oe_reg - 9;
              om_next = om_reg << 9;
          end else if (om_reg[26:18] == 9'h1) begin
              oe_next = oe_reg - 8;
              om_next = om_reg << 8;
          end else if (om_reg[26:19] == 8'h1) begin
              oe_next = oe_reg - 7;
              om_next= om_reg << 7;
          end else if (om_reg[26:10] == 7'h1) begin
              oe_next = oe_reg - 6;
              om_next= om_reg << 6;
          end else if (om_reg[26:11] == 6'h1) begin
              oe_next = oe_reg - 5;
              om_next = om_reg << 5;
          end else if (om_reg[26:12] == 5'h1) begin
              oe_next = oe_reg - 4;
              om_next = om_reg << 4;
          end else if (om_reg[26:23] == 4'h1) begin
              oe_next = oe_reg- 3;
              om_next = om_reg << 3;
          end else if (om_reg[26:24] == 3'h1) begin
              oe_next = oe_reg - 2;
              om_next = om_reg << 2;
          end else if (om_reg[26:25] == 2'h1) begin
              oe_next = oe_reg - 1;
              om_next = om_reg << 1;
          end
          end
          state_next=rounding;
         end
      rounding:
         begin
         //round bit R :om_reg[2],sticky bit S =om_reg[1]|om_reg[0]
         /* RS=00-->no round 
            RS=01-->truncate result by discarding RS
            RS=11-->increment result (+1)
            RS=10 -->check last bit(om_reg[3])
                  -->om_reg[3]=0-->truncate
                  -->om_reg[3]=1--increment (+10
         */
         if(om_reg[2]==0) //RS=00,RS=01
          begin
           om_next=om_reg;
           oe_next=oe_reg;
          end
         else //
           begin
               if(om_reg[1:0]==0)//RS=10
                 begin
                  if(om_reg[3]==0) //last bit =0
                    begin
                      om_next=om_reg;
                      oe_next=oe_reg;
                    end
                  else              //lastbit=1
                     begin
                      om_next=om_reg+28'b0000000000000000000000001000;
                      oe_next=oe_reg;
                      state_next=normalized;
                     end
                 end
               else //RS=11;
                 begin
                 om_next=om_reg+28'b0000000000000000000000001000;
                 oe_next=oe_reg;
                 state_next=normalized;                    
                 end
            end
                  
         state_next=done;
         end
      done:
         begin
          done_tick=1;             
          state_next=idle;
         end
       default: state_next=idle;
      endcase
    end
//output 
assign o[31]=os_reg;
assign o[30:23]=oe_reg;
assign o[22:0] =om_reg[25:3];
endmodule

