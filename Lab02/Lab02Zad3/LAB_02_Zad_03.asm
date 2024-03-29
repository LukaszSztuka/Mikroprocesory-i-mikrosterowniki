//�ukasz Sztuka 243168 LAB02 Zad 03
//21.11.2020r.

//Dyrektywy
.include "m328Pdef.inc"

//Inicjalizacja stosu
LDI R16, HIGH(RAMEND)
OUT SPH, R16
LDI R16, LOW(RAMEND)
OUT SPL, R16

LDI R17,255
LDI R18, 0
//243168
LDI R19, 0b10100100  //2
LDI R20, 0b10011001  //4
LDI R21, 0b10110000  //3
LDI R22, 0b11111001  //1
LDI R23, 0b10000010  //6
LDI R24, 0b10000000  //8

OUT DDRD, R17 //wyj�cie
OUT DDRB, R18 //wej�cie
OUT PORTB, R17// pull-up

//P�tla g��wna
glowna:

	SBIS PINB, 0
	RJMP wprawo
	SBIS PINB, 1
	RJMP wlewo

RJMP glowna

//Podprogramy

wprawo:
		OUT PORTD, R19
	RCALL czekaj
		OUT PORTD, R20
	RCALL czekaj
		OUT PORTD, R21
	RCALL czekaj
		OUT PORTD, R22
	RCALL czekaj
		OUT PORTD, R23
	RCALL czekaj
		OUT PORTD, R24
	RCALL czekaj
RJMP glowna

wlewo:
		OUT PORTD, R24
	RCALL czekaj
		OUT PORTD, R23
	RCALL czekaj
		OUT PORTD, R22
	RCALL czekaj
		OUT PORTD, R21
	RCALL czekaj
		OUT PORTD, R20
	RCALL czekaj
		OUT PORTD, R19
	RCALL czekaj
RJMP glowna

czekaj:	
LDI R26,102
q1:
	LDI R27,255
	q2:
		LDI R28, 255
		q3:
			DEC R28
		BRNE q3
		NOP		
	DEC R27
	BRNE q2	
DEC R26
BRNE q1	
RET
