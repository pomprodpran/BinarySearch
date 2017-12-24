	AREA mydata, DATA, READWRITE
;array dcd 4,7,8,10,14,21,22,36,62,77,81,91
array dcd 4,7,8,10,14,21,36,62,77,81,91,101

length equ 12

	AREA mymain,CODE, READONLY
	EXPORT main
	ENTRY
	
;REGISTERS THAT WILL BE USED THROUGHOUT THE CODE
;	R0 = ARRAY
;	R1 = FIRST
;	R2 = LAST
;	R3 = KEY
;	R4 = MIDDLE
;	R5 = ARRAY[MIDDLE]



main 
		LDR r0,=array		
		MOV r1,#0
		MOV r2,#length-1
		MOV r3,#22
		
start	
		CMP r1,r2			; if (FIRST>LAST) then stop
		BGT stop
		ADD r4,r1,r2		; FIRST+LAST
		MOV r4,r4,ASR#1		; (FIRST+LAST)/2
		LSL r4,r4,#2		; MID*0x0004
		LDR r5,[r0,r4]		; r5=ARRAY[MIDDLE]
		CMP r5,r3			; if (ARRAY[MIDDLE]==KEY) then finish
		BEQ finish			
		LSR r4,#2			; MID/0x0004
		SUBGT r2,r4,#1		; if(KEY<ARRAY[MID]) then move LAST = MID-1
		ADDLE r1,r4,#1		; if(KEY>ARRAY[MID]) then move FIRST = MID+1
		B start				; loop until find key or don't have key in this array(do until FIRST>LAST)
		
finish	B finish
stop	B stop
	
	
END