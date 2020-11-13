EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A3 16535 11693
encoding utf-8
Sheet 1 1
Title "DDDAC 1794 Build"
Date "2020-11-13"
Rev "2"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Device:Transformer_1P_1S T3
U 1 1 5E403BF6
P 12200 9550
F 0 "T3" H 12200 10000 50  0000 C CNN
F 1 "Cinemag CMLI 600/600c" H 12200 9900 50  0000 C CNN
F 2 "" H 12200 9550 50  0001 C CNN
F 3 "~" H 12200 9550 50  0001 C CNN
	1    12200 9550
	1    0    0    -1  
$EndComp
$Comp
L Device:Transformer_1P_1S T2
U 1 1 5E40482A
P 12200 8800
F 0 "T2" H 12200 9250 50  0000 C CNN
F 1 "Cinemag CMLI 600/600c" H 12200 9150 50  0000 C CNN
F 2 "" H 12200 8800 50  0001 C CNN
F 3 "~" H 12200 8800 50  0001 C CNN
	1    12200 8800
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_Coaxial J?
U 1 1 5E40AE6A
P 13500 8600
F 0 "J?" H 13600 8575 50  0000 L CNN
F 1 "Left Out" H 13600 8484 50  0000 L CNN
F 2 "" H 13500 8600 50  0001 C CNN
F 3 " ~" H 13500 8600 50  0001 C CNN
	1    13500 8600
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_Coaxial J?
U 1 1 5E40B669
P 13500 9350
F 0 "J?" H 13600 9325 50  0000 L CNN
F 1 "Right Out" H 13600 9234 50  0000 L CNN
F 2 "" H 13500 9350 50  0001 C CNN
F 3 " ~" H 13500 9350 50  0001 C CNN
	1    13500 9350
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5E40BCB1
P 12800 9550
F 0 "R?" H 12870 9596 50  0000 L CNN
F 1 "1k8" H 12870 9505 50  0000 L CNN
F 2 "" V 12730 9550 50  0001 C CNN
F 3 "~" H 12800 9550 50  0001 C CNN
	1    12800 9550
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5E40C64A
P 12800 8800
F 0 "R?" H 12870 8846 50  0000 L CNN
F 1 "1k8" H 12870 8755 50  0000 L CNN
F 2 "" V 12730 8800 50  0001 C CNN
F 3 "~" H 12800 8800 50  0001 C CNN
	1    12800 8800
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x03_Female J?
U 1 1 5E4150DF
P 1200 2350
F 0 "J?" H 1092 2025 50  0000 C CNN
F 1 "Conn_01x03_Female" H 1092 2116 50  0000 C CNN
F 2 "" H 1200 2350 50  0001 C CNN
F 3 "~" H 1200 2350 50  0001 C CNN
	1    1200 2350
	-1   0    0    1   
$EndComp
$Comp
L Device:Fuse F?
U 1 1 5E415BE9
P 2000 2250
F 0 "F?" V 1803 2250 50  0000 C CNN
F 1 "Fuse" V 1894 2250 50  0000 C CNN
F 2 "" V 1930 2250 50  0001 C CNN
F 3 "~" H 2000 2250 50  0001 C CNN
	1    2000 2250
	0    1    1    0   
$EndComp
$Comp
L Switch:SW_DPST_x2 SW?
U 1 1 5E416B9D
P 2650 2250
F 0 "SW?" H 2650 2485 50  0000 C CNN
F 1 "SW_DPST_x2" H 2650 2394 50  0000 C CNN
F 2 "" H 2650 2250 50  0001 C CNN
F 3 "~" H 2650 2250 50  0001 C CNN
	1    2650 2250
	1    0    0    -1  
$EndComp
Text Notes 900  1950 0    50   ~ 0
IEC 320 Connector with fuse and switch
$Comp
L dddac1794project:GDisplayI2C Display1
U 1 1 5E41A755
P 11800 2500
F 0 "Display1" H 11650 2600 50  0000 L CNN
F 1 "OLED I2C 128x64 SH1106" H 11350 2500 50  0000 L CNN
F 2 "" H 11800 2500 50  0001 C CNN
F 3 "" H 11800 2500 50  0001 C CNN
	1    11800 2500
	1    0    0    -1  
