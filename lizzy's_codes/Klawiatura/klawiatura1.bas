$regfile = "m8def.dat"
$crystal = 8000000
Config Portd = Output
Config Pinb.0 = Input

Dim direction As Bit

button Alias Pinb.0

Set Portb.0

 Portd = &B11111110
 Reset direction

Do

   If button = 0 Then
      Waitms 50
      Toggle direction

      Do
     Loop Until button = 1

   End If


   If direction = 1 Then

       Rotate Portd, Left
   Else
       Rotate PORTD , Right
   End If

   Waitms 100
Loop
End