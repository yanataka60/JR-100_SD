EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr User 15748 10236
encoding utf-8
Sheet 1 1
Title "JR-100_SD"
Date "2022-01-14"
Rev "Rev1.3"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L power:+5V #PWR07
U 1 1 61C53293
P 7150 1200
F 0 "#PWR07" H 7150 1050 50  0001 C CNN
F 1 "+5V" H 7165 1373 50  0000 C CNN
F 2 "" H 7150 1200 50  0001 C CNN
F 3 "" H 7150 1200 50  0001 C CNN
	1    7150 1200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR08
U 1 1 61CA5FA4
P 7150 3350
F 0 "#PWR08" H 7150 3100 50  0001 C CNN
F 1 "GND" H 7155 3177 50  0000 C CNN
F 2 "" H 7150 3350 50  0001 C CNN
F 3 "" H 7150 3350 50  0001 C CNN
	1    7150 3350
	1    0    0    -1  
$EndComp
$Comp
L Device:C C2
U 1 1 61E99EF6
P 6400 3350
F 0 "C2" V 6250 3450 50  0000 C CNN
F 1 "0.1uF" V 6250 3200 50  0000 C CNN
F 2 "Capacitor_THT:C_Rect_L4.0mm_W2.5mm_P2.50mm" H 6438 3200 50  0001 C CNN
F 3 "~" H 6400 3350 50  0001 C CNN
	1    6400 3350
	0    -1   -1   0   
$EndComp
Wire Wire Line
	7150 3300 7150 3350
Connection ~ 7150 3350
Wire Wire Line
	6250 1200 7150 1200
Connection ~ 7150 1200
$Comp
L Memory_EPROM:27C64 U3
U 1 1 61A4CF3B
P 7150 2200
F 0 "U3" H 6950 3150 50  0000 C CNN
F 1 "2764" H 7350 3150 50  0000 C CNN
F 2 "Package_DIP:DIP-28_W15.24mm_LongPads" H 7150 2200 50  0001 C CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/11107M.pdf" H 7150 2200 50  0001 C CNN
	1    7150 2200
	1    0    0    -1  
$EndComp
Wire Wire Line
	9250 3000 11600 3000
Wire Wire Line
	11600 4400 11700 4400
Wire Wire Line
	11600 3000 11600 4400
Wire Wire Line
	11150 6200 13250 6200
Wire Wire Line
	11150 4600 11700 4600
Wire Wire Line
	11150 4700 11700 4700
Wire Wire Line
	11150 4800 11700 4800
Wire Wire Line
	11150 4900 11700 4900
Wire Wire Line
	11150 5000 11700 5000
Wire Wire Line
	11150 5100 11700 5100
Wire Wire Line
	11150 5200 11700 5200
Wire Wire Line
	11150 5300 11700 5300
Wire Wire Line
	13950 5000 12900 5000
Wire Wire Line
	13950 3300 13950 5000
Wire Wire Line
	12450 3300 13950 3300
Wire Wire Line
	12450 2300 12450 3300
Wire Wire Line
	13050 2300 12450 2300
Wire Wire Line
	13850 5100 12900 5100
Wire Wire Line
	13850 3400 13850 5100
Wire Wire Line
	12550 3400 13850 3400
Wire Wire Line
	12550 2400 12550 3400
Wire Wire Line
	13050 2400 12550 2400
Wire Wire Line
	13750 5200 12900 5200
Wire Wire Line
	13750 3500 13750 5200
Wire Wire Line
	12650 3500 13750 3500
Wire Wire Line
	12650 2500 12650 3500
Wire Wire Line
	13050 2500 12650 2500
Wire Wire Line
	13650 5300 12900 5300
Wire Wire Line
	13650 3600 13650 5300
Wire Wire Line
	12750 3600 13650 3600
Wire Wire Line
	12750 2600 12750 3600
Wire Wire Line
	13050 2600 12750 2600
Wire Wire Line
	11150 3700 13350 3700
Wire Wire Line
	11150 3800 13250 3800
Wire Wire Line
	11150 3900 11500 3900
Wire Wire Line
	11150 4000 11400 4000
$Comp
L Memory_RAM2:Micro_SD_Card_Kit J6
U 1 1 6188B7C4
P 13950 2200
F 0 "J6" H 13450 2900 50  0000 L CNN
F 1 "Micro_SD_Card_Kit" H 13950 2900 50  0000 L CNN
F 2 "Kicad:AE-microSD-LLCNV" H 15100 2500 50  0001 C CNN
F 3 "http://katalog.we-online.de/em/datasheet/693072010801.pdf" H 13950 2200 50  0001 C CNN
	1    13950 2200
	1    0    0    -1  
$EndComp
NoConn ~ 13050 2000
NoConn ~ 13050 2100
NoConn ~ 13050 2700
$Comp
L power:+5V #PWR016
U 1 1 625CD0DA
P 12900 1750
F 0 "#PWR016" H 12900 1600 50  0001 C CNN
F 1 "+5V" H 12915 1923 50  0000 C CNN
F 2 "" H 12900 1750 50  0001 C CNN
F 3 "" H 12900 1750 50  0001 C CNN
	1    12900 1750
	1    0    0    -1  
$EndComp
Wire Wire Line
	12900 1750 12900 1900
Wire Wire Line
	12900 1900 13050 1900
$Comp
L power:GND #PWR017
U 1 1 625DAB5A
P 12900 2850
F 0 "#PWR017" H 12900 2600 50  0001 C CNN
F 1 "GND" H 12905 2677 50  0000 C CNN
F 2 "" H 12900 2850 50  0001 C CNN
F 3 "" H 12900 2850 50  0001 C CNN
	1    12900 2850
	1    0    0    -1  
$EndComp
Wire Wire Line
	13050 2200 12900 2200
Wire Wire Line
	12900 2200 12900 2850
Wire Wire Line
	13100 4500 13100 4200
Wire Wire Line
	12900 4500 13100 4500