$EndComp
Wire Wire Line
	12600 8600 12800 8600
Wire Wire Line
	12800 8650 12800 8600
Connection ~ 12800 8600
Wire Wire Line
	12800 8600 13300 8600
Wire Wire Line
	12600 9000 12800 9000
Wire Wire Line
	13500 9000 13500 8800
Wire Wire Line
	12800 8950 12800 9000
Connection ~ 12800 9000
Wire Wire Line
	12800 9000 13500 9000
Wire Wire Line
	12600 9350 12800 9350
Wire Wire Line
	12600 9750 12800 9750
Wire Wire Line
	13500 9750 13500 9550
Wire Wire Line
	12800 9700 12800 9750
Connection ~ 12800 9750
Wire Wire Line
	12800 9750 13500 9750
Wire Wire Line
	12800 9400 12800 9350
Connection ~ 12800 9350
Wire Wire Line
	12800 9350 13300 9350
Wire Wire Line
	1400 2250 1850 2250
Wire Wire Line
	2150 2250 2450 2250
$Comp
L power:Earth_Protective #PWR?
U 1 1 5E426F68
P 1550 2600
F 0 "#PWR?" H 1800 2350 50  0001 C CNN
F 1 "Earth_Protective" H 2000 2450 50  0001 C CNN
F 2 "" H 1550 2500 50  0001 C CNN
F 3 "~" H 1550 2500 50  0001 C CNN
	1    1550 2600
	1    0    0    -1  
$EndComp
Text GLabel 3000 2250 2    50   Output ~ 0
AC_P
Text GLabel 3000 2350 2    50   Output ~ 0
AC_N
Wire Notes Line
	2950 2550 2950 1950
Wire Notes Line
	2950 1950 900  1950
Wire Notes Line
	900  1950 900  2550
Wire Notes Line
	900  2550 2950 2550
Wire Wire Line
	1400 2450 1550 2450
Wire Wire Line
	1550 2450 1550 2600
$Comp
L dddac1794project:Transformer_2P_2S T1
U 1 1 5E43407B
P 1900 6500
F 0 "T1" H 1900 7081 50  0000 C CNN
F 1 "2x115VAC 2x6VAC 30VA " H 1900 6990 50  0000 C CNN
F 2 "" H 1900 6500 50  0001 C CNN
F 3 "~" H 1900 6500 50  0001 C CNN
	1    1900 6500
	1    0    0    -1  
$EndComp
$Comp
L dddac1794project:DIYIHNK4.17uV B?
U 1 1 5E43D6AB
P 3900 6500
F 0 "B?" H 3900 7065 50  0000 C CNN
F 1 "DIYIHNK4.17uV" H 3900 6974 50  0000 C CNN
F 2 "" H 3850 6650 50  0001 C CNN
F 3 "" H 3850 6650 50  0001 C CNN
	1    3900 6500
	1    0    0    -1  
$EndComp
$Comp
L dddac1794project:DDDACPS B??
U 1 1 5E441411
P 2100 9550
F 0 "B??" H 2100 10115 50  0000 C CNN
F 1 "DDDAC PS 12V" H 2100 10024 50  0000 C CNN
F 2 "" H 2000 9600 50  0001 C CNN
F 3 "" H 2000 9600 50  0001 C CNN
	1    2100 9550
	1    0    0    -1  
$EndComp
Text Notes 850  2350 2    50   ~ 0
230VAC
$Comp
L dddac1794project:DDDACMainboard B?
U 1 1 5E44E547
P 10250 9150
F 0 "B?" H 10225 9915 50  0000 C CNN
F 1 "DDDACMainboard" H 10225 9824 50  0000 C CNN
F 2 "" H 9400 9850 50  0001 C CNN
F 3 "" H 9400 9850 50  0001 C CNN
	1    10250 9150
	1    0    0    -1  
