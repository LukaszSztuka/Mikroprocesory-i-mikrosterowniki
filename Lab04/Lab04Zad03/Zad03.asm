//£ukasz Sztuka 243168 LAB04 Zad 03
//14.12.2020r.


// 1 cykl = 0,0625 us
// 68000/0,0625 = 1088000 cykli = 68 ms
// Preskaler: N = 1024
// OCR2 = 1088000/1024
//Dyrektywy
.include "m328Pdef.inc"
.DEF jed = R17
.DEF zer = R18
.ORG 0x0000 RJMP reset
.ORG 0x01C RJMP przerw

reset:

	LDI R16, HIGH(RAMEND)	//Inicjalizacja stosu
	OUT SPH, R16
	LDI R16, LOW(RAMEND)
	OUT SPL, R16

	SER jed
	CLR zer

	OUT DDRC, jed 		//wyjœcie LED	   	 C0, C1, C2, C3, C4 
	OUT DDRD, zer
	LDI R19, 0b00010000 //wejœcia przycisk	 D4
	OUT PORTD, R19		//PULL-UP			 D4

	SEI					// w³¹czenie przerwañ 

	LDI R19, 0b00000010 // konfiguracja licznika, CTC
	OUT TCCR2A, R19
	LDI R19, 0b00000111 //preskaler 1024 
	OUT TCCR2B, R19
	LDI R19, 0b00001110	//liczy do 15
	OUT OCR2A, R19	
	LDI R19, 0b00000010 //przerwanie od doliczenia 
	STS TIMSK2, R19


glowna:
	
	IN R20, TCNT2
	OUT PORTC, R20 

RJMP glowna

przerw:
	LDI R19, 0b0011111
	OUT PORTC, R19 
	RCALL czekaj
	LDI R19, 0
	OUT PORTC, zer
	RCALL czekaj

RETi

czekaj: // opóŸnienie 
LDI R22,15
p1:
	LDI R23,255
	p2:
		LDI R24,255
		p3:
		DEC R24
		BRNE p3
	NOP
	DEC R23
	BRNE p2

DEC R22
BRNE p1
RET
