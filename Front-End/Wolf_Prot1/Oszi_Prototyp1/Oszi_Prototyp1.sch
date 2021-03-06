EESchema Schematic File Version 4
LIBS:Oszi_Prototyp1-cache
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Connector_Generic:Conn_02x20_Odd_Even J4
U 1 1 604A458E
P 6075 1350
F 0 "J4" V 6171 2330 50  0000 L CNN
F 1 "FPGA_GPIO" V 6080 2330 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_2x20_P2.54mm_Vertical" H 6075 1350 50  0001 C CNN
F 3 "~" H 6075 1350 50  0001 C CNN
	1    6075 1350
	0    -1   -1   0   
$EndComp
$Comp
L Oszi_Prototyp1-rescue:LTC1420CGN#PBF-FPGA_Oszi IC1
U 1 1 604A0201
P 6650 2600
F 0 "IC1" H 7350 2865 50  0000 C CNN
F 1 "LTC1420CGN#PBF" H 7350 2774 50  0000 C CNN
F 2 "SamacSys_Parts:SOP64P601X175-28N" H 7900 2700 50  0001 L CNN
F 3 "http://cds.linear.com/docs/en/datasheet/1420fa.pdf" H 7900 2600 50  0001 L CNN
F 4 "12Bit 10Msps Analog to Digital Converter Linear Technology LTC1420CGN#PBF, 12 bit Parallel ADC, Differential Input, 28-Pin SSOP" H 7900 2500 50  0001 L CNN "Description"
F 5 "1.748" H 7900 2400 50  0001 L CNN "Height"
F 6 "Linear Technology" H 7900 2300 50  0001 L CNN "Manufacturer_Name"
F 7 "LTC1420CGN#PBF" H 7900 2200 50  0001 L CNN "Manufacturer_Part_Number"
F 8 "584-LTC1420CGN#PBF" H 7900 2100 50  0001 L CNN "Mouser Part Number"
F 9 "https://www.mouser.com/Search/Refine.aspx?Keyword=584-LTC1420CGN%23PBF" H 7900 2000 50  0001 L CNN "Mouser Price/Stock"
F 10 "LTC1420CGN#PBF" H 7900 1900 50  0001 L CNN "Arrow Part Number"
F 11 "https://www.arrow.com/en/products/ltc1420cgnpbf/linear-technology" H 7900 1800 50  0001 L CNN "Arrow Price/Stock"
	1    6650 2600
	1    0    0    -1  
$EndComp
Wire Wire Line
	8050 2600 8350 2600
Wire Wire Line
	8350 2600 8350 2450
$Comp
L power:+5V #PWR0101
U 1 1 604A2382
P 8350 2450
F 0 "#PWR0101" H 8350 2300 50  0001 C CNN
F 1 "+5V" H 8365 2623 50  0000 C CNN
F 2 "" H 8350 2450 50  0001 C CNN
F 3 "" H 8350 2450 50  0001 C CNN
	1    8350 2450
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0102
U 1 1 604A27BE
P 5575 2100
F 0 "#PWR0102" H 5575 1950 50  0001 C CNN
F 1 "+5V" H 5590 2273 50  0000 C CNN
F 2 "" H 5575 2100 50  0001 C CNN
F 3 "" H 5575 2100 50  0001 C CNN
	1    5575 2100
	1    0    0    -1  
$EndComp
Wire Wire Line
	8050 3100 8350 3100
Wire Wire Line
	8350 3100 8350 2600
Connection ~ 8350 2600
$Comp
L Device:C C2
U 1 1 604A387E
P 8600 1200
F 0 "C2" H 8715 1246 50  0000 L CNN
F 1 "1uF" H 8715 1155 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric_Pad1.42x1.75mm_HandSolder" H 8638 1050 50  0001 C CNN
F 3 "~" H 8600 1200 50  0001 C CNN
	1    8600 1200
	1    0    0    -1  
$EndComp
$Comp
L Device:C C3
U 1 1 604A41B4
P 5550 3300
F 0 "C3" H 5665 3346 50  0000 L CNN
F 1 "1uF" H 5665 3255 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric_Pad1.42x1.75mm_HandSolder" H 5588 3150 50  0001 C CNN
F 3 "~" H 5550 3300 50  0001 C CNN
	1    5550 3300
	1    0    0    -1  