$EndComp
$Comp
L dddac1794project:DDDACModPbT Deck1
U 1 1 5E45F7FA
P 10250 8050
F 0 "Deck1" H 10250 8450 50  0000 C CNN
F 1 "DAC Modulde PbT" H 10250 8350 50  0000 C CNN
F 2 "" H 10250 8050 50  0001 C CNN
F 3 "" H 10250 8050 50  0001 C CNN
	1    10250 8050
	1    0    0    -1  
$EndComp
$Comp
L dddac1794project:DDDACModPbT Deck3
U 1 1 5E463A5E
P 10250 7450
F 0 "Deck3" H 10250 7850 50  0000 C CNN
F 1 "DAC Modulde PbT" H 10250 7750 50  0000 C CNN
F 2 "" H 10250 7450 50  0001 C CNN
F 3 "" H 10250 7450 50  0001 C CNN
	1    10250 7450
	1    0    0    -1  
$EndComp
Wire Wire Line
	11050 9000 11800 9000
Wire Wire Line
	11050 9350 11800 9350
Wire Wire Line
	11050 9450 11500 9450
Wire Wire Line
	11500 9450 11500 9750
Wire Wire Line
	11500 9750 11800 9750
Wire Wire Line
	11050 8900 11500 8900
Wire Wire Line
	11500 8900 11500 8600
Wire Wire Line
	11500 8600 11800 8600
NoConn ~ 11050 9100
NoConn ~ 11050 9550
Wire Wire Line
	2900 9600 2900 10000
Connection ~ 2900 9600
Wire Wire Line
	2900 9600 9400 9600
Wire Wire Line
	2300 6400 2650 6400
Wire Wire Line
	2650 6400 2650 6350
Wire Wire Line
	2650 6350 3100 6350
Wire Wire Line
	2300 6600 2650 6600
Wire Wire Line
	2650 6600 2650 6650
Wire Wire Line
	2650 6650 3100 6650
Wire Wire Line
	2300 6900 2650 6900
Wire Wire Line
	2650 6900 2650 6750
Wire Wire Line
	2650 6750 3100 6750
Wire Wire Line
	2300 6100 2650 6100
Wire Wire Line
	2650 6100 2650 6250
Wire Wire Line
	2650 6250 3100 6250
$Comp
L dddac1794project:RelayModule2x RM?
U 1 1 5E47DF63
P 7650 5800
F 0 "RM?" H 7650 6015 50  0000 C CNN
F 1 "RelayModule2x" H 7650 5924 50  0000 C CNN
F 2 "" H 7700 5750 50  0001 C CNN
F 3 "" H 7700 5750 50  0001 C CNN
	1    7650 5800
	1    0    0    -1  
$EndComp
Wire Wire Line
	8200 6200 8450 6200
Wire Wire Line
	8450 6200 8450 9150
Wire Wire Line
	8450 9150 9400 9150
Wire Wire Line
	9400 9250 8350 9250
Wire Wire Line
	8350 9250 8350 6300
Wire Wire Line
	8350 6300 8200 6300
Wire Wire Line
	8200 6400 8200 9350
Wire Wire Line
	8200 9350 9400 9350
Wire Wire Line
	8850 8900 9400 8900
$Comp
L Connector:Conn_Coaxial J?
U 1 1 5E48C056
P 12050 5850
F 0 "J?" H 12150 5825 50  0000 L CNN
F 1 "RCA" H 12150 5734 50  0000 L CNN
F 2 "" H 12050 5850 50  0001 C CNN
F 3 " ~" H 12050 5850 50  0001 C CNN
	1    12050 5850
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5E48D0FF
P 9650 6100
F 0 "R?" H 9720 6146 50  0000 L CNN
F 1 "75" H 9720 6055 50  0000 L CNN
F 2 "" V 9580 6100 50  0001 C CNN
F 3 "~" H 9650 6100 50  0001 C CNN
	1    9650 6100
	1    0    0    -1  
$EndComp
Wire Wire Line
	8850 5950 8850 8900
Wire Wire Line
	8200 5950 8850 5950
Wire Wire Line
	8200 5850 11250 5850
