$regfile="m8def.dat"
$crystal = 8000000

Config PortD = Output
Config Portb.0 = Input

Portd = &B11111111

Dim i As Byte

Przycisk Alias Pinb.0
Dim Kierunek As Byte


Reset Kierunek

Do

If Przycisk = 0 Then
   Waitms 50
   Toggle Kierunek

   Do
   Loop Until Przycisk = 1

End If

   If Kierunek = 1 Then
      For i = 0 To 7
         Toggle portd.i
          Waitms 200
      Next i

   For i = 7 To 0 Step -1
      Toggle portd.i
       Waitms 50
   Next i

   Else
      For i = 7 To 0 Step -1
         Toggle portd.i
          Waitms 200
      Next i

   For i = 0 To 0 Step 7
      Toggle portd.i
       Waitms 50
   Next i

 End If

 Waitms 100
LOOP

END