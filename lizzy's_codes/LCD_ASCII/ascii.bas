$regfile = "m8def.dat"
$crystal = 8000000

Config Lcd = 16*2

Config PortC = Output

Deflcdchar 0,16,16,18,20,24,16,16,31' replace [x] with number (0-7)
Deflcdchar 1,32,2,4,32,12,18,18,12' replace [x] with number (0-7)
Deflcdchar 2,32,1,2,32,15,2,4,15' replace [x] with number (0-7)

Dim I As Byte
Cursor off

'Cls LCD "kod ASCII"

 Lcd Chr(0)
 Lcd Chr(1)
 Lcd "d"
 Lcd Chr(2)




End

'DD - sprawozdanie nr 4 xD
'     - jak napisaæ kawalek kodu, ktory ten napis bedzie biegal
'   - animacje porobiæ  (Ozywic patyczaka jak na kartach w zeszycie czy cus) czlowiek biegbie za pilka, na koncu wyswietlacza spada (animacja jak laduje), z drugiej linii wskakuje na gore (animacja skoku)