Wire Wire Line
	12050 6050 12050 6250
Wire Wire Line
	12050 6250 11750 6250
Wire Wire Line
	9400 9000 8750 9000
Wire Wire Line
	8750 9000 8750 6250
Text Notes 12200 4700 2    50   ~ 0
VCC = 3.3V from Mainboard
Wire Wire Line
	8750 6250 9650 6250
$Comp
L dddac1794project:TORX147 J?
U 1 1 5E491377
P 11750 5200
F 0 "J?" H 11420 5246 50  0000 R CNN
F 1 "DIYHINK TORX147 192k" H 11420 5155 50  0000 R CNN
F 2 "" H 11650 4700 50  0001 C CNN
F 3 "https://docs.broadcom.com/docs/AV02-4369EN" H 11650 5200 50  0001 C CNN
	1    11750 5200
	-1   0    0    -1  
$EndComp
Wire Wire Line
	11350 5200 11250 5200
Wire Wire Line
	11250 5200 11250 5850
Connection ~ 11250 5850
Connection ~ 11750 6250
$Comp
L Connector:Conn_Coaxial J?
U 1 1 5E4C3FBA
P 12050 6350
F 0 "J?" H 12150 6325 50  0000 L CNN
F 1 "RCA" H 12150 6234 50  0000 L CNN
F 2 "" H 12050 6350 50  0001 C CNN
F 3 " ~" H 12050 6350 50  0001 C CNN
	1    12050 6350
	1    0    0    -1  
$EndComp
Text Notes 12850 5850 2    50   ~ 0
SPDIF 1 IN
Text Notes 12850 6350 2    50   ~ 0
SPDIF 2 IN
Text Notes 12950 5050 2    50   ~ 0
TOSLINK 1 IN
Wire Wire Line
	8200 6050 9400 6050
Wire Wire Line
	9400 6350 11850 6350
Wire Wire Line
	12050 6550 11750 6550
Wire Wire Line
	11750 6550 11750 6250
Wire Wire Line
	8850 5950 9650 5950
Connection ~ 8850 5950
Wire Wire Line
	11250 5850 11850 5850
Wire Wire Line
	9650 6250 11750 6250
Wire Bus Line
	11050 8700 11250 8700
Wire Bus Line
	11250 8700 11250 8000
Wire Bus Line
	11250 7400 11050 7400
Wire Bus Line
	11050 8000 11250 8000
Connection ~ 11250 8000
Wire Bus Line
	11250 8000 11250 7700
$Comp
L dddac1794project:powerctrl B?
U 1 1 5E4DF65B
P 4150 4250
F 0 "B?" H 4200 5115 50  0000 C CNN
F 1 "powerctrl" H 4200 5024 50  0000 C CNN
F 2 "" H 4950 4700 50  0001 C CNN
F 3 "" H 4950 4700 50  0001 C CNN
	1    4150 4250
	-1   0    0    -1  
$EndComp
$Comp
L dddac1794project:SW_Push_DPST_LED SW1
U 1 1 5E4EB2FD
P 1950 3650
F 0 "SW1" H 1950 4085 50  0000 C CNN
F 1 "Power" H 1950 3994 50  0000 C CNN
F 2 "" H 1950 4000 50  0001 C CNN
F 3 "~" H 1950 4000 50  0001 C CNN
	1    1950 3650
	1    0    0    -1  
$EndComp
$Comp
L dddac1794project:SW_Push_DPST_LED SW2
U 1 1 5E4EBD37
P 8750 4650
F 0 "SW2" H 8750 5085 50  0000 C CNN
F 1 "Source" H 8750 4994 50  0000 C CNN
F 2 "" H 8750 5000 50  0001 C CNN
F 3 "~" H 8750 5000 50  0001 C CNN
	1    8750 4650
	-1   0    0    -1  
$EndComp
Wire Wire Line
	1500 6400 1500 6600
Wire Wire Line
	1500 9450 1500 9650
Wire Wire Line
	1500 6900 1050 6900
Wire Wire Line
	1250 9300 1250 6100
