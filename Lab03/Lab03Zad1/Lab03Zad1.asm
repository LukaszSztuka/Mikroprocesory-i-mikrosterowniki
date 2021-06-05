//�ukasz Sztuka 243168 LAB03 Zad 01
//03.12.2020r.

//Dyrektywy
.include "m328Pdef.inc"
.DEF jed = R17
.DEF zer = R18
.ORG 0x0000 RJMP reset
.ORG 0x0008 RJMP aa
.ORG 0x002A RJMP przerw	//obs�uga przerwania od zako�czenia konwersji

reset:

LDI R16, HIGH(RAMEND)	//Inicjalizacja stosu
OUT SPH, R16
LDI R16, LOW(RAMEND)
OUT SPL, R16

LDI jed,255
LDI zer, 0

OUT DDRD, jed			//wyj�cie
OUT DDRB, zer			//wej�cia
OUT PORTB, jed			//PULL-UP

LDI R16,0b00100010		//konwerter ustawiony na AREF, ADLAR=1, pin A2 [ADC2]
STS ADMUX,R16

LDI R20, 1				//konfiguracja przerwania
STS PCICR, R20			//wykrywanie przerwa� na  PCINT7..0 zgodnie z PCMSK0
LDI R20, 2
STS PCMSK0, R20			//wykrywanie na PCINT2 (D9 - PB1)

glowna:
SEI 					//globalne odblokowanie przerwa�

RJMP glowna

aa:
LDI R16, 0b11011111 //W��czony, Start konw.,Tryb pracy =single, Prze, prze. po kon=w�., preskaler = 128
STS ADCSRA, R16

czekaj:
LDS R16, ADCSRA
SBRC R16, ADSC 		//przeskocz kiedy koniec konwersji, druga flaga, zeruje si� auto.
RJMP czekaj

RETi

przerw:

LDS R19, ADCH		//warto�� wynik konwersji pierwsze 8 bit�w
OUT PORTD, R19
RETi
