|Systemy wbudowane Laboratorium | | | |
| :---                          | :--- | --- | --- | 
|**Grupa:**<br> **B**            | **Temat:** <br> Pomiar Temperatury   | | |
|**Data:**<br> 02.06.2021       | **Wykonał:** <br> Piotr Drabik        | | |
|**Godzina:**<br> 12:30        | **II rok Informatyka Stosowana**      | **Ocena i uwagi prowadzącego:**   | **Prowadzący:**<br> dr hab. Witold Kozłowski|

# Opis ćwiczenia 

Celem ćwiczenia jest pomiar temperatury używając magistrali 1-wire oraz obsługa wielu urządzeń DS1820 używając jednej magistrali.  

Tempera podobnie jak czas od zawsze była częścią ludzkiego życia, przez długi czas jednak wysterczał nam jej niedokładny pomiar. Lecz z rozwojem techniki rosło zapotrzebowanie na dokładny , zunifikowany i użyteczny pomiar temperatury. 
Na przestrzeni czasu proponowane były różne rozwiązania na zorientowanie podziałki temperatury. Najpopularniejsze trzy to: Kelin, Celsius i Fahrenheit. 

Kelwin i Celsius mogą być używane zamiennie ponieważ podziałka skonstruowana jest w ten sam sposób więc zamiana pomiędzy dwoma systemami jest trywialna, wystarczy dodać 273.15° i z Kelwinów uzyskaliśmy Celsiusze. 

Takie rozgraniczenie pomiędzy w zasadzie jednakowym sposobem mierzenia temperatury jest ważne ponieważ na co dzień niewygodnym byłoby używanie Kelwinów do określenia temperatury powietrza. Kelwiny natomiast lepiej oddają istotę temperatury. Dokładniej opisują czym jest ciepło. Fahrenheity są głupie nikt nigdy nie powinien ich używać. 

Cyfrowe układy mierzące temperaturę są bardzo użyteczne, tym bardziej jeżeli jesteśmy w stanie mierzyć w tym samym momencie temperaturę w kilku miejscach na przykład wewnątrz i na zewnątrz domu. Lecz bardzo szybko wpadamy w problem nadkładu pracy, czasu i miedzi. 

Firmą produkującą takie układy miernicze jest DALLAS Semiconductor(Maxim), opracowali oni technologię magistrali 1-wire gdzie dane i zasilanie podróżują tym samym połączeniem nazywanym linią DQ. Fakt konieczności podłączenia układu do masy drugim połączeniem się pomija. 