Wire Wire Line
	1150 3100 2200 3100
Wire Wire Line
	3600 3100 3600 2250
Wire Wire Line
	2850 2250 3600 2250
Wire Wire Line
	3500 2350 3500 3000
Wire Wire Line
	3500 3000 1050 3000
Wire Wire Line
	1400 2350 3500 2350
Wire Wire Line
	2150 3500 2200 3500
Wire Wire Line
	2200 3500 2200 3100
Connection ~ 2200 3100
Wire Wire Line
	2200 3100 3600 3100
Wire Wire Line
	1750 3500 1250 3500
Wire Wire Line
	1250 6100 1500 6100
Wire Wire Line
	1450 4400 1150 4400
Wire Wire Line
	1450 4550 1250 4550
Wire Wire Line
	2550 4450 3250 4450
Wire Wire Line
	2550 4550 3250 4550
Wire Wire Line
	2150 3650 3050 3650
Wire Wire Line
	3050 3650 3050 3800
Wire Wire Line
	3050 3800 3250 3800
Wire Wire Line
	3250 4000 2800 4000
Wire Wire Line
	2800 4000 2800 3800
Wire Wire Line
	2800 3800 2150 3800
Wire Wire Line
	3250 3900 1600 3900
Wire Wire Line
	1600 3900 1600 3650
Wire Wire Line
	1600 3650 1750 3650
Wire Wire Line
	3250 4100 2650 4100
Wire Wire Line
	2650 4100 2650 4000
Wire Wire Line
	2650 4000 1750 4000
Wire Wire Line
	1750 4000 1750 3800
Text Notes 4650 5100 2    50   ~ 0
ATTiny based power controller
Wire Notes Line
	900  2950 900  5250
Wire Notes Line
	900  5250 5200 5250
Wire Notes Line
	5200 5250 5200 2950
Wire Notes Line
	5200 2950 900  2950
Text Notes 4850 3050 2    50   ~ 0
soft power down circuit
Text GLabel 4700 6250 2    50   Output ~ 0
DIRTY5V
Text GLabel 4700 6650 2    50   Output ~ 0
CLEAN3.3V
$Comp
L Connector:Conn_Coaxial J?
U 1 1 5E57EB25
P 15550 2000
F 0 "J?" V 15432 2101 50  0000 L CNN
F 1 "RCA" V 15523 2101 50  0000 L CNN
F 2 "" H 15550 2000 50  0001 C CNN
F 3 " ~" H 15550 2000 50  0001 C CNN
	1    15550 2000
	0    1    1    0   
$EndComp
$Comp
L dddac1794project:RaspberryPi3 B?
U 1 1 5E5A426E
P 6850 1400
F 0 "B?" H 6875 1665 50  0000 C CNN
F 1 "RaspberryPi3" H 6875 1574 50  0000 C CNN
F 2 "" H 6850 1400 50  0001 C CNN
F 3 "" H 6850 1400 50  0001 C CNN
	1    6850 1400
	1    0    0    -1  
$EndComp
$Comp
L dddac1794project:Raspberry_Pi_Connector_Breakout J?
U 1 1 5E59A4C0
P 9550 2500
F 0 "J?" H 9550 3981 50  0000 C CNN
F 1 "Raspberry_Pi_Connector_Breakout" H 9550 3890 50  0000 C CNN
F 2 "" H 9550 2500 50  0001 C CNN
F 3 "https://www.raspberrypi.org/documentation/hardware/raspberrypi/schematics/rpi_SCH_3bplus_1p0_reduced.pdf" H 9550 2500 50  0001 C CNN
	1    9550 2500
	1    0    0    -1  
$EndComp
NoConn ~ 7450 1600
NoConn ~ 7450 1700
NoConn ~ 7450 1800
Text Notes 5250 1400 0    50   ~ 0
USB and Network can be \nconnected from the back \nof the enclosure.
Wire Wire Line
	10350 1900 10900 1900
Wire Wire Line
	10900 1900 10900 3050
Wire Wire Line
	10900 3050 11400 3050
Wire Wire Line
	10350 2000 11000 2000