NoConn ~ 11700 4200
NoConn ~ 11700 4300
NoConn ~ 11700 4500
NoConn ~ 12200 5700
NoConn ~ 12300 5700
NoConn ~ 12900 4400
NoConn ~ 12900 4200
NoConn ~ 11150 6100
NoConn ~ 11150 6000
NoConn ~ 11150 5900
NoConn ~ 11150 5800
NoConn ~ 11150 5600
NoConn ~ 11150 5500
NoConn ~ 11150 4400
NoConn ~ 11150 4300
NoConn ~ 11150 4200
NoConn ~ 11150 4100
$Comp
L power:+5V #PWR019
U 1 1 621E99AD
P 13100 4200
F 0 "#PWR019" H 13100 4050 50  0001 C CNN
F 1 "+5V" H 13115 4373 50  0000 C CNN
F 2 "" H 13100 4200 50  0001 C CNN
F 3 "" H 13100 4200 50  0001 C CNN
	1    13100 4200
	1    0    0    -1  
$EndComp
Wire Wire Line
	13000 4300 13000 5500
Wire Wire Line
	12900 4300 13000 4300
$Comp
L power:GND #PWR018
U 1 1 621A9C99
P 13000 5500
F 0 "#PWR018" H 13000 5250 50  0001 C CNN
F 1 "GND" H 13005 5327 50  0000 C CNN
F 2 "" H 13000 5500 50  0001 C CNN
F 3 "" H 13000 5500 50  0001 C CNN
	1    13000 5500
	1    0    0    -1  
$EndComp
Wire Wire Line
	12500 5900 12500 5700
Wire Wire Line
	11400 5900 12500 5900
Wire Wire Line
	11400 4000 11400 5900
Wire Wire Line
	12400 5800 12400 5700
Wire Wire Line
	11500 5800 12400 5800
Wire Wire Line
	11500 3900 11500 5800
Wire Wire Line
	13250 4600 12900 4600
Wire Wire Line
	13250 3800 13250 4600
Wire Wire Line
	13350 4700 12900 4700
Wire Wire Line
	13350 3700 13350 4700
Wire Wire Line
	13350 4800 12900 4800
Wire Wire Line
	13350 6300 13350 4800
Wire Wire Line
	11300 6300 13350 6300
Wire Wire Line
	11300 5700 11300 6300
Wire Wire Line
	11150 5700 11300 5700
Wire Wire Line
	13250 4900 12900 4900
Wire Wire Line
	13250 6200 13250 4900
Connection ~ 10450 3400
$Comp
L power:+5V #PWR012
U 1 1 61F63930
P 10450 3400
F 0 "#PWR012" H 10450 3250 50  0001 C CNN
F 1 "+5V" H 10465 3573 50  0000 C CNN
F 2 "" H 10450 3400 50  0001 C CNN
F 3 "" H 10450 3400 50  0001 C CNN
	1    10450 3400
	1    0    0    -1  
$EndComp
Wire Wire Line
	9700 3400 10450 3400
Wire Wire Line
	9700 6650 9700 3400
Wire Wire Line
	9800 6650 9700 6650
Connection ~ 10450 6650
Wire Wire Line
	10450 6600 10450 6650
Wire Wire Line
	10450 6650 10450 6700
Wire Wire Line
	10100 6650 10450 6650
$Comp
L power:GND #PWR013
U 1 1 61F38F70
P 10450 6700
F 0 "#PWR013" H 10450 6450 50  0001 C CNN
F 1 "GND" H 10455 6527 50  0000 C CNN
F 2 "" H 10450 6700 50  0001 C CNN
F 3 "" H 10450 6700 50  0001 C CNN
	1    10450 6700
	1    0    0    -1  
$EndComp
$Comp
L Device:C C5
U 1 1 61F2D5C6
P 9950 6650
F 0 "C5" V 9800 6750 50  0000 C CNN
F 1 "0.1uF" V 9800 6500 50  0000 C CNN
F 2 "Capacitor_THT:C_Rect_L4.0mm_W2.5mm_P2.50mm" H 9988 6500 50  0001 C CNN
F 3 "~" H 9950 6650 50  0001 C CNN
	1    9950 6650
	0    -1   -1   0   
$EndComp
$Comp
L Interface:8255 U5
U 1 1 618A36EE
P 10450 5000
F 0 "U5" H 10050 6500 50  0000 C CNN
F 1 "8255" H 10850 6500 50  0000 C CNN
F 2 "Package_DIP:DIP-40_W15.24mm_LongPads" H 10450 5300 50  0001 C CNN
F 3 "http://aturing.umcs.maine.edu/~meadow/courses/cos335/Intel8255A.pdf" H 10450 5300 50  0001 C CNN
	1    10450 5000
	1    0    0    -1  
$EndComp
$Comp
L Arduino:Arduino_Pro_Mini U6
U 1 1 61A254A8
P 12300 4800
F 0 "U6" H 12300 5689 60  0000 C CNN
F 1 "Arduino_Pro_Mini_5V" H 12300 5583 60  0000 C CNN
F 2 "Kicad:Arduino_Pro_Mini" H 13100 4050 60  0001 C CNN
F 3 "https://www.sparkfun.com/products/11113" H 12500 3600 60  0001 C CNN
	1    12300 4800
	1    0    0    -1  
$EndComp
Text Label 7750 1400 0    50   ~ 0
DB0
Text Label 7750 1500 0    50   ~ 0
DB1
Text Label 7750 1600 0    50   ~ 0
DB2
Text Label 7750 1700 0    50   ~ 0
DB3
Text Label 7750 1800 0    50   ~ 0
DB4
Text Label 7750 1900 0    50   ~ 0
DB5
Text Label 7750 2000 0    50   ~ 0
DB6
Text Label 7750 2100 0    50   ~ 0
DB7
$Comp
L Connector_Generic:Conn_01x06 J7
U 1 1 631763B9
P 14900 3500
F 0 "J7" H 14550 3050 50  0000 L CNN
F 1 "MicroSD Card Adapter" H 14300 2950 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x06_P2.54mm_Vertical" H 14900 3500 50  0001 C CNN
F 3 "~" H 14900 3500 50  0001 C CNN
	1    14900 3500
	1    0    0    -1  
$EndComp
Wire Wire Line
	14700 3300 14450 3300
Wire Wire Line
	14700 3400 14450 3400
Wire Wire Line
	14700 3500 14450 3500
Wire Wire Line
	14700 3600 14450 3600
Wire Wire Line
	14700 3700 14450 3700
