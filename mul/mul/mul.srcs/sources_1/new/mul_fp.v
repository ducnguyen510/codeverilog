`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2019 02:02:52 PM
// Design Name: 
// Module Name: mul_fp
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


module mul_fp(
    input wire [31:0] a,b,
    input wire reset,clk,
    input wire en,
    output reg done_tick,NaN,inf,
    output wire [31:0] o
    );
    reg a_sign,b_sign;
    reg [26:0] a_mantissa,b_mantissa;
    reg [9:0] a_exponent,b_exponent;
    //
    localparam [2:0] idle=3'h0,
                     exception=3'h1,
                     mul=3'h2,
                     normalized1=3'h3,
                     normalized2=3'h4,
                     rounding=3'h5,
                     done=3'h6;
    reg [2:0] state_reg,state_next;
    reg os_reg,os_next;
    reg signed [9:0] oe_reg,oe_next;
//    reg [27:0] om_reg,om_next;
    reg [53:0] product_reg,product_next;
    //
    //unpackage
    always @*
         begin
         a_sign=a[31];
         if(a[30:23]==0)
           begin
             a_exponent=10'b0000000001;
             a_mantissa={1'b0,a[22:0],3'b000};
           end
          else
             begin
              a_exponent={2'b00,a[30:23]};
              a_mantissa={1'b1,a[22:0],3'b000};
             end
         b_sign=b[31];
             if(b[30:23]==0)
               begin
                 b_exponent=10'b0000000001;
                 b_mantissa={1'b0,b[22:0],3'b000};
               end
              else
                 begin
                  b_exponent={2'b00,b[30:23]};
                  b_mantissa={1'b1,b[22:0],3'b000};
                 end          
         end
      //state_reg
      always @(posedge clk,posedge reset)
          begin
           if(reset)
             begin
              state_reg<=idle;
              os_reg<=0;
//              om_reg<=0;
              oe_reg<=0; 
              product_reg<=0;            
             end
            else
             begin
              state_reg<=state_next;
              os_reg<=os_next;
//              om_reg<=om_next;
              oe_reg<=oe_next;
              product_reg<=product_next;
             end
          end   
       //state_next
       always @*
            begin
             //default state
              state_next=state_reg;
              os_next=os_reg;
//              om_next=om_reg;
              oe_next=oe_reg;
              product_next=product_reg;
              done_tick=1'b0;
              inf=0;
              NaN=0;
              //
            case(state_reg)
              idle:
                  begin
                     if(en)
                     begin
                     os_next=0;
//                     om_next=0;
                     oe_next=0;
                     product_next=0;
                     state_next=exception;
                     end
                  end
                exception:
                   begin
                    //if a=NaN return  o=NaN
                       if(a_exponent==255 && a_mantissa !=0)
                        begin
                         os_next=a_sign;
                         oe_next =a_exponent;
                         product_next={2'h0,a_mantissa,29'h0};
                         NaN=1'b1;
                         state_next=done;
                        end
                       //if b=NaN return o=NaN
                       else if(b_exponent==255 && b_mantissa!=0)
                         begin
                          os_next =b_sign;
                          oe_next=b_exponent;
                          product_next={2'h0,b_mantissa,29'h0};
                          NaN=1'b1;
                          state_next=done;
                         end
                       //if a or b =0 return 0
                       else if((a_exponent==0 && a_mantissa ==0)||(b_exponent==0 && b_mantissa==0))
                        begin
                         os_next=a_sign^b_sign;
                         oe_next=0;
                         product_next=0; 
                         state_next=done;                       
                        end
                       //if a or b = inf return inf
                       else if(a_exponent==255||b_exponent==255)
                          begin
                           os_next=a_sign^b_sign;
                           oe_next=255;
                           product_next=0;
                           inf=1'b1;
                           state_next=done;
                          end
//                        else 
//                            begin
//                             os_next=os_reg;
//                             oe_next=oe_reg;
////                             product_next=product_reg;
//                            end
                      state_next=mul;
                   end     
                 mul:
                    begin
                      os_next=a_sign^b_sign;
                      oe_next=a_exponent+b_exponent-127;
                      product_next=a_mantissa*b_mantissa;
                      state_next=normalized1;
                    end
                 normalized1: //normalized exponent
                            begin
                                  //    underflow and overflow
                                 if(oe_reg[9]==1)//under flow return 0;
                                    begin
                                    oe_next=0;
                                    product_next=0;
                                    state_next=done;
                                    end
                                 else if(oe_reg[8]==1)//overflow return inf
                                      begin
                                      oe_next=10'b0011111111;
                                      product_next=0;
                                      state_next=done;
                                      end
                                  else if((oe_reg[7:0]==8'b11111111)&&(product_reg==0)) //return inf
                                        begin
                                         oe_next=oe_reg;
                                         product_next=product_reg;
                                         inf=1'b1;
                                         state_next=done;
                                        end
                                  else if((oe_reg[7:0]==8'b11111111)&&(product_reg!=0))//return NaN
                                        begin
                                         oe_next=oe_reg;
                                         product_next=product_reg;
                                         NaN=1'b1;
                                         state_next=done;
                                        end
                                state_next=normalized2;
                            end
                 normalized2:   //normalized product
                            begin
                             if(product_reg[53]==1) //carry=1;
                               begin
                                oe_next=oe_reg+1;
                                product_next=product_reg>>1;
                                state_next=normalized1;
                               end
                             else if(product_reg[52]!=0)
                                  begin
                                   if(product_reg[52:51]==2'h1)
                                      begin
                                       product_next=product_reg<<1;
                                       oe_next=oe_reg-1;
                                      end
                                   else if(product_reg[52:50]==3'b1)
                                           begin
                                            product_next=product_reg<<2;
                                            oe_next=oe_reg-2;
                                           end
                                   else if(product_reg[52:49]==4'b1)
                                           begin
                                           product_next=product_reg<<3;
                                           oe_next=oe_reg-3;
                                           end 
                                    else if(product_reg[52:48]==5'b1)
                                            begin
                                            product_next=product_reg<<4;
                                            oe_next=oe_reg-4;
                                            end
                                    else if(product_reg[52:47]==6'b1)
                                             begin
                                             product_next=product_reg<<5;
                                             oe_next=oe_reg-5;
                                             end
                                    else if(product_reg[52:46]==7'b1)
                                            begin
                                             product_next=product_reg<<6;
                                            oe_next=oe_reg-6;
                                            end
                                    else if(product_reg[52:45]==8'b1)
                                            begin
                                            product_next=product_reg<<7;
                                            oe_next=oe_reg-7;
                                            end
                                   else if(product_reg[52:44]==9'b1)
                                             begin
                                             product_next=product_reg<<8;
                                             oe_next=oe_reg-8;
                                             end
                                   else if(product_reg[52:43]==10'b1)
                                             begin
                                             product_next=product_reg<<9;
                                             oe_next=oe_reg-9;
                                             end 
                                   else if(product_reg[52:42]==11'b1)
                                             begin
                                             product_next=product_reg<<10;
                                             oe_next=oe_reg-10;
                                             end
                                   else if(product_reg[52:41]==12'b1)
                                             begin
                                             product_next=product_reg<<11;
                                             oe_next=oe_reg-11;
                                             end
                                   else if(product_reg[52:40]==13'b1)
                                            begin
                                            product_next=product_reg<<12;
                                            oe_next=oe_reg-12;
                                            end
                                   else if(product_reg[52:39]==14'b1)
                                            begin
                                            product_next=product_reg<<13;
                                            oe_next=oe_reg-13;
                                            end
                                    else if(product_reg[52:38]==15'b1)
                                                     begin
                                                     product_next=product_reg<<14;
                                                     oe_next=oe_reg-14;
                                                     end
                                            else if(product_reg[52:37]==16'b1)
                                                    begin
                                                    product_next=product_reg<<15;
                                                    oe_next=oe_reg-15;
                                                    end
                                            else if(product_reg[52:36]==17'b1)
                                                    begin
                                                    product_next=product_reg<<16;
                                                    oe_next=oe_reg-16;
                                                    end
                                           else if(product_reg[52:35]==18'b1)
                                                     begin
                                                     product_next=product_reg<<17;
                                                     oe_next=oe_reg-17;
                                                     end
                                           else if(product_reg[52:34]==19'b1)
                                                     begin
                                                     product_next=product_reg<<18;
                                                     oe_next=oe_reg-18;
                                                     end 
                                           else if(product_reg[52:33]==20'b1)
                                                     begin
                                                     product_next=product_reg<<19;
                                                     oe_next=oe_reg-19;
                                                     end
                                           else if(product_reg[52:32]==21'b1)
                                                     begin
                                                     product_next=product_reg<<20;
                                                     oe_next=oe_reg-20;
                                                     end
                                           else if(product_reg[52:31]==22'b1)
                                                    begin
                                                    product_next=product_reg<<21;
                                                    oe_next=oe_reg-21;
                                                    end
                                           else if(product_reg[52:30]==23'b1)
                                                    begin
                                                    product_next=product_reg<<22;
                                                    oe_next=oe_reg-22;
                                                    end
                                           else if(product_reg[52:29]==24'b1)
                                                    begin
                                                    product_next=product_reg<<23;
                                                    oe_next=oe_reg-23;
                                                    end 
                                           else if(product_reg[52:28]==25'b1)
                                                     begin
                                                     product_next=product_reg<<24;
                                                     oe_next=oe_reg-24;
                                                     end
                                           else if(product_reg[52:27]==26'b1)
                                                      begin
                                                      product_next=product_reg<<25;
                                                      oe_next=oe_reg-25;
                                                      end
                                          else if(product_reg[52:26]==27'b1)
                                                      begin
                                                      product_next=product_reg<<26;
                                                      oe_next=oe_reg-26;
                                                      end
                                          else
                                              begin
                                               product_next=product_reg;
                                               oe_next=oe_reg;
                                              end 
                                  end
                                  state_next=rounding;
                            end
                  rounding:
                         begin
                         //round bit R :product[28],sticky bit S =product_reg[27]|product_reg[26]
                         /* RS=00-->no round 
                            RS=01-->truncate result by discarding RS
                            RS=11-->increment result (+1)
                            RS=10 -->check last bit(product_reg[30])
                                  -->om_reg[3]=0-->truncate
                                  -->om_reg[3]=1--increment (+1)
                         */
                         if(product_reg[28]==0) //RS=00,RS=01
                          begin
                           product_next=product_reg;
                           oe_next=oe_reg;
                          end
                         else //
                           begin
                               if(product_reg[27:26]==0)//RS=10
                                 begin
                                  if(product_reg[29]==0) //last bit =0
                                    begin
                                      product_next=product_reg;
                                      oe_next=oe_reg;
                                    end
                                  else              //lastbit=1
                                     begin
                                      product_next=product_reg+54'b000000000000000000000000100000000000000000000000000000;
                                      oe_next=oe_reg;
                                      state_next=normalized1;
                                     end
                                 end
                               else //RS=11;
                                 begin
                                 product_next=product_reg+54'b000000000000000000000000100000000000000000000000000000;//
                                 oe_next=oe_reg;
                                 state_next=normalized1;                    
                                 end
                            end 
                            state_next=done;                              
                         end
                      done:
                          begin
                           done_tick=1'b1;
                           state_next=idle;
                          end
                   default: state_next=idle;
                  endcase;
            end
 //   output
 assign o[31]=os_reg;
 assign o[30:23] =oe_reg[7:0];
 assign o[22:0] =product_reg[51:29];
endmodule
