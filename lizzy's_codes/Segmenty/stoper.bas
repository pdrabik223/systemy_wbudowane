$regfile = "m8def.dat"
$crystal = 8000000

Config PORTD = Output
Config PINB.0 = Output
Config PINB.1 = Output
Config PINB.2 = Output
Config PINB.3 = Output

Config Timer0 = Timer, Prescale =256

Declare Sub Pobr_znaku(cyfra As Byte)
On Timer0  Mult_wysw

Dim A As Byte, B As Byte, C As Byte, D As Byte
Dim Nr_wysw As Byte
Dim I_a As Byte
Dim I_b As Byte
Dim I_c As Byte
Dim I_d As Byte

W1 Alias Portb.0
W2 Alias Portb.1
W3 Alias Portb.2
W4 Alias Portb.3

Enable Interrupts
Enable Timer0

Load Timer0, 125

Do

A=9 : B=9 : C=9 : D=9

    For I_a = 9 To 0 Step -1
         A = I_a


         For I_b = 9 To 0 Step -1
            B = I_b


            For I_c = 9 To 0 Step -1
               C = I_c


               For I_d = 9 To 0 Step -1
                  D = I_d
                  Wait 1

                Next I_d

            Next I_c

        Next I_b

    Next I_a


A = 17 : B = 15 : C = 21  : D = 21
  'H      'E       'L        'L

Wait 5

A = 9 : B = 9 : C = 9 : D = 9

Loop

End


Sub Pobr_znaku(cyfra As Byte)
   If Cyfra <28 Then
      Portd = Lookup(cyfra , Kody7seg)
   Else
      portd = 0
   End If
End Sub


Mult_wysw:
   Load Timer0 , 125
   Set W1
   Set W2
   Set W3
   Set W4
   Select Case Nr_wysw

     Case 0:
      Call Pobr_znaku(a)
       Reset W1
     Case 1:
      Call Pobr_znaku(b)
      Reset W2
     Case 2:
      Call Pobr_znaku(c)
      Reset W3
     Case 3:
      Call Pobr_znaku(d)
      Reset W4
   End Select
   Incr Nr_wysw

   If Nr_wysw = 4 Then
      Nr_wysw = 0
   End If
Return



Kody7seg:
Data &B00000011 , &B10011111 , &B00100101 , &B00001011, &B10011001
      '0             '1          '2            '3           '4

Data &B01001001 , &B01000001 , &B00011111 , &B00000001 , &B00001001
      '5             '6          '7            '8           '9

Data &B00010001 , &B11000001 , &B01100011 , &B11100101 , &B10000101 'tu skonczylam
      'A             'b           'C           'c           'd

Data &B10000110 , &B10001110 , &B10001001 , &B10001011 ,&B11111001
      'E             'F           'H           'h          'I

Data &B11111011 , &B11000111 , &B11001111 , &B11000000 ,&B10100011
      'i             'L           'l           'O          'o

Data &B10001100 , &B10010010 , &B11000001 , &B10100100
       'P            'S           'U           'Z