Wire Wire Line
	14700 3800 14450 3800
Text Label 14450 3300 0    50   ~ 0
GND
Text Label 14450 3400 0    50   ~ 0
+5V
Text Label 14450 3500 0    50   ~ 0
MISO
Text Label 14450 3600 0    50   ~ 0
MOSI
Text Label 14450 3700 0    50   ~ 0
SCK
Text Label 14450 3800 0    50   ~ 0
CS
Text Label 12450 2300 0    50   ~ 0
SCK
Text Label 12550 2400 0    50   ~ 0
MISO
Text Label 12650 2500 0    50   ~ 0
MOSI
Text Label 12750 2600 0    50   ~ 0
CS
Wire Wire Line
	7550 2100 7750 2100
Wire Wire Line
	7550 2000 7750 2000
Wire Wire Line
	7550 1900 7750 1900
Wire Wire Line
	7550 1800 7750 1800
Wire Wire Line
	7550 1700 7750 1700
Wire Wire Line
	7550 1600 7750 1600
Wire Wire Line
	7550 1500 7750 1500
Wire Wire Line
	7550 1400 7750 1400
$Comp
L Memory_RAM2:GAL22V10 U1
U 1 1 676F5009
P 4100 3100
F 0 "U1" H 3850 3750 50  0000 C CNN
F 1 "GAL22V10" H 4400 3800 50  0000 C CNN
F 2 "Package_DIP:DIP-24_W7.62mm_LongPads" H 4100 3100 50  0001 C CNN
F 3 "" H 4100 3100 50  0001 C CNN
	1    4100 3100
	1    0    0    -1  
$EndComp
Wire Wire Line
	3400 3200 3600 3200
Wire Wire Line
	3400 3400 3600 3400
Wire Wire Line
	4800 3500 4600 3500
Wire Wire Line
	3400 3600 3600 3600
Wire Wire Line
	3400 2600 3600 2600
Wire Wire Line
	3400 2800 3600 2800
Wire Wire Line
	3400 3000 3600 3000
Text Label 4800 3500 2    50   ~ 0
A14
Text Label 3400 3600 0    50   ~ 0
A12
Text Label 3400 3400 0    50   ~ 0
A10
Text Label 3400 3200 0    50   ~ 0
A8
Text Label 3400 3000 0    50   ~ 0
A6
Text Label 3400 2800 0    50   ~ 0
A4
Text Label 3400 2600 0    50   ~ 0
CLOCK
Wire Wire Line
	3400 3300 3600 3300
Wire Wire Line
	3400 3500 3600 3500
Wire Wire Line
	4800 3600 4600 3600
Wire Wire Line
	4800 3400 4600 3400
Wire Wire Line
	3400 2700 3600 2700
Wire Wire Line
	3400 2900 3600 2900
Wire Wire Line
	3400 3100 3600 3100
Text Label 4800 3600 2    50   ~ 0
A15
Text Label 4800 3400 2    50   ~ 0
A13
Text Label 3400 3500 0    50   ~ 0
A11
Text Label 3400 3300 0    50   ~ 0
A9
Text Label 3400 3100 0    50   ~ 0
A7
Text Label 3400 2900 0    50   ~ 0
A5
Wire Wire Line
	4800 2700 4600 2700
Text Label 4800 2700 2    50   ~ 0
~RD
Wire Wire Line
	4800 2600 4600 2600
Text Label 4800 2600 2    50   ~ 0
~RESET
Text Label 4800 3000 2    50   ~ 0
JOY
Text Label 4800 3100 2    50   ~ 0
ROM
Text Label 4800 3200 2    50   ~ 0
RAM
Text Label 4800 3300 2    50   ~ 0
PIO
Wire Wire Line
	4800 2900 4600 2900
Text Label 4800 2900 2    50   ~ 0
~WE
$Comp
L 74xx:74LS366 U2
U 1 1 67922588
P 5900 8350
F 0 "U2" H 5650 8950 50  0000 C CNN
F 1 "74LS366" H 6100 8950 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm_LongPads" H 5900 8350 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS366" H 5900 8350 50  0001 C CNN
	1    5900 8350
	1    0    0    -1  
$EndComp
$Comp
L Connector:DB9_Male_MountingHoles J3
U 1 1 67923744
P 2700 8350
F 0 "J3" H 2618 9042 50  0000 C CNN
F 1 "MSX JOY STICK" H 2618 8951 50  0000 C CNN
F 2 "Connector_Dsub:DSUB-9_Male_Horizontal_P2.77x2.84mm_EdgePinOffset7.70mm_Housed_MountingHolesOffset9.12mm" H 2700 8350 50  0001 C CNN
F 3 " ~" H 2700 8350 50  0001 C CNN
	1    2700 8350
	-1   0    0    -1  
$EndComp
Wire Wire Line
	5100 8650 5250 8650
Wire Wire Line
	4600 3000 5100 3000
Wire Wire Line
	5400 8750 5250 8750
Wire Wire Line
	5250 8750 5250 8650
Connection ~ 5250 8650
Wire Wire Line
	5250 8650 5400 8650
Wire Wire Line
	6600 8150 6400 8150
Wire Wire Line
	6600 8350 6400 8350
Wire Wire Line
	6600 7950 6400 7950
Text Label 6600 7950 2    50   ~ 0
DB5
Text Label 6600 8350 2    50   ~ 0
DB3
Text Label 6600 8150 2    50   ~ 0
DB1
Wire Wire Line
	6600 8050 6400 8050
Wire Wire Line
	6600 8250 6400 8250
Wire Wire Line
	6600 8450 6400 8450
Text Label 6600 8450 2    50   ~ 0
DB4
Text Label 6600 8250 2    50   ~ 0
DB2
Text Label 6600 8050 2    50   ~ 0
DB0
Wire Wire Line
	5400 8250 5000 8250
Wire Wire Line
	5000 8250 5000 8750
Wire Wire Line
	5000 8750 4400 8750
Wire Wire Line
	5400 8350 4900 8350
Wire Wire Line
	4900 8350 4900 8550
Wire Wire Line
	4900 8550 4150 8550
Wire Wire Line
	5400 8450 3900 8450
Wire Wire Line
	3000 8650 3200 8650
