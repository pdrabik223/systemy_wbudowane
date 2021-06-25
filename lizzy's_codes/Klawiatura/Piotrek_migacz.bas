$regfile = "m8def.dat"
$crystal = 8000000

Config Pinb.1 = Input
Config Pinb.2 = Input
Config Portd = Output

dir_left Alias pinb.2
dir_right Alias Pinb.1


Dim A As Byte


Portd = &B11111111

Set Pinb.1
Set Pinb.2


Do
   Debounce dir_left , 0 , left_to_right , Sub
   Debounce dir_right , 0 , right_to_left , Sub
Loop

End

left_to_right:
   'Portd = &B11111111

   For A = 1 To 7

            toggle Portd.A
            waitms 500
   next A

   For A = 7 To 0 Step -1
         Toggle portd.A
          Waitms 100
   Next A

Return

right_to_left:

    'Portd = &B11111111
           For A = 7 To 1 Step -1

            toggle Portd.A
            waitms 500
   next A

    For A = 1 To 7

            toggle Portd.A
            waitms 100
   next A


Return