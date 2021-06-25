$regfile="m8def.dat"
$crystal = 8000000

Config Portb = Output
Config Portc = Output
Config Portd = Output

Dim i_b As Byte
Dim i_c As Byte
Dim i_d  As Byte

i_b = 0
i_c = 1
i_d = 2

DO

Toggle Pinb.i_b
Toggle Pinc.i_c
Toggle Pind.i_d

'Reset Pinb.i_b
'Reset Pinc.i_c
'Reset Pind.i_d

Incr i_b
Incr i_c
Incr i_d

If i_d = 9 Then
Set PIND.1
Return
End If



LOOP


END