Wire Wire Line
	3200 8650 3200 8450
Connection ~ 3200 8450
Wire Wire Line
	3200 8450 3000 8450
Wire Wire Line
	3000 8050 3100 8050
Wire Wire Line
	3100 8050 3100 8250
Wire Wire Line
	3000 8250 3100 8250
Connection ~ 3100 8250
NoConn ~ 2700 8950
$Comp
L power:+5V #PWR01
U 1 1 67B0F74A
P 3100 7450
F 0 "#PWR01" H 3100 7300 50  0001 C CNN
F 1 "+5V" H 3115 7623 50  0000 C CNN
F 2 "" H 3100 7450 50  0001 C CNN
F 3 "" H 3100 7450 50  0001 C CNN
	1    3100 7450
	1    0    0    -1  
$EndComp
Wire Wire Line
	3000 7950 3100 7950
Wire Wire Line
	3100 7950 3100 7550
$Comp
L Device:R R1
U 1 1 67B5FB11
P 3400 7800
F 0 "R1" H 3470 7846 50  0000 L CNN
F 1 "10k" H 3470 7755 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 3330 7800 50  0001 C CNN
F 3 "~" H 3400 7800 50  0001 C CNN
	1    3400 7800
	1    0    0    -1  
$EndComp
$Comp
L Device:R R2
U 1 1 67B8E5B1
P 3650 7800
F 0 "R2" H 3720 7846 50  0000 L CNN
F 1 "10k" H 3720 7755 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 3580 7800 50  0001 C CNN
F 3 "~" H 3650 7800 50  0001 C CNN
	1    3650 7800
	1    0    0    -1  
$EndComp
$Comp
L Device:R R3
U 1 1 67B9D138
P 3900 7800
F 0 "R3" H 3970 7846 50  0000 L CNN
F 1 "10k" H 3970 7755 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 3830 7800 50  0001 C CNN
F 3 "~" H 3900 7800 50  0001 C CNN
	1    3900 7800
	1    0    0    -1  
$EndComp
$Comp
L Device:R R4
U 1 1 67BABE28
P 4150 7800
F 0 "R4" H 4220 7846 50  0000 L CNN
F 1 "10k" H 4220 7755 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 4080 7800 50  0001 C CNN
F 3 "~" H 4150 7800 50  0001 C CNN
	1    4150 7800
	1    0    0    -1  
$EndComp
$Comp
L Device:R R5
U 1 1 67C16345
P 4400 7800
F 0 "R5" H 4470 7846 50  0000 L CNN
F 1 "10k" H 4470 7755 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 4330 7800 50  0001 C CNN
F 3 "~" H 4400 7800 50  0001 C CNN
	1    4400 7800
	1    0    0    -1  
$EndComp
Wire Wire Line
	3400 7950 3400 8150
Wire Wire Line
	3400 8150 3000 8150
Wire Wire Line
	3650 7950 3650 8350
Wire Wire Line
	3650 8350 3000 8350
Wire Wire Line
	3900 7950 3900 8450
Connection ~ 3900 8450
Wire Wire Line
	3900 8450 3200 8450
Wire Wire Line
	4150 7950 4150 8550
Connection ~ 4150 8550
Wire Wire Line
	4150 8550 3000 8550
Wire Wire Line
	4400 7950 4400 8750
Connection ~ 4400 8750
Wire Wire Line
	4400 8750 3000 8750
Wire Wire Line
	3100 7550 3400 7550
Wire Wire Line
	4400 7550 4400 7650
Connection ~ 3100 7550
Wire Wire Line
	3100 7550 3100 7450
Wire Wire Line
	4150 7650 4150 7550
Connection ~ 4150 7550
Wire Wire Line
	4150 7550 4400 7550
Wire Wire Line
	3900 7650 3900 7550
Connection ~ 3900 7550
Wire Wire Line
	3900 7550 4150 7550
Wire Wire Line
	3650 7650 3650 7550
Connection ~ 3650 7550
Wire Wire Line
	3650 7550 3900 7550
Wire Wire Line
	3400 7650 3400 7550
Connection ~ 3400 7550
Wire Wire Line
	3400 7550 3650 7550
Wire Wire Line
	4400 7550 4700 7550
Wire Wire Line
	4700 7550 4700 7950
Wire Wire Line
	4700 7950 5400 7950
Connection ~ 4400 7550
Wire Wire Line
	3100 8250 3100 9100
$Comp
L power:GND #PWR02
U 1 1 67AECFD9
P 3100 9100
F 0 "#PWR02" H 3100 8850 50  0001 C CNN
F 1 "GND" H 3105 8927 50  0000 C CNN
F 2 "" H 3100 9100 50  0001 C CNN
F 3 "" H 3100 9100 50  0001 C CNN
	1    3100 9100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR06
U 1 1 67D25B7E
P 5900 9150
F 0 "#PWR06" H 5900 8900 50  0001 C CNN
F 1 "GND" H 5905 8977 50  0000 C CNN
F 2 "" H 5900 9150 50  0001 C CNN
F 3 "" H 5900 9150 50  0001 C CNN
	1    5900 9150
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR05
U 1 1 67D39D1C
P 5900 7550
F 0 "#PWR05" H 5900 7400 50  0001 C CNN
F 1 "+5V" H 5915 7723 50  0000 C CNN
F 2 "" H 5900 7550 50  0001 C CNN
F 3 "" H 5900 7550 50  0001 C CNN
	1    5900 7550
	1    0    0    -1  
$EndComp
$Comp
L Device:C C4
U 1 1 67D8A7B0
P 6850 8450
F 0 "C4" V 6700 8550 50  0000 C CNN
F 1 "0.1uF" V 6700 8300 50  0000 C CNN
F 2 "Capacitor_THT:C_Rect_L4.0mm_W2.5mm_P2.50mm" H 6888 8300 50  0001 C CNN
F 3 "~" H 6850 8450 50  0001 C CNN
	1    6850 8450
	-1   0    0    1   
$EndComp
Wire Wire Line
	6850 8600 6850 9150
Wire Wire Line
	6850 9150 5900 9150
Wire Wire Line
	5900 9150 5900 9050
Wire Wire Line
	6850 8300 6850 7550
