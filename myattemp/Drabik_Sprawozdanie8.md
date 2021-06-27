|Systemy wbudowane Laboratorium | | | |
| :---                          | :--- | --- | --- | 
|**Grupa:**<br> **B**            | **Temat:** <br> Komunikacja w oparciu o technologię podczerwieni   | | |
|**Data:**<br> 02.06.2021       | **Wykonał:** <br> Piotr Drabik        | | |
|**Godzina:**<br> 12:30        | **II rok Informatyka Stosowana**      | **Ocena i uwagi prowadzącego:**   | **Prowadzący:**<br> dr hab. Witold Kozłowski|



# Opis ćwiczenia 

Żadko się tak zdarza, że człowiek zżywa się z technologią o tego stopnia że zapomina o czasie przed nią, lub nie wyobraża sobie jej nieistnienia, tak się stało z telefonami komórkowymi i Internetem ale do tego grona dołączyć też należy piloty. Urządzenia dołączane do każdego telewizora, radia czy zestawu audio, wręcz oczekujemy by został załączony do każdego produktu.
Ale czym w zasadzie są piloty, na czym polega ich zasada działania, czym jest podczerwień? 

Podczerwień to spektrum promieniowania elektromagnetycznego, częstotliwości zaliczane do podczerwieni znajdują się jak sama nazwa wskazuje nad kolorem czerwonym. Częstotliwość fali jest nieco dłuższa od tej widzialnej gołym okiem, dlatego ludzie nie są w stanie dostrzec migania diody pilota, lecz aparaty już są. 

Urządzenia oparte o podczerwień takie jak odbiorniki i nadajniki stosują kodowanie sygnału często RC5 (w oparciu tę technologię kreować będziemy własne układy), w kodowaniu RC5 czas trwania jednego bitu to 1,78ms a jedna paczka informacja składa sie z **14-bitów**.

<P style="page-break-before: always">

O to schemat wiadomości kodowanej systemem Manchester:

|**no bitu**|**przykładowa<br>wiadomość**|**funkcja**|
|:---:|:---:|:---:|
| 1  | 1 | S1 (zawsze 1)|
| 2  | 1 | S2 (zawsze 1)|
| 3  | 0 | kontrola |
| 4  | 0 | Address |
| 5  | 0 | Address |
| 6  | 1 | Address |
| 7  | 0 | Address |
| 8  | 1 | Address |
| 9  | 1 | Command |
| 10 | 1 | Command |
| 11 | 0 | Command |
| 12 | 1 | Command |
| 13 | 0 | Command |
| 14 | 1 | Command |



Na komendę przeznaczone jest 6 bitów co daje nam przestrzeń **64** unikalnych komend.

Innym sposobem na wysyłanie informacji drogą podczerwieni jest protokół NEC w którym informacje przesyłane są na podstawie odległości impulsów bitów.
Logiczna **1** trwa **2.25ms** transmisji a logiczne **0** trwa **1.125ms**.


# Instrukcje kontroli sygnału podczerwieni
|**polecenie** | **definicja**|
| :---: | :---: |
| `Config Int0`|konfigurowanie przerwania Int0|
|` Config Rc5 `|konfiguracja linii odbiornika podczerwieni|
|```Getrc5```  | pobranie adresu oraz komendy z nadajnika |
|```Rc5send``` | wysłanie informacji  |

<P style="page-break-before: always">

# Fizyczne komponenty potrzebne do zrealizowania ćwiczenia 



- Odbiornik podczerwieni VS1838
- Nadajnik podczerwieni  IR NEC


# Program obłupujący transfer danych w kodowaniu RC5

```VB
  $regfile = "m8def.dat"
  $crystal = 8000000
  Config Lcd = 16 * 2
  Config INT0 = Low Level
  Config Rc5 = PIND.2
  Dim addres As Byte, cmd As Byte
  Dim recived As Bit

  Set recived

  Do 
    If recived = 1 Then
      Cls
      Lcd "Addres: " ; addr
      Lowerline
      Lcd "Cmd: " ; cmd
      Reset recived
      Enable INT0
    End If
  Loop
  End

 Pobr_rc5:
    Disable INTO
    Enable Interrupts
    Getrc5 (Address, Command)
    Command = Command And &B0111111
    Set Odebr_kod
Return 


  s1 Alias PINC . 1
  s2 Alias PINC . 2
  s3 Alias PINC . 0
  Do
    Debounce s1, 0, Rc5, Sub
    Debounce s2, 0, Rc6, Sub
    Debounce s3, 0, Sony, Sub   
  Loop
  End

  Rc5:
    Command = 12
    Togbit = 0
    Adress = 0

    Do
      Rc5send Togbit, Address, Command
      Waitms 250
    Loop Until s1 = 1
  Return

  Rc6:
    Command = 13
    Togbit = 0
    Adress = 0

    Do
      
      Rc6send Togbit, Address, Command
      Waitms 250

    Loop Until s2 = 1
  Return

  Sony:
    
    Do
        Sonysend &HA90
      Waitms 250
    Loop Until s3 = 1
  Return

  ```

  # Podsumowanie 

  Bezprzewodowe wymiana danych między urządzeniami jest świętym gralem techników, świat w którym nie ma konieczności podłączania kabli jest jest swego rodzaju Walhallą w której nie plączemy się w ładowarkach, przedłużaczach czy kablach usb. Ważnym krokiem w stronę wykonanym w kierunku tego olimpu było opanowanie techniki przesyłania danych drogą podczerwoną.     