$EndComp
$Comp
L Device:C C1
U 1 1 604A47B5
P 8100 1200
F 0 "C1" H 8215 1246 50  0000 L CNN
F 1 "1uF" H 8215 1155 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric_Pad1.42x1.75mm_HandSolder" H 8138 1050 50  0001 C CNN
F 3 "~" H 8100 1200 50  0001 C CNN
	1    8100 1200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0103
U 1 1 604A60A4
P 7850 1500
F 0 "#PWR0103" H 7850 1250 50  0001 C CNN
F 1 "GND" H 7855 1327 50  0000 C CNN
F 2 "" H 7850 1500 50  0001 C CNN
F 3 "" H 7850 1500 50  0001 C CNN
	1    7850 1500
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0104
U 1 1 604A67C3
P 7850 900
F 0 "#PWR0104" H 7850 750 50  0001 C CNN
F 1 "+5V" H 7865 1073 50  0000 C CNN
F 2 "" H 7850 900 50  0001 C CNN
F 3 "" H 7850 900 50  0001 C CNN
	1    7850 900 
	1    0    0    -1  
$EndComp
Wire Wire Line
	7850 900  7850 950 
Wire Wire Line
	7850 950  8100 950 
Wire Wire Line
	8600 1050 8600 950 
Wire Wire Line
	8100 1050 8100 950 
Connection ~ 8100 950 
Wire Wire Line
	8100 950  8600 950 
Wire Wire Line
	7850 1500 7850 1450
Wire Wire Line
	7850 1450 8100 1450
Wire Wire Line
	8600 1350 8600 1450
Wire Wire Line
	8100 1350 8100 1450
Connection ~ 8100 1450
Wire Wire Line
	8100 1450 8600 1450
Text Notes 8050 1650 0    50   ~ 0
place near\nVDD pin 7
Text Notes 9550 2600 0    50   ~ 0
place near\nOVDD
$Comp
L power:GND #PWR0105
U 1 1 604AA25D
P 8600 3400
F 0 "#PWR0105" H 8600 3150 50  0001 C CNN
F 1 "GND" H 8605 3227 50  0000 C CNN
F 2 "" H 8600 3400 50  0001 C CNN
F 3 "" H 8600 3400 50  0001 C CNN
	1    8600 3400
	1    0    0    -1  
$EndComp
Wire Wire Line
	8600 3400 8600 3300
Wire Wire Line
	8600 3300 8050 3300
Wire Wire Line
	8050 2900 8600 2900
Wire Wire Line
	8600 2900 8600 3000
Connection ~ 8600 3300
Wire Wire Line
	8050 3000 8600 3000
Connection ~ 8600 3000
Wire Wire Line
	8600 3000 8600 3300
$Comp
L power:+3V3 #PWR0106
U 1 1 604ABDF5
P 8850 2450
F 0 "#PWR0106" H 8850 2300 50  0001 C CNN
F 1 "+3V3" H 8865 2623 50  0000 C CNN
F 2 "" H 8850 2450 50  0001 C CNN
F 3 "" H 8850 2450 50  0001 C CNN
	1    8850 2450
	1    0    0    -1  
$EndComp
Wire Wire Line
	8850 2450 8850 3200
Wire Wire Line
	8850 3200 8050 3200
$Comp
L power:+3V3 #PWR0107
U 1 1 604ADD6C
P 6475 2100
F 0 "#PWR0107" H 6475 1950 50  0001 C CNN
F 1 "+3V3" H 6490 2273 50  0000 C CNN
F 2 "" H 6475 2100 50  0001 C CNN
F 3 "" H 6475 2100 50  0001 C CNN
	1    6475 2100
	1    0    0    -1  
$EndComp
$Comp
L Device:C C4
U 1 1 604AF94A
P 9450 2250
F 0 "C4" H 9565 2296 50  0000 L CNN
F 1 "1uF" H 9565 2205 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric_Pad1.42x1.75mm_HandSolder" H 9488 2100 50  0001 C CNN
F 3 "~" H 9450 2250 50  0001 C CNN
	1    9450 2250
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR0108
U 1 1 604B06F8
P 9150 1950
F 0 "#PWR0108" H 9150 1800 50  0001 C CNN
F 1 "+3V3" H 9165 2123 50  0000 C CNN
F 2 "" H 9150 1950 50  0001 C CNN
F 3 "" H 9150 1950 50  0001 C CNN
	1    9150 1950
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0109
U 1 1 604B0EDD
P 9150 2550
F 0 "#PWR0109" H 9150 2300 50  0001 C CNN
F 1 "GND" H 9155 2377 50  0000 C CNN
F 2 "" H 9150 2550 50  0001 C CNN
F 3 "" H 9150 2550 50  0001 C CNN
	1    9150 2550
	1    0    0    -1  