Wire Wire Line
	6850 7550 5900 7550
Wire Wire Line
	5900 7550 5900 7650
Connection ~ 5900 7550
Connection ~ 5900 9150
Wire Wire Line
	6500 2200 6750 2200
Wire Wire Line
	6500 2400 6750 2400
Wire Wire Line
	6500 1600 6750 1600
Wire Wire Line
	6500 1800 6750 1800
Wire Wire Line
	6500 2000 6750 2000
Text Label 6500 2400 0    50   ~ 0
A10
Text Label 6500 2200 0    50   ~ 0
A8
Text Label 6500 2000 0    50   ~ 0
A6
Text Label 6500 1800 0    50   ~ 0
A4
Text Label 6500 1600 0    50   ~ 0
A2
Wire Wire Line
	6500 2300 6750 2300
Wire Wire Line
	6500 2500 6750 2500
Wire Wire Line
	6500 1700 6750 1700
Wire Wire Line
	6500 1900 6750 1900
Wire Wire Line
	6500 2100 6750 2100
Text Label 6500 2500 0    50   ~ 0
A11
Text Label 6500 2300 0    50   ~ 0
A9
Text Label 6500 2100 0    50   ~ 0
A7
Text Label 6500 1900 0    50   ~ 0
A5
Text Label 6500 1700 0    50   ~ 0
A3
Wire Wire Line
	6500 1400 6750 1400
Text Label 6500 1400 0    50   ~ 0
A0
Wire Wire Line
	6500 1500 6750 1500
Text Label 6500 1500 0    50   ~ 0
A1
$Comp
L Memory_RAM:HM62256BLP U4
U 1 1 67F2F392
P 7200 5800
F 0 "U4" H 6900 6700 50  0000 C CNN
F 1 "62256" H 7500 6700 50  0000 C CNN
F 2 "Package_DIP:DIP-28_W15.24mm_LongPads" H 7200 5700 50  0001 C CNN
F 3 "https://web.mit.edu/6.115/www/document/62256.pdf" H 7200 5700 50  0001 C CNN
	1    7200 5800
	1    0    0    -1  
$EndComp
Wire Wire Line
	7700 5800 7900 5800
Wire Wire Line
	7700 5700 7900 5700
Wire Wire Line
	7700 5600 7900 5600
Wire Wire Line
	7700 5500 7900 5500
Wire Wire Line
	7700 5400 7900 5400
Wire Wire Line
	7700 5300 7900 5300
Wire Wire Line
	7700 5200 7900 5200
Wire Wire Line
	7700 5100 7900 5100
Wire Wire Line
	6350 5900 6700 5900
Wire Wire Line
	6350 6100 6700 6100
Wire Wire Line
	6350 6300 6700 6300
Wire Wire Line
	6350 5300 6700 5300
Wire Wire Line
	6350 5500 6700 5500
Wire Wire Line
	6350 5700 6700 5700
Text Label 6350 6300 0    50   ~ 0
A12
Text Label 6350 6100 0    50   ~ 0
A10
Text Label 6350 5900 0    50   ~ 0
A8
Text Label 6350 5700 0    50   ~ 0
A6
Text Label 6350 5500 0    50   ~ 0
A4
Text Label 6350 5300 0    50   ~ 0
A2
Wire Wire Line
	6350 6000 6700 6000
Wire Wire Line
	6350 6200 6700 6200
Wire Wire Line
	6350 5400 6700 5400
Wire Wire Line
	6350 5600 6700 5600
Wire Wire Line
	6350 5800 6700 5800
Text Label 6350 6200 0    50   ~ 0
A11
Text Label 6350 6000 0    50   ~ 0
A9
Text Label 6350 5800 0    50   ~ 0
A7
Text Label 6350 5600 0    50   ~ 0
A5
Text Label 6350 5400 0    50   ~ 0
A3
Wire Wire Line
	6350 5100 6700 5100
Text Label 6350 5100 0    50   ~ 0
A0
Wire Wire Line
	6350 5200 6700 5200
Text Label 6350 5200 0    50   ~ 0
A1
Wire Wire Line
	6350 6400 6700 6400
Text Label 6350 6400 0    50   ~ 0
A13
Wire Wire Line
	6350 6750 5900 6750
Connection ~ 7200 6750
Wire Wire Line
	7200 6700 7200 6750
Wire Wire Line
	7200 6750 7200 6800
Wire Wire Line
	6650 6750 6700 6750
$Comp
L power:GND #PWR010
U 1 1 67FBF25D
P 7200 6800
F 0 "#PWR010" H 7200 6550 50  0001 C CNN
F 1 "GND" H 7205 6627 50  0000 C CNN
F 2 "" H 7200 6800 50  0001 C CNN
F 3 "" H 7200 6800 50  0001 C CNN
	1    7200 6800
	1    0    0    -1  
$EndComp
$Comp
L Device:C C3
U 1 1 67FBF263
P 6500 6750
F 0 "C3" V 6350 6850 50  0000 C CNN
F 1 "0.1uF" V 6350 6600 50  0000 C CNN
F 2 "Capacitor_THT:C_Rect_L4.0mm_W2.5mm_P2.50mm" H 6538 6600 50  0001 C CNN
F 3 "~" H 6500 6750 50  0001 C CNN
	1    6500 6750
	0    -1   -1   0   
$EndComp
Wire Wire Line
	6700 6500 6700 6750
Connection ~ 6700 6750
Wire Wire Line
	6700 6750 7200 6750
Wire Wire Line
	5900 6750 5900 4800
Wire Wire Line
	5900 4800 7200 4800
Wire Wire Line
	7200 4800 7200 4900
Wire Wire Line
	4800 2800 4600 2800
Text Label 4800 2800 2    50   ~ 0
RESET
Text Label 7900 5800 0    50   ~ 0
DB7
Text Label 7900 5700 0    50   ~ 0
DB6
Text Label 7900 5600 0    50   ~ 0
DB5
Text Label 7900 5500 0    50   ~ 0
DB4
Text Label 7900 5400 0    50   ~ 0
DB3
Text Label 7900 5300 0    50   ~ 0
DB2
Text Label 7900 5200 0    50   ~ 0
DB1
Text Label 7900 5100 0    50   ~ 0
DB0
Wire Wire Line
	7700 6300 7900 6300
