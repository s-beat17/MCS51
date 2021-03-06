; Лабораторная работа 1, задание 2.
; Пересылка массива констант (8 чисел) из внешней памяти программ CSEG
; в резидентную память данных DSEG по адресам 20h-27h

ORG 0h 				;Начало программы: от 0h - только если нет
					; обработки других прерываний
M1:
MOV DPTR, #init 	;Устанавливаем указатель DPTR на начало данных
MOV R0, #8 			;Количество повторений цикла
MOV R1, #20h 		;Начальный адрес таблицы данных в DSEG
LOOP:
MOV A, #0
MOVC A, @A+DPTR 	;Чтение данных из CSEG по адресу (A)+(DPTR)
MOV @R1, A 			;Запись данных в таблицу DSEG по адресу (R1)
INC DPTR
INC R1
DJNZ R0,LOOP 		;Декримент R0, если не ноль то переход на LOOP
JMP M1 				;Можно повторить с начала для целей упражнения

ORG 1000h
init:
DB 1,2,3,4,5,6,7,8 	;Таблица данных во внешней памяти

END