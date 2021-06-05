//£ukasz Sztuka 243168 LAB03 Zad 02
//17.01.2021r.

//Dyrektywy
.include "m328Pdef.inc"
.DEF jed = R17
.DEF zer = R18
.ORG 0x0000 RJMP reset
.ORG 0x0008 RJMP aa

reset:

LDI R16, HIGH(RAMEND)	//Inicjalizacja stosu
OUT SPH, R16
LDI R16, LOW(RAMEND)
OUT SPL, R16

LDI jed,255
LDI zer, 0

OUT DDRD, jed			//wyjœcie
OUT DDRC, jed
OUT DDRB, zer			//wejœcia

OUT PORTB, jed			//PULL-UP

LDI R16,0b11001000		//ref na 1.1V, ADLAR=0 wyrównanie do prawej, czujnik temp. [ADC8]
STS ADMUX,R16

LDI R20, 1				//konfiguracja przerwania
STS PCICR, R20
LDI R20, 2
STS PCMSK0, R20

glowna:
SEI 					//globalne odblokowanie przerwañ
RJMP glowna

aa:

LDI R16, 0b11000111 //W³¹czony, Start konw.,Tryb pracy =single, Prze, prze. po kon=w³., preskaler = 128
STS ADCSRA, R16

czekaj:
LDS R16, ADCSRA
SBRC R16, ADSC 		//przeskocz kiedy koniec konwersji, druga flaga, zeruje siê auto.
RJMP czekaj

LDS R19, ADCL		//wartoœæ wynik konwersji ostatnie 8 bitów
OUT PORTD, R19
LDS R19, ADCH		//pierwsze 2 bity
OUT PORTC, R19

RETi
