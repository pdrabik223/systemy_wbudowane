$regfile="m8def.dat"
$crystal=8000000

Config Pinb.0 = Output
Config Timer0=TIMER, Prescale=256

On Timer0 Odmierz_1s

Dim Licz_8ms as Byte

Enable Interrupts
Enable Timer0
Load Timer0,250

Do
Loop
End

Odmierz_1s:

      Load Timer0,250
      Incr Licz_8ms
      If Licz_8ms = 125 Then
         Licz_8ms = 0
         Toggle Portb.0
      End If
   Return