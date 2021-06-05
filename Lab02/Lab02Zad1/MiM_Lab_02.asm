//£ukasz Sztuka 243168 LAB01 Zad 02 
//20.11.2020r.

//Dyrektywy
.include "m328Pdef.inc"
.DEF jed = R17
.DEF zer = R18
.DEF przycik1 = R19

//Inicjalizacja stosu
LDI R16, HIGH(RAMEND)
OUT SPH, R16
LDI R16, LOW(RAMEND)
OUT SPL, R16

SER R17
CLR R18
LDI R19, 0b11111110
LDI R24, 0b11111101
LDI R25, 0b11111011
OUT DDRD, jed
OUT DDRB, zer

OUT PORTB, jed //PULL-UP


CLR R21

//Pêtla g³ówna
glowna:
	
	IN R20, PINB
	CP R20, R19
	BREQ wartosc1
	CP R20, R24
	BREQ wartosc2
	CP R20, R25
	BREQ wartosc3

	CPSE R21, zer
	RCALL powtorz

RJMP glowna

powtorz:	
	bb:
		OUT PORTD, jed
		RCALL czekaj
		OUT PORTD, zer
		RCALL czekaj
	DEC R21
	BRNE bb
RET

//Podprogramy
wartosc1:
	LDI R21, 2
RJMP powtorz

wartosc2:
	LDI R21, 3
RJMP powtorz

wartosc3:
	LDI R21, 5
RJMP powtorz

czekaj:		// 1s
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