$EndComp
Wire Wire Line
	9150 2550 9150 2500
Wire Wire Line
	9150 2500 9450 2500
Wire Wire Line
	9450 2500 9450 2400
Wire Wire Line
	9150 1950 9150 2000
Wire Wire Line
	9150 2000 9450 2000
Wire Wire Line
	9450 2000 9450 2100
Text Notes 8550 1650 0    50   ~ 0
place near\nVDD pin 23\n
$Comp
L power:+5V #PWR0110
U 1 1 604B73B7
P 6250 2450
F 0 "#PWR0110" H 6250 2300 50  0001 C CNN
F 1 "+5V" H 6265 2623 50  0000 C CNN
F 2 "" H 6250 2450 50  0001 C CNN
F 3 "" H 6250 2450 50  0001 C CNN
	1    6250 2450
	1    0    0    -1  
$EndComp
Wire Wire Line
	6650 3200 6250 3200
$Comp
L power:GND #PWR0111
U 1 1 604BA90E
P 6310 3950
F 0 "#PWR0111" H 6310 3700 50  0001 C CNN
F 1 "GND" H 6315 3777 50  0000 C CNN
F 2 "" H 6310 3950 50  0001 C CNN
F 3 "" H 6310 3950 50  0001 C CNN
	1    6310 3950
	1    0    0    -1  
$EndComp
Connection ~ 6310 3100
Wire Wire Line
	6310 3100 6310 3300
Wire Wire Line
	6310 3300 6310 3950
$Comp
L Device:C C5
U 1 1 604BE33A
P 5950 3300
F 0 "C5" H 6065 3346 50  0000 L CNN
F 1 "1uF" H 6065 3255 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric_Pad1.42x1.75mm_HandSolder" H 5988 3150 50  0001 C CNN
F 3 "~" H 5950 3300 50  0001 C CNN
	1    5950 3300
	1    0    0    -1  
$EndComp
Wire Wire Line
	6650 3000 5950 3000
Wire Wire Line
	5950 3000 5950 3150
$Comp
L power:GND #PWR0112
U 1 1 604BFBF7
P 5950 3950
F 0 "#PWR0112" H 5950 3700 50  0001 C CNN
F 1 "GND" H 5955 3777 50  0000 C CNN
F 2 "" H 5950 3950 50  0001 C CNN
F 3 "" H 5950 3950 50  0001 C CNN
	1    5950 3950
	1    0    0    -1  
$EndComp
Wire Wire Line
	5950 3950 5950 3450
Text Notes 5325 3500 0    50   ~ 0
place near\nVCM\n
$Comp
L Device:R R1
U 1 1 604C7B97
P 5900 2600
F 0 "R1" V 5693 2600 50  0000 C CNN
F 1 "30k" V 5784 2600 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 5830 2600 50  0001 C CNN
F 3 "~" H 5900 2600 50  0001 C CNN
	1    5900 2600
	0    1    1    0   
$EndComp
Wire Wire Line
	6650 2600 6050 2600
$Comp
L power:GND #PWR0113
U 1 1 604CA2F6
P 5200 3950
F 0 "#PWR0113" H 5200 3700 50  0001 C CNN
F 1 "GND" H 5205 3777 50  0000 C CNN
F 2 "" H 5200 3950 50  0001 C CNN
F 3 "" H 5200 3950 50  0001 C CNN
	1    5200 3950
	1    0    0    -1  
$EndComp
Wire Wire Line
	5200 3950 5200 2700
Wire Wire Line
	5200 2700 5150 2700
$Comp
L power:GND #PWR0114
U 1 1 604CBD9F
P 5525 750
F 0 "#PWR0114" H 5525 500 50  0001 C CNN
F 1 "GND" H 5530 577 50  0000 C CNN
F 2 "" H 5525 750 50  0001 C CNN
F 3 "" H 5525 750 50  0001 C CNN
	1    5525 750 
	1    0    0    -1  
$EndComp
Wire Wire Line
	5525 600  5675 600 
Wire Wire Line
	5675 600  5675 1050
Wire Wire Line
	5525 600  5525 750 
