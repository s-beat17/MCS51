ORG 0h
	
MAIN:	MOV DPTR, #init		;Устанавливаем указатель DPTR на начало данных
		MOV R0,#10			;Количество повторений цикла
		MOV R1,#0			;Регистр для суммы данных
		MOVC A,@A+DPTR 		;Чтение данных из CSEG по адресу (A)+(DPTR)
		MOV R1,A			;Первое значение из памяти в R1
BACK: 	INC DPTR
		CLR A
		MOVC A,@A+DPTR
		ADD A,R1			;Сумма 10 чисел в R1
		MOV R1,A
NEXT: 	DJNZ R0,BACK		;Конец цикла если R0=0
		MOV B,#10				
		MOV A,R1
		DIV AB				;Среднее арифметическое в А
		MOV R0,A
		MOV DPTR, #max
		CLR A
		MOVC A,@A+DPTR
		MOV B,A
		MOV A,R0
		CJNE A,B,M1
M1:		JNC M2				;X > Max
		JC M3				;X < Max
M2:		MOV P1,#11B			;P1 = 11B
		JMP EXIT			
M3:		MOV DPTR, #min
		CLR A
		MOVC A,@A+DPTR
		MOV B,A
		MOV A,R0
		CJNE A,B,M4
M4:		JNC M5				;Max > X > Min
		JC M6				;X < Min
M5:		MOV P1,#10B			;P1 = 10B
		JMP EXIT
M6:		MOV P1,#00B			;P1 = 00
		JMP EXIT			
EXIT:	JMP MAIN
		
ORG 1000h
init:
		DB 1,2,3,4,5,6,7,8,9,10 	;Таблица данных во внешней памяти
ORG 1010h
min:
		DB 25
ORG 1011h
max:
		DB 100
END