Text Label 7900 6300 0    50   ~ 0
~WE
Wire Wire Line
	5900 4700 8250 4700
Wire Wire Line
	8250 4700 8250 6000
Wire Wire Line
	8250 6000 7700 6000
Wire Wire Line
	6000 4000 9750 4000
Wire Wire Line
	9750 3700 9250 3700
Text Label 9450 3700 2    50   ~ 0
RESET
Wire Wire Line
	9750 4100 9250 4100
Text Label 9450 4100 2    50   ~ 0
~RD
Wire Wire Line
	9750 4200 9250 4200
Text Label 9450 4200 2    50   ~ 0
~WE
Wire Wire Line
	9400 4500 9750 4500
Text Label 9400 4500 0    50   ~ 0
A0
Wire Wire Line
	9400 4600 9750 4600
Text Label 9400 4600 0    50   ~ 0
A1
Wire Wire Line
	9750 5600 9550 5600
Wire Wire Line
	9750 5500 9550 5500
Wire Wire Line
	9750 5400 9550 5400
Wire Wire Line
	9750 5300 9550 5300
Wire Wire Line
	9750 5200 9550 5200
Wire Wire Line
	9750 5100 9550 5100
Wire Wire Line
	9750 5000 9550 5000
Wire Wire Line
	9750 4900 9550 4900
Text Label 9550 5600 2    50   ~ 0
DB7
Text Label 9550 5500 2    50   ~ 0
DB6
Text Label 9550 5400 2    50   ~ 0
DB5
Text Label 9550 5300 2    50   ~ 0
DB4
Text Label 9550 5200 2    50   ~ 0
DB3
Text Label 9550 5100 2    50   ~ 0
DB2
Text Label 9550 5000 2    50   ~ 0
DB1
Text Label 9550 4900 2    50   ~ 0
DB0
Text Label 9450 3000 2    50   ~ 0
~RESET
Wire Wire Line
	7700 6200 7800 6200
Wire Wire Line
	7800 6200 7800 6750
Wire Wire Line
	7800 6750 7200 6750
Wire Wire Line
	6250 2900 6250 2800
Connection ~ 6250 2900
Wire Wire Line
	6750 2900 6250 2900
Wire Wire Line
	6250 2800 6250 1200
Connection ~ 6250 2800
Wire Wire Line
	6750 2800 6250 2800
Wire Wire Line
	6250 3350 6250 2900
$Comp
L power:GND #PWR04
U 1 1 6853010B
P 4100 3950
F 0 "#PWR04" H 4100 3700 50  0001 C CNN
F 1 "GND" H 4105 3777 50  0000 C CNN
F 2 "" H 4100 3950 50  0001 C CNN
F 3 "" H 4100 3950 50  0001 C CNN
	1    4100 3950
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR03
U 1 1 6855055F
P 4100 2250
F 0 "#PWR03" H 4100 2100 50  0001 C CNN
F 1 "+5V" H 4115 2423 50  0000 C CNN
F 2 "" H 4100 2250 50  0001 C CNN
F 3 "" H 4100 2250 50  0001 C CNN
	1    4100 2250
	1    0    0    -1  
$EndComp
$Comp
L power:PWR_FLAG #FLG02
U 1 1 6856ECD2
P 10750 2100
F 0 "#FLG02" H 10750 2175 50  0001 C CNN
F 1 "PWR_FLAG" H 10750 2273 50  0000 C CNN
F 2 "" H 10750 2100 50  0001 C CNN
F 3 "~" H 10750 2100 50  0001 C CNN
	1    10750 2100
	1    0    0    -1  
$EndComp
$Comp
L power:PWR_FLAG #FLG01
U 1 1 6856F3DE
P 10300 2600
F 0 "#FLG01" H 10300 2675 50  0001 C CNN
F 1 "PWR_FLAG" H 10300 2773 50  0000 C CNN
F 2 "" H 10300 2600 50  0001 C CNN
F 3 "~" H 10300 2600 50  0001 C CNN
	1    10300 2600
	1    0    0    -1  
$EndComp
Wire Wire Line
	10750 2100 10750 2200
Wire Wire Line
	10750 2200 11050 2200
Wire Wire Line
	10300 2600 10300 2650
Wire Wire Line
	10300 2650 10650 2650
Wire Wire Line
	4100 3950 4100 3850
$Comp
L power:+5V #PWR09
U 1 1 686139D2
P 7200 4550
F 0 "#PWR09" H 7200 4400 50  0001 C CNN
F 1 "+5V" H 7215 4723 50  0000 C CNN
F 2 "" H 7200 4550 50  0001 C CNN
F 3 "" H 7200 4550 50  0001 C CNN
	1    7200 4550
	1    0    0    -1  
$EndComp
Wire Wire Line
	7200 4800 7200 4550
Connection ~ 7200 4800
Wire Wire Line
	6000 3300 6000 4000
Wire Wire Line
	4600 3300 6000 3300
Wire Wire Line
	5900 3200 5900 4700
Wire Wire Line
	4600 3200 5900 3200
Wire Wire Line
	5100 3000 5100 8650
NoConn ~ 1350 3000
NoConn ~ 2500 3000
NoConn ~ 2500 2800
$Comp
L Connector_Generic:Conn_01x25 J2
U 1 1 674F6B91
P 2300 2400
F 0 "J2" H 2250 950 50  0000 L CNN
F 1 "Conn_01x25" H 2100 1050 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x25_P2.54mm_Vertical" H 2300 2400 50  0001 C CNN
F 3 "~" H 2300 2400 50  0001 C CNN
	1    2300 2400
	-1   0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x25 J1
U 1 1 62A95900
P 1550 2400
F 0 "J1" H 1500 950 50  0000 L CNN
F 1 "Conn_01x25" H 1350 1050 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x25_P2.54mm_Vertical" H 1550 2400 50  0001 C CNN
F 3 "~" H 1550 2400 50  0001 C CNN
	1    1550 2400
	1    0    0    -1  
$EndComp
NoConn ~ 2700 3400
NoConn ~ 2700 3200
NoConn ~ 2700 2700
NoConn ~ 2700 2600
NoConn ~ 2700 2500
Wire Wire Line
	2700 3600 2500 3600