Wire Wire Line
	11000 2000 11000 2950
Wire Wire Line
	11000 2950 11400 2950
Wire Wire Line
	9650 1200 9650 950 
Wire Wire Line
	9650 950  11100 950 
Wire Wire Line
	11100 950  11100 2750
Wire Wire Line
	11100 2750 11400 2750
Wire Wire Line
	11300 3950 11300 2850
Wire Wire Line
	11300 2850 11400 2850
Wire Bus Line
	15950 1400 15950 6900
Wire Bus Line
	15950 6900 9200 6900
Wire Bus Line
	9200 6900 9200 8700
Wire Bus Line
	9200 8700 9400 8700
Wire Wire Line
	4700 6750 4800 6750
Wire Wire Line
	13300 6650 4700 6650
Wire Wire Line
	9250 3800 9250 3950
Wire Wire Line
	9250 3950 11300 3950
Wire Wire Line
	5900 3800 5900 4450
Wire Wire Line
	5900 6350 4800 6350
Wire Wire Line
	5900 3800 9150 3800
Wire Wire Line
	4950 4450 5900 4450
Connection ~ 5900 4450
Wire Wire Line
	9350 1200 9350 1050
Wire Wire Line
	9350 1050 7800 1050
Wire Wire Line
	7800 1050 7800 2650
Wire Wire Line
	6650 2650 6650 5950
Wire Wire Line
	6650 5950 7100 5950
Wire Wire Line
	6650 2650 7800 2650
Wire Wire Line
	9450 1200 9450 950 
Wire Wire Line
	5800 950  5800 4350
Wire Wire Line
	5800 6250 4700 6250
Wire Wire Line
	4950 4350 5800 4350
Connection ~ 5800 4350
Entry Wire Line
	15450 1600 15550 1700
Wire Wire Line
	15550 1700 15550 1800
Entry Wire Line
	15250 1600 15350 1700
Wire Wire Line
	15350 1700 15350 2000
Text Notes 15750 2250 2    50   ~ 0
SPDIF OUT
Text Notes 7200 6400 2    50   ~ 0
GND to ?
Wire Wire Line
	8750 3000 8400 3000
Text Notes 9300 4500 2    50   ~ 0
GND ?
Wire Wire Line
	7100 6150 6850 6150
Wire Wire Line
	6850 6150 6850 2800
Wire Wire Line
	6850 2800 8750 2800
Wire Bus Line
	7450 1400 8750 1400
Wire Wire Line
	4950 4050 8250 4050
Wire Wire Line
	8250 4050 8250 2700
Wire Wire Line
	8250 2700 8750 2700
Wire Wire Line
	4950 4150 8150 4150
Wire Wire Line
	8750 1600 8000 1600
Wire Wire Line
	8000 1600 8000 4250
Wire Wire Line
	8000 4250 4950 4250
Wire Wire Line
	8400 3000 8400 4500
Wire Wire Line
	8400 4500 8550 4500
Wire Wire Line
	4950 4800 8550 4800
Wire Wire Line
	8950 4800 9100 4800
Wire Wire Line
	9100 4800 9100 4900
Wire Wire Line
	4950 4900 9100 4900
Wire Wire Line
	9450 3800 9450 4500
Wire Wire Line
	9450 4500 8950 4500
Wire Wire Line
	9350 3800 9350 5100
Wire Wire Line
	6950 2900 6950 6050
Wire Wire Line
	6950 6050 7100 6050
Wire Wire Line
	6950 2900 8750 2900
Wire Wire Line
	7100 6250 7050 6250
Wire Wire Line
	7050 5100 9350 5100
$Comp
L power:GNDD #PWR?
U 1 1 5E8844E5
P 4800 6400
F 0 "#PWR?" H 4800 6150 50  0001 C CNN
F 1 "GNDD" H 4804 6245 50  0000 C CNN
F 2 "" H 4800 6400 50  0001 C CNN
F 3 "" H 4800 6400 50  0001 C CNN
	1    4800 6400
	1    0    0    -1  