$Comp
L power:GND #PWR0115
U 1 1 604CF40F
P 6425 750
F 0 "#PWR0115" H 6425 500 50  0001 C CNN
F 1 "GND" H 6430 577 50  0000 C CNN
F 2 "" H 6425 750 50  0001 C CNN
F 3 "" H 6425 750 50  0001 C CNN
	1    6425 750 
	1    0    0    -1  
$EndComp
Wire Wire Line
	6425 600  6575 600 
Wire Wire Line
	6575 600  6575 1050
Wire Wire Line
	6425 600  6425 750 
Text GLabel 8200 3400 2    50   Input ~ 0
D0
Text GLabel 8200 3500 2    50   Input ~ 0
D1
Text GLabel 8200 3700 2    50   Input ~ 0
D3
Text GLabel 8200 3800 2    50   Input ~ 0
D4
Text GLabel 8200 3900 2    50   Input ~ 0
D5
Wire Wire Line
	8200 3400 8050 3400
Wire Wire Line
	8050 3500 8200 3500
Wire Wire Line
	8200 3600 8050 3600
Wire Wire Line
	8050 3700 8200 3700
Wire Wire Line
	8050 3800 8200 3800
Wire Wire Line
	8050 3900 8200 3900
Text GLabel 6600 3400 0    50   Input ~ 0
D11
Text GLabel 6600 3500 0    50   Input ~ 0
D10
Text GLabel 6600 3600 0    50   Input ~ 0
D9
Text GLabel 6600 3700 0    50   Input ~ 0
D8
Text GLabel 6600 3800 0    50   Input ~ 0
D7
Text GLabel 6600 3900 0    50   Input ~ 0
D6
Wire Wire Line
	6600 3900 6650 3900
Wire Wire Line
	6600 3800 6650 3800
Wire Wire Line
	6600 3700 6650 3700
Wire Wire Line
	6600 3600 6650 3600
Wire Wire Line
	6600 3500 6650 3500
Wire Wire Line
	6600 3400 6650 3400
Text GLabel 8500 2800 2    50   Input ~ 0
CLK
Text GLabel 8500 2700 2    50   Input ~ 0
OF
Wire Wire Line
	8500 2700 8050 2700
Wire Wire Line
	8050 2800 8500 2800
Text GLabel 5175 1700 3    50   Input ~ 0
D0
Text GLabel 5275 1700 3    50   Input ~ 0
D1
Text GLabel 8200 3600 2    50   Input ~ 0
D2
Text GLabel 5375 1700 3    50   Input ~ 0
D2
Text GLabel 5475 1700 3    50   Input ~ 0
D3
Text GLabel 5575 1700 3    50   Input ~ 0
D4
Wire Wire Line
	5575 2100 5575 2150
Wire Wire Line
	5575 2150 5675 2150
Wire Wire Line
	5675 1550 5675 2150
Text GLabel 5775 1700 3    50   Input ~ 0
D5
Text GLabel 5875 1700 3    50   Input ~ 0
D6
Text GLabel 5975 1700 3    50   Input ~ 0
D7
Text GLabel 6075 1700 3    50   Input ~ 0
D8
Text GLabel 6175 1700 3    50   Input ~ 0
D9
Text GLabel 6275 1700 3    50   Input ~ 0
D10
Text GLabel 6375 1700 3    50   Input ~ 0
D11
Wire Wire Line
	6475 2100 6475 2150
Wire Wire Line
	6475 2150 6575 2150
Wire Wire Line
	6575 1550 6575 2150
Text GLabel 6475 1700 3    50   Input ~ 0
OF
Wire Wire Line
	5175 1700 5175 1550
Wire Wire Line
	5275 1700 5275 1550
Wire Wire Line
	5375 1700 5375 1550
Wire Wire Line
	5475 1550 5475 1700
Wire Wire Line
	5575 1550 5575 1700
Wire Wire Line
	5775 1700 5775 1550
Wire Wire Line
	5875 1700 5875 1550
Wire Wire Line
	5975 1700 5975 1550
Wire Wire Line
	6075 1700 6075 1550
Wire Wire Line
	6175 1700 6175 1550
Wire Wire Line
	6275 1700 6275 1550
Wire Wire Line
	6375 1700 6375 1550
Wire Wire Line
	6475 1700 6475 1550
Text GLabel 6675 1700 3    50   Input ~ 0
CLK
Wire Wire Line
	6675 1550 6675 1700