Text Label 2700 3600 2    50   ~ 0
GND
Wire Wire Line
	2700 3500 2500 3500
Text Label 2700 3500 2    50   ~ 0
~RESET
Wire Wire Line
	2700 3400 2500 3400
Text Label 2700 3400 2    50   ~ 0
~NMI
Wire Wire Line
	2700 3300 2500 3300
Text Label 2700 3300 2    50   ~ 0
BKILL
Text Label 2700 1200 2    50   ~ 0
GND
Text Label 2700 1300 2    50   ~ 0
DB1
Text Label 2700 1400 2    50   ~ 0
DB3
Text Label 2700 1500 2    50   ~ 0
DB5
Text Label 2700 1600 2    50   ~ 0
DB7
Text Label 2700 1700 2    50   ~ 0
A1
Text Label 2700 1800 2    50   ~ 0
A3
Text Label 2700 1900 2    50   ~ 0
A5
Text Label 2700 2000 2    50   ~ 0
A7
Text Label 2700 2100 2    50   ~ 0
A9
Text Label 2700 2200 2    50   ~ 0
A11
Text Label 2700 2300 2    50   ~ 0
A13
Text Label 2700 2400 2    50   ~ 0
A15
Text Label 2700 2500 2    50   ~ 0
EA1
Text Label 2700 2600 2    50   ~ 0
EA3
Text Label 2700 2700 2    50   ~ 0
EA5
Text Label 2700 2900 2    50   ~ 0
GND
Text Label 2700 3100 2    50   ~ 0
GND
Text Label 2700 3200 2    50   ~ 0
BA
Wire Wire Line
	2700 2000 2500 2000
Wire Wire Line
	2700 1900 2500 1900
Wire Wire Line
	2700 1800 2500 1800
Wire Wire Line
	2700 1700 2500 1700
Wire Wire Line
	2700 1600 2500 1600
Wire Wire Line
	2700 1500 2500 1500
Wire Wire Line
	2700 1400 2500 1400
Wire Wire Line
	2700 1300 2500 1300
Wire Wire Line
	2700 2300 2500 2300
Wire Wire Line
	2700 2400 2500 2400
Wire Wire Line
	2700 2500 2500 2500
Wire Wire Line
	2700 2600 2500 2600
Wire Wire Line
	2700 2700 2500 2700
Wire Wire Line
	2700 2900 2500 2900
Wire Wire Line
	2700 3200 2500 3200
Wire Wire Line
	2700 3100 2500 3100
Wire Wire Line
	2700 1200 2500 1200
Wire Wire Line
	2700 2200 2500 2200
Wire Wire Line
	2700 2100 2500 2100
NoConn ~ 1150 3400
NoConn ~ 1150 3300
NoConn ~ 1150 2900
NoConn ~ 1150 2800
NoConn ~ 1150 2700
NoConn ~ 1150 2600
NoConn ~ 1150 2500
Wire Wire Line
	1150 3100 1350 3100
Wire Wire Line
	1150 2900 1350 2900
Text Label 1150 2900 0    50   ~ 0
~RAS
Wire Wire Line
	1150 3600 1350 3600
Text Label 1150 3600 0    50   ~ 0
GND
Wire Wire Line
	1150 3500 1350 3500
Text Label 1150 3500 0    50   ~ 0
CLOCK
Wire Wire Line
	1150 3400 1350 3400
Text Label 1150 3400 0    50   ~ 0
~IRQ
Text Label 1150 1200 0    50   ~ 0
GND
Text Label 1150 1300 0    50   ~ 0
DB0
Text Label 1150 1400 0    50   ~ 0
DB2
Text Label 1150 1500 0    50   ~ 0
DB4
Text Label 1150 1600 0    50   ~ 0
DB6
Text Label 1150 1700 0    50   ~ 0
A0
Text Label 1150 1800 0    50   ~ 0
A2
Text Label 1150 1900 0    50   ~ 0
A4
Text Label 1150 2000 0    50   ~ 0
A6
Text Label 1150 2100 0    50   ~ 0
A8
Text Label 1150 2200 0    50   ~ 0
A10
Text Label 1150 2300 0    50   ~ 0
A12
Text Label 1150 2400 0    50   ~ 0
A14
Text Label 1150 2500 0    50   ~ 0
EA0
Text Label 1150 2600 0    50   ~ 0
EA2
Text Label 1150 2700 0    50   ~ 0
EA4
Text Label 1150 2800 0    50   ~ 0
EA6
Text Label 1150 3100 0    50   ~ 0
GND
Text Label 1150 3200 0    50   ~ 0
~RD
Text Label 1150 3300 0    50   ~ 0
~HALT
Wire Wire Line
	1150 2000 1350 2000
Wire Wire Line
	1150 1900 1350 1900
Wire Wire Line
	1150 1800 1350 1800
Wire Wire Line
	1150 1700 1350 1700
Wire Wire Line
	1150 1600 1350 1600
Wire Wire Line
	1150 1500 1350 1500
Wire Wire Line
	1150 1400 1350 1400
Wire Wire Line
	1150 1300 1350 1300
Wire Wire Line
	1150 2300 1350 2300
Wire Wire Line
	1150 2400 1350 2400
Wire Wire Line
	1150 2500 1350 2500
Wire Wire Line
	1150 2600 1350 2600
Wire Wire Line
	1150 2700 1350 2700
Wire Wire Line
	1150 2800 1350 2800
Wire Wire Line
	1150 3300 1350 3300
Wire Wire Line
	1150 3200 1350 3200
Wire Wire Line
	1150 1200 1350 1200
Wire Wire Line
	1150 2200 1350 2200
Wire Wire Line
	1150 2100 1350 2100
Wire Wire Line
	4600 3100 6750 3100
Wire Wire Line
	6750 3000 6700 3000
Wire Wire Line
	6700 3000 6700 3350
Wire Wire Line
	6550 3350 6700 3350
Wire Wire Line
	6700 3350 7150 3350
