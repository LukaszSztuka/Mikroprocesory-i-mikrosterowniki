//£ukasz Sztuka 243168 Projekt
//19.01.2021r.

//1 cykl = 1/16 us
//1s = 16 000 000 cykli
//Preskaler = 1024
//OCR1 = 16M/1024 = 15 625 = 0b00111101 00001001 (OCR1AH, OCR1AL)

//Dyrektywy
.include "m328Pdef.inc"

LDI R21, HIGH(RAMEND)	//Inicjalizacja stosu
OUT SPH, R21
LDI R21, LOW(RAMEND)
OUT SPL, R21

LDI R16, 0b11111111
OUT DDRD, R16	// 8 wyjœæ

LDI R16,0 // 0b00111101
STS OCR1AH, R16
LDI R16, 0b00001001
STS OCR1AL, R16

LDI R16, 0b00000000
STS TCCR1A, R16
LDI R16, 0b00001001 // CTC, preskaler 1024 = 101
STS TCCR1B, R16

LDI R22, 10 
LDI R20, 0b10001100	//sekwencja 1
LDI R19, 0b01011010 //sekwencja 2
LDI R18, 0b01100001 //sekwencja 3
LDI R17, 0b01010011 //sekwencja 4

glowna:

zolty:
SBIS TIFR1, 1		//odliczanie 1 sekundy
RJMP zolty

OUT PORTD, R20 // zapala sekwencja 1

LDI R21, 0
SBI TIFR1, 1
zielony:
SBIS TIFR1, 1
RJMP zielony

INC R21
CP R21, R22		// aby odliczyæ 10 sekund
BREQ dalej1
SBI TIFR1, 1
RJMP zielony

dalej1:
OUT PORTD, R19 // zapala sekwencja 2
SBI TIFR1, 1

zolty2:
SBIS TIFR1, 1
RJMP zolty2

OUT PORTD, R18 // zapala sekwencja 3

LDI R21, 0
SBI TIFR1, 1
zielony2:
SBIS TIFR1, 1
RJMP zielony2

INC R21
CP R21, R22
BREQ dalej2
SBI TIFR1, 1
RJMP zielony2

dalej2:
OUT PORTD, R17 // zapala sekwencja 4
SBI TIFR1, 1

RJMP glowna

