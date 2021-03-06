$NOMOD51
$INCLUDE (AT89X52.h)


ORG 0000H

RESET:		SJMP 0030H 

ORG 0030H

			MOV TMOD,#01H
			MOV IE,#82H				  	;INTERRUPTS ENABLE : INT0, SERIAL, TIMER0
			MOV IP,#02H

			MOV TH0,#00H 				;LOAD COUNT 65536*42/1 = 3SECONDS
			MOV TL0,#00H
			MOV R4,#42					;R4 USED EXCLUSIVELY BY TIMER0 ISR
			MOV 31H,#80H				;31H HOLDS CURRENT POINTER

			
			
			MOV R0,31H
			SETB TR0					;START TIMER0
			CLR P3.4

MAIN:		NOP
			LJMP MAIN


ORG 000BH
			LJMP 1000H
ORG 1000H
TIME3:		CLR TR0
			CLR TF0
			MOV TH0,#00H
			MOV TL0,#00H
			DJNZ R4,MORE
			CPL P3.4
			MOV R4,#42
MORE:		SETB TR0
			RETI

END