|Systemy wbudowane Laboratorium | | | |
| :---                          | :--- | --- | --- | 
|**Grupa:**<br> **B**            | **Temat:** <br> Pomiar Temperatury   | | |
|**Data:**<br> 19.05.2021       | **Wykonał:** <br> Piotr Drabik        | | |
|**Godzina:**<br> 12:30        | **II rok Informatyka Stosowana**      | **Ocena i uwagi prowadzącego:**   | **Prowadzący:**<br> dr hab. Witold Kozłowski|

# Opis ćwiczenia 

Celem ćwiczenia jest pomiar temperatury używając magistrali 1-wire oraz obsługa wielu urządzeń DS1820 używając jednej magistrali.  

Tempera podobnie jak czas od zawsze była częścią ludzkiego życia, przez długi czas jednak wysterczał nam jej niedokładny pomiar. Lecz z rozwojem techniki rosło zapotrzebowanie na dokładny , zunifikowany i użyteczny pomiar temperatury. 
Na przestrzeni czasu proponowane były różne rozwiązania na zorientowanie podziałki temperatury. Najpopularniejsze trzy to: Kelin, Celsius i Fahrenheit. 

Kelwin i Celsius mogą być używane zamiennie ponieważ podziałka skonstruowana jest w ten sam sposób więc zamiana pomiędzy dwoma systemami jest trywialna, wystarczy dodać 273.15° i z Kelwinów uzyskaliśmy Celsiusze. 

Takie rozgraniczenie pomiędzy w zasadzie jednakowym sposobem mierzenia temperatury jest ważne ponieważ na co dzień niewygodnym byłoby używanie Kelwinów do określenia temperatury powietrza. Kelwiny natomiast lepiej oddają istotę temperatury. Dokładniej opisują czym jest ciepło. Fahrenheity są głupie nikt nigdy nie powinien ich używać. 

Cyfrowe układy mierzące temperaturę są bardzo użyteczne, tym bardziej jeżeli jesteśmy w stanie mierzyć w tym samym momencie temperaturę w kilku miejscach na przykład wewnątrz i na zewnątrz domu. Lecz bardzo szybko wpadamy w problem nadkładu pracy, czasu i miedzi. 

Firmą produkującą takie układy miernicze jest DALLAS Semiconductor(Maxim), opracowali oni technologię magistrali 1-wire gdzie dane i zasilanie podróżują tym samym połączeniem nazywanym linią DQ. Fakt konieczności podłączenia układu do masy drugim połączeniem się pomija. Taki podstawowy układ wymaga na każdy z termometrów osobnej pary połączeń, dwóch kabli, dwóch styków. 

To rozwiązanie jest wysoce nieefektywne, lepszym pomysłem jest cykliczne próbkowanie każdego z termometrów podłączonych po tych samych liniach DQ i masy. To rozwiązanie wymaga niewielkiego oprogramowania a oszczędza piny procesora (których mamy ograniczoną ilość). 

By pomóc w rozstrzyganiu które z urządzeń pomiarowych właśnie wysyła informacje o aktualnej temperaturze, firma DALLAS zastosowała system ID, każdy z termometrów wychodzących z ich fabryk ma przypisany do siebie unikalny numer. Na podstawie tego numeru rozstrzygnąć możemy z jakim urządzeniem właśnie się komunikujemy.

By w praktyce pokazać sposób użycia technologi opracujemy następujący program.


# Instrukcje sterujące magistralą 1 wire 

|**polecenie** | **definicja**|
| :---: | :---: |
|```1write &HCC```  |opuszczenie zapisu numeru ID , &hcc = 204|
|```1write &H44          ```| start pomiaru temperatury|
|```1write HBE           ```| komenda odczytu zmierzonej temperatury|
| ```1wreset```             | reset magistrali| 
|```1wread(2)            ```| odczyt zmierzonej temperatury|
|```Waitms 750           ```| opóźnienie na czas pomiaru|
|```Writeeeprom ID(j)    ```| zapisanie numeru id do pamięci EEPROM|

# Fizyczne komponenty potrzebne do zrealizowania ćwiczenia 


- Układ DS1820
- Wyświetlacz LCD 

# Program mierzący temperaturę

Do mierzenia temperatury używany jest tylko jeden układ  DS1820, temperatura natomiast na żywo wyświetlana jest na wyświetlaczy LCD

```VB
  $regfile = "m8def.dat"
  $crystal = 8000000
  
  Config Lcd = 16 * 2
  Config 1wire = PORTB.0

  Declare Sub read_temp
  
  Dim temp(2) As Byte

  DefLcdChar 0, 7, 5, 7, 32, 32, 32, 32, 32

  Do
    Call read_temp
    Cls
    If temp(2) = 0 Then
      Lcd "Temp: " ; temp(1) ; Chr(0) ; "C"
    Else
      Lcd "Temp: -" ; temp(1) ; Chr(0) ; "C"
    End If
  Loop
  End

  Sub read_tempe
    1wreset
    1wwrite &hcc
    1wwrite &h44
    Waitms 750
    1wreset
    1wwrite &hcc
    1wwrite &hbe
    temp(2) = 1wread(2)
    1wreset

    If Err = 1 Then
      Cls
      Lcd "Blad"
      Do
      Loop
    End If
    If temp(2) > 0 Then
      temp(1) = 256 - tem(1)
    End If
    temp(1) = temp(1)/2
  End Sub
```

# Podsumowanie

Pomiar temperatury jest wykorzystywany niemal w każdej z dziedzin nauki, termometry w tych czasach możemy spotkać na każdym kroku, wchodzą w skład spotykanego w kuchni AGD, naszych samochodów czy są wyposażeniem każdego gabinetu lekarskiego i praktycznie wyłącznie do pomiaru temperatury wykorzystuje się układy cyfrowe. One zaś polegają na oprogramowaniu takim jak przedstawionym w powyższym zadaniu.     