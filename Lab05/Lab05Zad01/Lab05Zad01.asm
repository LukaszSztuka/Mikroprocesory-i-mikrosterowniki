//£ukasz Sztuka 243168 LAB05 Zad 01
//14.12.2020r.

//Dyrektywy
.include "m328Pdef.inc"
.DEF jed = R17
.DEF zer = R18

// f = 168 Hz
// b³¹d = 0,0064%

SER R17
CLR R18

SBI DDRD, 6		// OC0A = D6

LDI R16, $17	// OCR = 5951 = 173F
OUT OCR0A, R16
LDI R16, $3F
OUT OCR0B, R16

LDI R16, 0b01010010	// CTC, Preskaler = 8
OUT TCCR0A, R16
LDI R16, 0b00000010
OUT TCCR0B, R16

glowna:
NOP
RJMP glowna