NoConn ~ 5175 1050
NoConn ~ 5275 1050
NoConn ~ 5375 1050
NoConn ~ 5475 1050
NoConn ~ 5575 1050
NoConn ~ 5775 1050
NoConn ~ 5875 1050
NoConn ~ 5975 1050
NoConn ~ 6075 1050
NoConn ~ 6175 1050
NoConn ~ 6275 1050
NoConn ~ 6375 1050
NoConn ~ 6475 1050
NoConn ~ 6675 1050
NoConn ~ 6775 1050
NoConn ~ 6875 1050
NoConn ~ 6975 1050
NoConn ~ 7075 1050
NoConn ~ 7075 1550
NoConn ~ 6975 1550
NoConn ~ 6875 1550
NoConn ~ 6775 1550
Wire Wire Line
	6250 2450 6250 3200
Wire Wire Line
	6650 2800 5550 2800
Wire Wire Line
	5550 2800 5550 3150
$Comp
L power:GND #PWR0116
U 1 1 6054611D
P 5550 3950
F 0 "#PWR0116" H 5550 3700 50  0001 C CNN
F 1 "GND" H 5555 3777 50  0000 C CNN
F 2 "" H 5550 3950 50  0001 C CNN
F 3 "" H 5550 3950 50  0001 C CNN
	1    5550 3950
	1    0    0    -1  
$EndComp
Wire Wire Line
	5550 3950 5550 3450
Wire Wire Line
	5150 2600 5750 2600
Wire Wire Line
	6310 2700 6310 3100
Text GLabel 6600 2900 0    50   Input ~ 0
Sense
Wire Wire Line
	6600 2900 6650 2900
Wire Wire Line
	6310 2700 6650 2700
Wire Wire Line
	6310 3100 6650 3100
Connection ~ 6310 3300
Wire Wire Line
	6310 3300 6650 3300
Text GLabel 3750 1100 2    50   Input ~ 0
Sense
Wire Wire Line
	5950 3000 5900 3000
Connection ~ 5950 3000
Text GLabel 5900 3000 0    50   Input ~ 0
Vref
Text GLabel 3750 1200 2    50   Input ~ 0
Vref
$Comp
L power:+5V #PWR0117
U 1 1 605EB0FF
P 3550 950
F 0 "#PWR0117" H 3550 800 50  0001 C CNN
F 1 "+5V" H 3565 1123 50  0000 C CNN
F 2 "" H 3550 950 50  0001 C CNN
F 3 "" H 3550 950 50  0001 C CNN
	1    3550 950 
	-1   0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x03_Male J1
U 1 1 605ED780
P 3275 1100
F 0 "J1" H 3247 1032 50  0000 R CNN
F 1 "Reference Select" H 3247 1123 50  0000 R CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical" H 3275 1100 50  0001 C CNN
F 3 "~" H 3275 1100 50  0001 C CNN
	1    3275 1100
	1    0    0    1   
$EndComp
Wire Wire Line
	3750 1100 3475 1100
Wire Wire Line
	3750 1200 3475 1200
Wire Wire Line
	3550 950  3550 1000
Wire Wire Line
	3550 1000 3475 1000
$Comp
L Connector:Conn_01x02_Male J3
U 1 1 6060326E
P 4950 2600
F 0 "J3" H 5058 2781 50  0000 C CNN
F 1 "input" H 5058 2690 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Horizontal" H 4950 2600 50  0001 C CNN
F 3 "~" H 4950 2600 50  0001 C CNN
	1    4950 2600
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x02_Male J2
U 1 1 60609A14
P 3300 1575
F 0 "J2" H 3400 1775 50  0000 C CNN
F 1 "Vref input" H 3150 1700 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Vertical" H 3300 1575 50  0001 C CNN
F 3 "~" H 3300 1575 50  0001 C CNN
	1    3300 1575
	1    0    0    -1  
$EndComp
Wire Wire Line
	3500 1675 3550 1675
Wire Wire Line
	3550 1675 3550 1725
Wire Wire Line
	3500 1575 3550 1575
Text GLabel 3550 1575 2    50   Input ~ 0
Vref
$Comp
L power:GND #PWR0118
U 1 1 6061B724
P 3550 1725
F 0 "#PWR0118" H 3550 1475 50  0001 C CNN
F 1 "GND" H 3555 1552 50  0000 C CNN
F 2 "" H 3550 1725 50  0001 C CNN
F 3 "" H 3550 1725 50  0001 C CNN
	1    3550 1725
	1    0    0    -1  
$EndComp
$EndSCHEMATC
