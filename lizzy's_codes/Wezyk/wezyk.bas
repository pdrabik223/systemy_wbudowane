$regfile="m8def.dat"
$crystal = 8000000

Config Portd = Output

PORTd= &B01010101

Do

Rotate PORTd, Left


Loop

END