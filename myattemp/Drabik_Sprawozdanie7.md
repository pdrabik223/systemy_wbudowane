|Systemy wbudowane Laboratorium | | | |
| :---                          | :--- | --- | --- | 
|**Grupa:**<br> **B**            | **Temat:** <br> Interfejs RSR232   | | |
|**Data:**<br> 26.05.2021       | **Wykonał:** <br> Piotr Drabik        | | |
|**Godzina:**<br> 12:30        | **II rok Informatyka Stosowana**      | **Ocena i uwagi prowadzącego:**   | **Prowadzący:**<br> dr hab. Witold Kozłowski|

# Opis ćwiczenia 

Zegary, termometry i wyświetlacze w połączeniu z procesorem są bardzo użyteczne, pozwalają na pobieranie analizowanie i wyświetlanie informacji. Lecz odosobniony procesor choć we właściwych rękach jest potężnym narzędziem, nie jest za bardzo użyteczny. Lepszym rozwiązaniem jest umożliwić tej pojedyńczej komórce kontakt z wieloma innymi mu podobnymi, albo lepiej połączyć tego typu procesor z komputerem i umożliwić komunikację pomiędzy nimi. 


To jest właśnie zadaniem  interfejsu szeregowego RS232, komunikacja mikroprocesora z stacjonarnym komputerem. Oczywiście nie jest to proste zadanie ze względu na różnice między procesorami i mnogość kombinacji. Warto pamiętać iż interfejs musi stabilnie działać niezalanie od modelu komputera czy jego parametrów. Dlatego producenci interfejsu zdecydowali się na zastosowanie "ramki".

Ramka to (zazwyczaj) 1 bajt informacji poprzedzonych bitem startu i zakończony kilkoma bitami stopu. 

# Instrukcje kontroli magistrali
|**polecenie** | **definicja**|
| :---: | :---: |
| `print`| wysyła ciąg znaków|
|`input`|pobiera ciąg znaków|
|```echo on```| włącza wyświetlanie informacji<br> pobieranych za pomocą funkcji input|
|```echo off```| wyłącza wyświetlanie informacji<br> pobieranych za pomocą funkcji input|
|```ischarwaiting```| informuje o pojawieniu się znaku w buforze |
|```waitkey```| wstrzymuje działanie programu do pojawienia się znaku w buforze|

<P style="page-break-before: always">

# Program ilustrujący połączenie procesora z konsolą komputera

```VB
 $regfile = "m8def.dat"
 $crystal = 8000000
 $baud = 9600

 Dim I As Byte
 I = 243

 Do 
    Print "Hello World"
    Wait 2 
    Print "Wartosc I zapisana DEC: "; I        
    
    Wait 2 
    Print "Wartosc I zapisana HEX: "; Hex(I)
    
    Wait 2 
    Print "Wartosc I zapisana BIN: "; BIT(I)
    
    Print  
    Wait 5
Loop
End
```
# Program pobierający informacje od użytkownika za pośrednictwem konsoli komputera 

```VB
 $regfile = "m8def.dat"
 $crystal = 8000000
 $baud = 9600

 Dim I As Byte
 Dim znak As String * 1 

 

 Do 
    Print "Hello World"
    Input "Podaj wartość I" , I
    Print "wartość I wynosi"; I

    If  I = 1 Then
        Do znak = WaitKey()
            Print "Odebrano znak: ", znak
        Loop Until znak = "k"
    End IF

    IF I = 1 Then
        Do 
            I = Ischarwaiting()
            Print "Flaga zawartosci bufora: "; I
            znak = Inkey()
            Print " W zmiennej znak jest: ";znak
            Waitms 500
        Loop Until Znak = "k"
    End IF
Loop
End 
```

# Podsumowanie 

Komunikacja pomiędzy urządzaniami jest wręcz konieczna przy budowaniu większych, bardziej użytecznych systemów. Możliwość wysyłania i odbierania danych do i z komputera otwiera wiele drzwi, umożliwia wiele projektów. Jest jednak niestety  skomplikowanym problemem, lecz dostępne są narzędzia upraszczające to zadanie. Jednym z nich jest interfejs RS232, oczywiście samo kodowanie nie wystarczy potrzebny jest jeszcze Konwerter USB UART, umożliwiający komunikację pomiędzy interfejsami
USB oraz RS232.
Jest jeszcze możliwość zastosowania technologi bezprzewodowej. Interfejs pozostaje niezmieniony tylko sposób łączenia urządzeń się zmieni.