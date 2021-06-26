|Systemy wbudowane Laboratorium | | | |
| :---                          | :--- | --- | --- | 
|**Grupa:**<br> **B**            | **Temat:** <br> Zegar  | | |
|**Data:**<br> 20.05.2021       | **Wykonał:** <br> Piotr Drabik        | | |
|**Godzina:**<br> 12:30        | **II rok Informatyka Stosowana**      | **Ocena i uwagi prowadzącego:**   | **Prowadzący:**<br> dr hab. Witold Kozłowski|

# Opis ćwiczenia 

Celem ćwiczenia jest zaprojektowanie i zbudowanie zegara.

Od tysiącleci ludzkość odmierza czas, pełni on ważną rolę w życiu człowieka, wyznaczał kiedy należy się odpoczynek, kiedy czas na posiłek, kiedy czas do pracy. Lecz przez długi czas dokładność nie była wymagana, zwykła obserwacja słońca wystarczała. Niestety wraz z postępem technologi wystąpiła potrzeba uniwersalnego i dokładnego systemu miary czasu. Szalę przeważyła kolej, wraz z wprowadzeniem między miastowej kolei, wystąpiła potrzeba dokładnego mierzenia czasu w różnych częściach kraju z około minutową dokładnością. Przewińmy 200 lat do przodu i stajemy przed problemem, jak dokładnie odmierzać czas, dokładność minutowa nie wystarczy, potrzeba nam dokładniejszych pomiarów, dokładniejszych narzędzi. 

Odpowiedzą na coraz większe zapotrzebowanie czasowe są na przykład zegary atomowe, podobnie jak słońce, swoją funkcjonalność czerpią z podstawowych oddziaływań atomowych. Zasada działania zegara atomowego oparta jest na szybkości przejścia elektronów między powłokami w atomie. To sprawia że czas odmierzany przez zegary atomowe jest niezwykle dokładny. Co więcej jest też darmowy!

W niemczech istnieje stacja nadawcza DCF-77, transmitująca wskazania tamtejszego zegara atomowego, każdy posiadający odbiornik amator punktualności może dostroić się do częstotliwości nadawania sygnału i odbierać informacje o aktualnym czasie z dokładnością do milisekund. 


### Na zajęciach nie poruszyliśmy tematu zegarów atomowych więcej.


<br>

# Zegar Timer0

My na zajęciach nie jesteśmy w stanie kożystać z technologi zegarów atomowych, więc polegać musimy na inneych metodach odmierzania czasu. Jedną z takich metod jest funkcja Timer. 

Timer używa taktowania procesora do odmierzania czasu, licząc kolejne impulsy wysyłane przez zegar i znając jego taktowanie możemy wywnioskować po ilu impulsach minie sekunda. 

# Program Timer

```VB
$regfile="m8def.dat"
$crystal=8000000

Config Pinb.0 = Output
Config Timer0 = TIMER, Prescale = 256

On Timer0 Odmierz_1s

Dim Licz_8ms as Byte

Enable Interrupts
Enable Timer0
Load Timer0,250

Do
Loop
End

Odmierz_1s:

      Load Timer0, 250
      Incr Licz_8ms
      If Licz_8ms = 125 Then   
         Licz_8ms = 0
         Toggle Portb.0
      End If
   Return

```

 
# Zegar oparty na technologi Timer1

Zegar liczący sekundy niestety nie jest datą. Należy upływ sekund przeliczyć na minuty, minuty na godziny, i taki układ godzin minut i sekund można nazwać licznikiem. Należy jeszcze umieścić informacje o starcie licznika i dodać godzinę startu do wskazać owego timera. w tej konstelacji licznik staje się zegarem. Pozostają jeszcze kwestie dni godzin i sekund przestępnych, stref czasowych, różnych czasów zimowego i letniego gdy dwa razy w roku przestawiamy zegarki o godzinę do przodu i godzinę do tyłu. WIelka Brytania używa zegarów dwunastko godzinnych i by indykować w której części dnia się aktualnie znajdują używają opisów AM i PM.


Ten program odlicza i wyświetla czas 

```VB
$regfile = "m8def.dat"
$crystal = 8000000

Config Lcd = 16 * 2
Config PINB.1 = Input
Config PINB.2 = Input
Config Timer1 = Timer, Prescale = 256

Declare Sub show

On Timer1 count1s

Dim s As Byte
Dim minutes As Byte
Dim hour As Byte
Dim new As Byte
Dim bcd As Byte


S1 Alias PINB.2
S2 Alias PINB.1


Enable Interupts 
Enable Timer1

Counter1 = 34286

Set new 
Set PORTB.1
Set PORTB.2

Do
  Call showtime
  If s1 = 0 Then
    Waitms 25
    If s1 = 0 Then
      Incr minutes
      s = 0
      if minutes = 60 Then
        minutes = 0
      End If
      Set new
      Call show
    End If
  End If
  If s2 = 0 Then
    Waitms 25
      If s2 = 0 Then
        Incr hour
        if hour = 24 Then
          hour = 0
        End If
        Set new
        Call show
        Waitms 200
      End If
  End If
Loop
End
```


# Podsumowanie 

Poprawna obsługa czasu nie jest trywialnym zadaniem, przez ludzką naturę i potrzebę użyteczności temat stał się niebywale skomplikowany. Zaprezentowane programy tylko ujawniają czubek góry lodowej jaką jest wyświetlanie aktualnego czasu. 

Na nasze pogrzeby program oparty na funkcji Timer1 wystarcza w zupełności.