$EndComp
$Comp
L power:GNDA #PWR?
U 1 1 5E885CE2
P 2900 10000
F 0 "#PWR?" H 2900 9750 50  0001 C CNN
F 1 "GNDA" H 2905 9827 50  0000 C CNN
F 2 "" H 2900 10000 50  0001 C CNN
F 3 "" H 2900 10000 50  0001 C CNN
	1    2900 10000
	1    0    0    -1  
$EndComp
Wire Wire Line
	4800 6400 4800 6350
Connection ~ 4800 6350
Wire Wire Line
	4800 6350 4700 6350
$Comp
L dddac1794project:GNDD_CLEAN #PWR?
U 1 1 5E89C627
P 4800 6800
F 0 "#PWR?" H 4800 6550 50  0001 C CNN
F 1 "GNDD_CLEAN" H 4804 6645 50  0000 C CNN
F 2 "" H 4800 6800 50  0001 C CNN
F 3 "" H 4800 6800 50  0001 C CNN
	1    4800 6800
	1    0    0    -1  
$EndComp
Wire Wire Line
	4800 6750 4800 6800
Connection ~ 1050 6900
Wire Wire Line
	1050 6900 1050 9800
Connection ~ 1250 6100
Wire Wire Line
	1050 3000 1050 6900
Wire Wire Line
	5800 4350 5800 5300
Wire Wire Line
	5900 4450 5900 5400
Connection ~ 9650 6250
Wire Wire Line
	9400 6050 9400 6350
Wire Wire Line
	11750 6100 11750 6250
Wire Wire Line
	11750 5600 11750 6250
Text Label 8750 2800 2    50   ~ 0
BUS_SELECT
Text Label 8800 2900 2    50   ~ 0
SPDIF_SELECT
Text Label 8750 3000 2    50   ~ 0
SOURCE_SWITCH
Text Label 8800 1600 2    50   ~ 0
SWITCH_LED
Wire Wire Line
	8750 2000 8150 2000
Wire Wire Line
	8150 2000 8150 4150
Text Label 8700 2000 2    50   ~ 0
PI_STATE
Text Label 8700 2700 2    50   ~ 0
PWR_DWN_REQ
Text Notes 4500 6050 0    50   ~ 0
The dirty digital 5V feeds:\n- Raspberry Pi\n- Dirty part of the Isolator\n- OLED display\n- ATTiny45 board\n- 1 Relayboards
Text Notes 4500 7300 0    50   ~ 0
The clean digital 3.3V feeds:\n- Clean part of the Isolator\n- Hifiberrry Digi + Pro
Text Notes 8250 1600 0    50   ~ 0
?
Text Notes 10450 3200 0    50   ~ 0
SWITCH_LED ?
Text Notes 9950 10150 0    50   ~ 0
HF filter capacitors used of 10nF
Text Notes 9950 10300 0    50   ~ 0
Stock type Rload of Rdale are used.
Wire Wire Line
	2700 9500 9400 9500
Wire Wire Line
	2700 9600 2900 9600
Wire Wire Line
	1250 9300 1500 9300
Wire Wire Line
	1050 9800 1500 9800
Text Notes 2600 9050 0    50   ~ 0
Supply only use for:\n- Mainboard\n- DAC Modules
Wire Notes Line
	750  10500 5350 10500
Wire Notes Line
	5350 10500 5350 1550
Wire Notes Line
	5350 1550 750  1550
Wire Notes Line
	750  1550 750  10500
Text Notes 2550 1650 0    50   ~ 0
Power Supply Section
Wire Wire Line
	5800 950  9450 950 
