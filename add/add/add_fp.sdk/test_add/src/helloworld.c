/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xil_io.h"
#include <math.h>


#define base_addr 0x44A00000
#define ADD_FP_S00_AXI_SLV_REG0_OFFSET 0 //enable
#define ADD_FP_S00_AXI_SLV_REG1_OFFSET 4//a
#define ADD_FP_S00_AXI_SLV_REG2_OFFSET 8 //b
#define ADD_FP_S00_AXI_SLV_REG3_OFFSET 12 //op
#define ADD_FP_S00_AXI_SLV_REG4_OFFSET 16 //done_tick
#define ADD_FP_S00_AXI_SLV_REG5_OFFSET 20 //NaN
#define ADD_FP_S00_AXI_SLV_REG6_OFFSET 24 //inf
#define ADD_FP_S00_AXI_SLV_REG7_OFFSET 28 //o



int main()
{
    init_platform();
    u32 out;
    u32 NaN,inf;

    float f_type = 1.5;
    int i_type, *i_pointer;
//    i_pointer = & f_type;
 //   i_type = *i_pointer;

    i_type = *((int*)&f_type);
    int output;

 /*   for (int i = 31; i >= 0; i--)
    {
    	if (i_type & (1 << i))
    	{
    		printf("1");
    	}
    	else
    	{
    		printf("0");
    	}
    }
*/
    printf("\n\n");
    for (int i=0; i<50 ;i++){
        Xil_Out32(base_addr+4,f_type);
        Xil_Out32(base_addr+8,f_type);
    	Xil_Out32(base_addr, 0);
    	Xil_Out32(base_addr+12, 0);
    	Xil_Out32(base_addr, 1);
    	while(Xil_In32(base_addr+16)!=0);
    	out =Xil_In32(base_addr+28);
    	NaN =Xil_In32(base_addr+20);
    	inf =Xil_In32(base_addr+24);

 //   	output =*((int*)&out);
        for (int i = 31; i >= 0; i--)
        {
        	if (output & (1 << i))
        	{
        		printf("1");
        	}
        	else
        	{
        		printf("0");
        	}
        }
        printf("\ ket qua =%s",output);
        printf("\ NaN =%d",NaN);
        printf("\ inf =%d",inf);

    }

    print("Hello World\n\r");

    cleanup_platform();
    return 0;
}
