;RUN WITH NO 'LAST BYTE' ERRORS
;09/08/2007
;MSG DISPLAYED ON LCD USING AT89C51
;PROGRAM RUN----- SUCCESS



ORG 0000H 				; P1.1-RS
SJMP 0030H				; P1.2-R/W
ORG 0030H 				; P1.3-EN




START:	CLR A 
	MOV P1,A
	MOV P2,A
	MOV P3,A
	
	MOV R3,A
	


INIT:	MOV A,#38H
	LCALL COMMAND
	MOV A,#0CH
	LCALL COMMAND
	MOV A,#06H
	LCALL COMMAND
	MOV A,#01H
	LCALL COMMAND
	


	;MOV A,#'V'
	;LCALL DISPLAY
REWRT:	MOV DPTR,#0F80H			;CHAR BYTES FROM 0F80H
LOOP:	CLR A
	;INC R3
	MOVC A,@A+DPTR
	INC DPTR
	LCALL DISPLAY
	LCALL DELAY
	CLR A
	MOVC A,@A+DPTR
	CJNE A,#0FFH,LOOP
	
	LCALL CLEAR
	SJMP REWRT
	
HERE:	SJMP HERE




COMMAND:LCALL READY
	CLR P1.2
	CLR P1.1
	MOV P2,A
	SETB P1.3
	NOP
	CLR P1.3
	RET


READY: 	SETB P2.7
	CLR P1.1
	SETB P1.2
BUSY:	CLR P1.3
	SETB P1.3
	JB P2.7,BUSY
	NOP 
	CLR P1.3
	RET


DISPLAY:LCALL READY
	CLR P1.2
	SETB P1.1
	MOV P2,A
	SETB P1.3
	NOP
	CLR P1.3
	RET

DELAY:  MOV R7,#03H
WAITC:	MOV R6,#0FFH
WAITB:	MOV R5,#0FFH
WAITA:	DJNZ R5,WAITA
	DJNZ R6,WAITB
	DJNZ R7,WAITC
	RET

CLEAR:	MOV A,#01H
	LCALL COMMAND
	MOV A,#0C0H
	LCALL COMMAND
	RET




ORG 0F80H
		DB 'hey spu !!!'
		;DB 'Be The Change You Want To See!'
END