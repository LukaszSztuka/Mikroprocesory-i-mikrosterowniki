//£ukasz Sztuka 243168 LAB03 Zad 03 Poprawa
//17.01.2021r.

//Dyrektywy
.include "m328Pdef.inc"
.DEF jed = R17
.DEF zer = R18
.ORG 0x0000 RJMP reset
.ORG 0x0008 RJMP aa
.ORG 0x002A RJMP przerw	//obs³uga przerwania od zakoñczenia konwersji

reset:

LDI R16, HIGH(RAMEND)	//Inicjalizacja stosu
OUT SPH, R16
LDI R16, LOW(RAMEND)
OUT SPL, R16

LDI jed,255
LDI zer, 0

OUT DDRD, jed			//wyjœcie
OUT DDRB, zer			//wejœcia
OUT PORTB, jed			//PULL-UP

LDI R16,0b00100010		//konwerter ustawiony na AREF, ADLAR=1, pin A2 [ADC2]
STS ADMUX,R16

LDI R20, 1			//konfiguracja przerwania
STS PCICR, R20			//wykrywanie przerwañ na  PCINT7..0 zgodnie z PCMSK0
LDI R20, 2
STS PCMSK0, R20			//wykrywanie na PCINT2 (D9 - PB1)

glowna:
SEI 				//globalne odblokowanie przerwañ
RJMP glowna

aa:
LDI R16, 0b11011111 	//W³¹czony, Start konw.,Tryb pracy =single, Prze. po kon=w³., Flaga przer., preskaler = 128
STS ADCSRA, R16

czekaj:
LDS R16, ADCSRA
SBRC R16, ADSC 		//przeskocz kiedy koniec konwersji, flaga ADIF zeruje siê auto.
RJMP czekaj

RETi

przerw:

LDS R19, ADCH		//wartoœæ wynik konwersji pierwsze 8 bitów

LDI R21, 0b00110011 //51- 1V
LDI R22, 0b01100110 //102-2V
LDI R23, 0b10011001 //153-3V
LDI R24, 0b11001100 //204-4V

CP R19, R21
BRLO a1
CP R19, R22
BRLO a2
CP R19, R23
BRLO a3
CP R19, R24
BRLO a4
RJMP a5

a1:
LDI R19,0b00000001
OUT PORTD, R19	// jeœli ni¿sze ni¿ 1V zapal 1
RET
a2:
LDI R19, 0b00000011
OUT PORTD, R19	// jeœli mniejsze ni¿ 2V zapal 2
RET
a3:
LDI R19, 0b00000111
OUT PORTD, R19	// jeœli mniejsze ni¿ 3V zapal 3
RET
a4:
LDI R19, 0b00001111
OUT PORTD, R19	// jeœli mniejsze ni¿ 4V zapal 4
RET
a5:
LDI R19, 0b00011111
OUT PORTD, R19	// jeœli mniejsze ni¿ 5V zapal 5
RET
RETi
