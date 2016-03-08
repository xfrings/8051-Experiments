ORG 0000H
SJMP 0030H
ORG 0030H



START:  MOV A,P1
	MOV R0,#00H
	ADD A,R0
	MOV R0,A
UPCOUNT:MOV P2,R0
	INC R0
	ACALL DELAY
	CJNE R0,#1FH,UPCOUNT
DNCOUNT:DEC R0
	MOV P2,R0
	ACALL DELAY
	CJNE R0,#00H,DNCOUNT
	SJMP START	



DELAY:  MOV R5,#05H
WAITC:	MOV R6,#0FFH
WAITB:	MOV R7,#0FFH
WAITA:	DJNZ R7,WAITA
	DJNZ R6,WAITB
	DJNZ R5,WAITC
	RET

NOP 
NOP
NOP
NOP
END