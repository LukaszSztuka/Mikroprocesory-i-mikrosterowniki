//£ukasz Sztuka 243168 Lab 05 Zad 03
//05.01.2021r.

//Dyrektywy
.include "m328Pdef.inc"

LDI R19, HIGH(RAMEND)	//Inicjalizacja stosu
OUT SPH, R19
LDI R19, LOW(RAMEND)
OUT SPL, R19

LDI R16, 0b00101100
OUT DDRB, R16

SBI DDRC,5

LDI R16, 0b01010000
OUT SPCR, R16

SBI PORTC, 5		// CS = 1 WY£.

//Knfiguracja Sterownika MAX7219
//Ramka 1

CBI PORTC, 5		// CS = 0 W£.
LDI R20, 0b00001001	// Adres: Decode Mode
OUT SPDR, R20
RCALL czekaj
LDI R20, 0b00000000 // Dekodowanie Wy³.
OUT SPDR, R20
RCALL czekaj
SBI PORTC, 5		// CS = 1 WY£.

//Ramka 2

CBI PORTC, 5		// CS = 0 W£.
LDI R20, 0b00001010	// Adres: Intansity
OUT SPDR, R20
RCALL czekaj
LDI R20, 0b00001111 // Moc 31/32
OUT SPDR, R20
RCALL czekaj
SBI PORTC, 5		// CS = 1 WY£.

//Ramka 3

CBI PORTC, 5		// CS = 0 W£.
LDI R20, 0b00001011	// Adres: Scanl Limit
OUT SPDR, R20
RCALL czekaj
LDI R20, 0b00000011 // Kolumny 0, 1, 2, 3
OUT SPDR, R20
RCALL czekaj
SBI PORTC, 5		// CS = 1 WY£.

//Ramka 4

CBI PORTC, 5		// CS = 0 W£.
LDI R20, 0b00001100	// Adres: Shutdown
OUT SPDR, R20
RCALL czekaj
LDI R20, 0b00000001 // Noraml operation
OUT SPDR, R20
RCALL czekaj
SBI PORTC, 5		// CS = 1 WY£.

//Ramka 5

CBI PORTC, 5		// CS = 0 W£.
LDI R20, 0b00001111	// Adres: Display test
OUT SPDR, R20
RCALL czekaj
LDI R20, 0b00000000 // Normal operation
OUT SPDR, R20
RCALL czekaj
SBI PORTC, 5		// CS = 1 WY£.

//Konfiguracja Wyœwietlacza 8x8
//Ramka 6

CBI PORTC, 5		// CS = 0 W£.
LDI R20, 0b00000001	// Adres: Kolumna 0
OUT SPDR, R20
RCALL czekaj
LDI R20, 0b01101100 // Wiersze w³.: 2, 3, 5, 6
OUT SPDR, R20
RCALL czekaj
SBI PORTC, 5		// CS = 1 WY£.

//Ramka 7

CBI PORTC, 5		// CS = 0 W£.
LDI R20, 0b00000010	// Adres: Kolumna 1
OUT SPDR, R20
RCALL czekaj
LDI R20, 0b10010010 // Wiersze w³.: 1, 4, 7
OUT SPDR, R20
RCALL czekaj
SBI PORTC, 5		// CS = 1 WY£.

//Ramka 8

CBI PORTC, 5		// CS = 0 W£.
LDI R20, 0b00000011	// Adres: Kolumna 2
OUT SPDR, R20
RCALL czekaj
LDI R20, 0b10010010 // Wiersze w³.: 1, 4, 7
OUT SPDR, R20
RCALL czekaj
SBI PORTC, 5		// CS = 1 WY£.

//Ramka 9

CBI PORTC, 5		// CS = 0 W£.
LDI R20, 0b00000100	// Adres: Kolumna 3
OUT SPDR, R20
RCALL czekaj
LDI R20, 0b01101100 // Wiersze w³.: 2, 3, 5, 6
OUT SPDR, R20
RCALL czekaj
SBI PORTC, 5		// CS = 1 WY£.

//Ramka 10

CBI PORTC, 5		// CS = 0 W£.
LDI R20, 0b00000101	// Adres: Kolumna 4
OUT SPDR, R20
RCALL czekaj
LDI R20, 0b00000000 // Wiersze w³.:
OUT SPDR, R20
RCALL czekaj
SBI PORTC, 5		// CS = 1 WY£.

//Ramka 11

CBI PORTC, 5		// CS = 0 W£.
LDI R20, 0b00000110	// Adres: Kolumna 5
OUT SPDR, R20
RCALL czekaj
LDI R20, 0b00000000 // Wiersze w³.:
OUT SPDR, R20
RCALL czekaj
SBI PORTC, 5		// CS = 1 WY£.

//Ramka 12

CBI PORTC, 5		// CS = 0 W£.
LDI R20, 0b00000111	// Adres: Kolumna 6
OUT SPDR, R20
RCALL czekaj
LDI R20, 0b00000000 // Wiersze w³.:
OUT SPDR, R20
RCALL czekaj
SBI PORTC, 5		// CS = 1 WY£.

//Ramka 13

CBI PORTC, 5		// CS = 0 W£.
LDI R20, 0b00001000	// Adres: Kolumna 7
OUT SPDR, R20
RCALL czekaj
LDI R20, 0b00000000 // Wiersze w³.:
OUT SPDR, R20
RCALL czekaj
SBI PORTC, 5		// CS = 1 WY£.

czekaj:
IN R18, SPSR
SBRS R18, 7
RJMP czekaj
RET

QQ:
NOP
RJMP QQ