Text Notes 12500 8600 0    50   ~ 0
yellow
Text Notes 12500 9100 0    50   ~ 0
orange
Text Notes 11700 8600 0    50   ~ 0
red
Text Notes 11700 9100 0    50   ~ 0
brown
Text Notes 11700 9850 0    50   ~ 0
brown
Text Notes 11700 9350 0    50   ~ 0
red
Text Notes 12500 9850 0    50   ~ 0
orange
Text Notes 12500 9350 0    50   ~ 0
yellow
Text Notes 1300 6200 0    50   ~ 0
brown
Text Notes 1300 6900 0    50   ~ 0
blue
Text Notes 1300 6350 0    50   ~ 0
purple
Text Notes 1300 6650 0    50   ~ 0
white
Text Notes 2200 6700 0    50   ~ 0
black
Text Notes 2200 6900 0    50   ~ 0
red
Text Notes 2200 6400 0    50   ~ 0
gray
Text Notes 2200 6150 0    50   ~ 0
orange
Text Notes 2950 3200 0    50   ~ 0
brown
Text Notes 2950 2950 0    50   ~ 0
blue
$Comp
L dddac1794project:DDDACModPbT Deck2
U 1 1 5FAF93AE
P 12250 7750
F 0 "Deck2" H 12383 8115 50  0000 C CNN
F 1 "DAC Modules PbT" H 12383 8024 50  0000 C CNN
F 2 "" H 12400 7800 50  0001 C CNN
F 3 "" H 12400 7800 50  0001 C CNN
	1    12250 7750
	-1   0    0    -1  
$EndComp
Wire Bus Line
	11450 7700 11250 7700
Connection ~ 11250 7700
Wire Bus Line
	11250 7700 11250 7400
$Comp
L dddac1794project:FifoPi B?
U 1 1 5FB05815
P 12950 1700
F 0 "B?" H 12950 2315 50  0000 C CNN
F 1 "FifoPi Q3" H 12950 2224 50  0000 C CNN
F 2 "" H 12800 1850 50  0001 C CNN
F 3 "" H 12800 1850 50  0001 C CNN
	1    12950 1700
	1    0    0    -1  
$EndComp
Wire Wire Line
	13300 2500 13300 6650
Wire Wire Line
	4800 6750 13450 6750
Connection ~ 4800 6750
Wire Wire Line
	13450 2500 13450 6750
Wire Wire Line
	7050 5100 7050 6250
Wire Wire Line
	12450 2500 12450 4050
Wire Wire Line
	12450 4050 10100 4050
Wire Wire Line
	10100 4050 10100 5300
Wire Wire Line
	10100 5300 5800 5300
Connection ~ 5800 5300
Wire Wire Line
	5800 5300 5800 6250
Wire Wire Line
	5900 5400 10250 5400
Wire Wire Line
	10250 5400 10250 4150
Wire Wire Line
	12600 4150 12600 2500
Wire Wire Line
	10250 4150 12600 4150
Connection ~ 5900 5400
Wire Wire Line
	5900 5400 5900 6350
Wire Bus Line
	10350 1400 12050 1400
Wire Bus Line
	13850 1400 15950 1400
Text Notes 14350 2450 0    50   ~ 0
SPDIF OUT is currently floating until a \noutput board for the FifoPi is bought.
NoConn ~ 13850 1600
Text Notes 13650 2100 0    50   ~ 0
In practice the instead of the Pi GPIO \nheader the GPIO Breakout header is \nconnected to the UnIsolated GPIO \nof the Fifopi.
Wire Bus Line
	13850 1750 14100 1750
Text Notes 2850 5050 2    50   ~ 0
All the power connections are connected \nto a  PCB which contains the solidstaterelay.\nBut for clearity the connections are drawn \nwithout the PCB in place.
$Comp
L dddac1794project:SolidStateRelayModule RM?
U 1 1 5FB06778
P 2000 4300
F 0 "RM?" H 2000 4515 50  0000 C CNN
F 1 "SolidStateRelayModule" H 2000 4424 50  0000 C CNN
F 2 "" H 2050 4250 50  0001 C CNN
F 3 "" H 2050 4250 50  0001 C CNN
	1    2000 4300
	1    0    0    -1  
$EndComp
Wire Wire Line
	2550 4400 2550 4450
Connection ~ 1250 4550
Wire Wire Line
	1250 4550 1250 6100
Wire Wire Line
	1250 3500 1250 4550
Wire Wire Line
	1150 3100 1150 4400
Wire Bus Line
	15000 1600 15450 1600
$EndSCHEMATC
