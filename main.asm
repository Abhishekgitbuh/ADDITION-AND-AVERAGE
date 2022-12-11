/*write a program with three subroutines to 
(A) transfer the following data from on-chip ROM to RAM locations starting at 30H,
(B) add them and save the result in 70H, and
(C) find the average of the data and store it in R7.
Notice that the data is stored in a code space of on-chip ROM.
ORG 200H
	MYDATA: DB 3,9,6,9,7,6,4,2,8
*/

ORG 0
ACALL AVGDATA
SJMP $
	
;----subroutine for transfer of data
TRFDATA: 
MOV DPTR, #MYDATA
MOV R0, #30H
MOV R2, #9
LOOP:
CLR A
MOVC A, @A+DPTR
INC DPTR
MOV @R0, A
INC R0
DJNZ R2, LOOP
RET

;------subroutine for addition of data
ADDDATA:
ACALL TRFDATA
MOV R0, #30H
MOV R2, #9
CLR A
BACK:ADD A, @R0
INC R0
DJNZ R2, BACK
MOV 70H, A
RET


;------suroutine for averaging of data
AVGDATA:
ACALL ADDDATA
MOV B, #9
DIV AB
MOV R7, A
RET

ORG 200H
	MYDATA: DB 3,9,6,9,7,6,4,2,8
END
