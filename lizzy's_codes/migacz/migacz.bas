$regfile = "m8def.dat"
$crystal = 8000000

Config Pinb.0 = Output
Config Pinb.1 = Output
Config Pinb.2 = Output
Config Pinb.3 = Output
Config Pinb.4 = Output
Config Pinb.5 = Output
Config Pinb.6 = Output
Config Pinb.7 = Output
Config Portb = Output

Do

Reset Portb.0
Waitms 400
Reset Portb.1
Waitms 400
Reset Portb.2
Waitms 400
Reset Portb.3
Waitms 400
Reset Portb.4
Waitms 400
Reset Portb.5
Waitms 400
Reset Portb.6
Waitms 400
Reset Portb.7
Waitms 400

portb = &B11111111

Loop
End