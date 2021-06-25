'Czestotliwosc powinna wynosic 61.27Hz
'Wypelnienie 50%

$regfile="m8def.dat"
$crystal=8000000

Config Pinb.1 = output

Config Timer1 = PWM,PWM = 8, Compare A PWM = Clear Up, Compare B PWM = Disconnect,Prescale = 256,

PWM1a = 127.5

End