Connection ~ 6700 3350
$Comp
L Connector:Jack-DC J5
U 1 1 6749FA9C
P 9000 1300
F 0 "J5" H 9057 1625 50  0000 C CNN
F 1 "EXT 5V" H 9057 1534 50  0000 C CNN
F 2 "Connector_BarrelJack:BarrelJack_Horizontal" H 9050 1260 50  0001 C CNN
F 3 "~" H 9050 1260 50  0001 C CNN
	1    9000 1300
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x02 J4
U 1 1 674A08E0
P 8850 2100
F 0 "J4" H 8768 2317 50  0000 C CNN
F 1 "IN 5V" H 8768 2226 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Horizontal" H 8850 2100 50  0001 C CNN
F 3 "~" H 8850 2100 50  0001 C CNN
	1    8850 2100
	-1   0    0    -1  
$EndComp
$Comp
L Memory_RAM2:SLIDE_SWITCH_3P S1
U 1 1 674C60E2
P 9900 1900
F 0 "S1" H 9900 1965 50  0000 C CNN
F 1 "IN/EXT" H 9900 1874 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical" H 9900 1925 50  0001 C CNN
F 3 "" H 9900 1925 50  0001 C CNN
	1    9900 1900
	1    0    0    -1  
$EndComp
$Comp
L Device:CP C6
U 1 1 674C7485
P 10650 2500
F 0 "C6" H 10768 2546 50  0000 L CNN
F 1 "100uF" H 10768 2455 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D5.0mm_P2.50mm" H 10688 2350 50  0001 C CNN
F 3 "~" H 10650 2500 50  0001 C CNN
	1    10650 2500
	1    0    0    -1  
$EndComp
Wire Wire Line
	9300 1200 10500 1200
Wire Wire Line
	10500 1200 10500 2100
Wire Wire Line
	10500 2100 10100 2100
Wire Wire Line
	9050 2100 9700 2100
Wire Wire Line
	9900 2250 9900 2350
Wire Wire Line
	9900 2350 10650 2350
Wire Wire Line
	9300 1400 9400 1400
Wire Wire Line
	9400 1400 9400 1500
$Comp
L power:+5V #PWR015
U 1 1 6756069B
P 11050 2100
F 0 "#PWR015" H 11050 1950 50  0001 C CNN
F 1 "+5V" H 11065 2273 50  0000 C CNN
F 2 "" H 11050 2100 50  0001 C CNN
F 3 "" H 11050 2100 50  0001 C CNN
	1    11050 2100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR011
U 1 1 67588F78
P 9400 1500
F 0 "#PWR011" H 9400 1250 50  0001 C CNN
F 1 "GND" H 9405 1327 50  0000 C CNN
F 2 "" H 9400 1500 50  0001 C CNN
F 3 "" H 9400 1500 50  0001 C CNN
	1    9400 1500
	1    0    0    -1  
$EndComp
NoConn ~ 9050 2200
$Comp
L power:GND #PWR014
U 1 1 675D47C9
P 10650 2650
F 0 "#PWR014" H 10650 2400 50  0001 C CNN
F 1 "GND" H 10655 2477 50  0000 C CNN
F 2 "" H 10650 2650 50  0001 C CNN
F 3 "" H 10650 2650 50  0001 C CNN
	1    10650 2650
	1    0    0    -1  
$EndComp
Wire Wire Line
	10650 2350 11050 2350
Wire Wire Line
	11050 2350 11050 2200
Connection ~ 10650 2350
Connection ~ 11050 2200
Wire Wire Line
	11050 2200 11050 2100
Wire Wire Line
	4100 2250 4100 2350
Connection ~ 10650 2650
$Comp
L Device:C C1
U 1 1 6769F5FA
P 3500 3850
F 0 "C1" V 3350 3950 50  0000 C CNN
F 1 "0.1uF" V 3350 3700 50  0000 C CNN
F 2 "Capacitor_THT:C_Rect_L4.0mm_W2.5mm_P2.50mm" H 3538 3700 50  0001 C CNN
F 3 "~" H 3500 3850 50  0001 C CNN
	1    3500 3850
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3650 3850 4100 3850
Connection ~ 4100 3850
Wire Wire Line
	4100 3850 4100 3800
Wire Wire Line
	3350 3850 3150 3850
Wire Wire Line
	3150 3850 3150 2350
Wire Wire Line
	3150 2350 4100 2350
Connection ~ 4100 2350
Wire Wire Line
	4100 2350 4100 2400
Wire Wire Line
	3650 8350 4700 8350
Connection ~ 3650 8350
Text Label 3400 2700 0    50   ~ 0
BKILL
$Comp
L Switch:SW_Push SW1
U 1 1 6761A971
P 3400 5400
F 0 "SW1" H 3400 5685 50  0000 C CNN
F 1 "SW_Push" H 3400 5594 50  0000 C CNN
F 2 "Button_Switch_THT:SW_PUSH_6mm_H4.3mm" H 3400 5600 50  0001 C CNN
F 3 "~" H 3400 5600 50  0001 C CNN
	1    3400 5400
	1    0    0    -1  
$EndComp
Wire Wire Line
	3600 5400 3850 5400
Wire Wire Line
	3850 5400 3850 5600
$Comp
L power:GND #PWR020
U 1 1 67646642
P 3850 5600
F 0 "#PWR020" H 3850 5350 50  0001 C CNN
F 1 "GND" H 3855 5427 50  0000 C CNN
F 2 "" H 3850 5600 50  0001 C CNN
F 3 "" H 3850 5600 50  0001 C CNN
	1    3850 5600
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x01 J8
U 1 1 6766DB94
P 3000 5400
F 0 "J8" H 3080 5442 50  0000 L CNN
F 1 "Conn_01x01" H 3080 5351 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x01_P2.54mm_Horizontal" H 3000 5400 50  0001 C CNN
F 3 "~" H 3000 5400 50  0001 C CNN
	1    3000 5400
	-1   0    0    -1  
$EndComp
Wire Wire Line
	4700 8350 4700 8150
Wire Wire Line
	4700 8150 5400 8150
Wire Wire Line
	3400 8150 4600 8150
Wire Wire Line
	4600 8150 4600 8050
Wire Wire Line
	4600 8050 5400 8050
Connection ~ 3400 8150
Wire Wire Line
	6750 2600 6700 2600
Wire Wire Line
	6700 2600 6700 3000
Connection ~ 6700 3000
$EndSCHEMATC
