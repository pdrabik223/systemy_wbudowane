<table>
<thead>
<tr>
<th style="text-align:left">Systemy wbudowane Laboratorium</th>
<th style="text-align:left"></th>
<th></th>
<th></th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left"><strong>Grupa:</strong><br> <strong>B</strong></td>
<td style="text-align:left"><strong>Temat:</strong> <br> Wyświetlacze  7seg LED i LCD</td>
<td></td>
<td></td>
</tr>
<tr>
<td style="text-align:left"><strong>Data:</strong><br> 28.04.2021r.</td>
<td style="text-align:left"><strong>Wykonał:</strong> <br> Piotr Drabik</td>
<td></td>
<td></td>
</tr>
<tr>
<td style="text-align:left"><strong>Godzina:</strong><br> 12:30</td>
<td style="text-align:left"><strong>II rok Informatyka Stosowana</strong></td>
<td><strong>Ocena i uwagi prowadzącego:</strong></td>
<td><strong>Prowadzący:</strong><br> dr hab. Witold Kozłowski</td>
</tr>
</tbody>
</table>

  
  # Opis ćwiczenia 

Celem ćwiczenia jest obsługa wyświetlaczy 7seg w sposób statyczny i multipleksowany. Wyświetlacz 7seg LED jak sama nazwa wskazuje zbudowany jest z 7 segmentów z których każdy składa się z ośrodka emitującego promieniowanie elektromagnetyczne o częstotliwościach w zakresach 400nm - 700nm zazwyczaj nazywanym światłem widzialnym. W tym konkretnym przypadku de emisji światła użyte są diody LED stąd nazwa wyświetlacza.

Poniżej schemat ułożenia diod na wyświetlaczu.

 ![7segwyświetlacz](..\myattemp\7segwyświetlacz.png)

Jak łatwo można zauważyć 7 seg wyświetlacz składa się z 8 segmentów:

A, B, C, D, E, F, G, P 

P-kropka, zamiennie opisywana symbolem H, DP.

By zaadresować każdą z diod potrzeba więc osobnego pinu, połączenia z procesorem. To bardzo szybko staje się problemem, ponieważ dwa wyświetlacze wymagają już 16 połączeń , trzy 24, itd. 

Dlatego stosuje się technikę multipleksowania. 

# Multipleksowanie 

Opiera się na niezdolności ludzkiego oka do postrzegania szybko zmieniających się obrazów. Na tej samej zasadzie opiera sie wyświetlanie filmów czy to cyfrowych czy analogowych i animacji.

Filmy nagrywa się i wyświetla z na tyle dużą częstotliwością odświeżania obrazu że ludzkie oko nie zauważa zmiany pojedyńczych klatek i postrzega te pojedyńcze obrazy jako spójną nieprzerwaną całość. 

Utartym standardem stała sie częstotliwość 24fps (24 klatek na sekundę) tyle wystarczy by oszukać ludzkie oko.

Wyświetlacze natomiast odświeżają swój stan o wiele częściej niż 24 razy na sekundę, na wcześniejszych ćwiczeniach dowiedliśmy że dioda  wstanie jest migać z niebotyczną prędkością dlatego do naszej dyspozycji oddawany jest całkiem spory zakres. 

W praktyce technika multipleksowania to sposób na wykorzystanie tego czasu (różnicy czasu pomiędzy prędkością postrzegania ludzkiego mózgu a prędkością potrzebną diodzie na zapalenie się), możemy więc "na chwile" zapalić pierwszą diodę, zgasić ją, zapalić kolejną itd... , zanim przejedziemy przez wszystkie z diod i powrócimy by zapalić ponownie pierwszą, ludzkie oko nie zarejestruje że którakolwiek zgasła, jest na to tysiące razy za wolne. 

Samo multipleksowanie to właśnie kolejne zapalanie pojedyńczych diod czy w naszym przypadku całych wyświetlaczy, na tyle szybo by ludzkie oko nie było wstanie zauważyć że kiedykolwiek wyświetlacz jest wyłączany.

Dzięki tej technice oszczędzamy na połączeniach pomiędzy wyświetlaczem a procesorem. Zamiast ośmiu połączeń na każdy z wyświetlaczy potrzeba nam 8 na pierwszy i po jednym na każdy nowy wyświetlacz który chcemy zaadresować.

Zapalanie kolejnych wyświetlaczy nazywane jest przemiataniem.

# Tabela podstawowych znaków


| **Symbol** | **Segment**| | | | | | | | |
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
|     | |**P**|**A**|**B**|**C**|**D**|**E**|**F**|**G**|
|**0**| | 0|   1| 1| 1| 1| 1| 1| 0|
|**1**| | 0|   0| 1| 1| 0| 0| 0| 0|
|**2**| | 0|   1| 1| 0| 1| 1| 0| 1|
|**3**| | 0|   1| 1| 1| 1| 0| 0| 1|
|**4**| | 0|   0| 1| 1| 0| 0| 1| 1|
|**5**| | 0|   1| 0| 1| 1| 0| 1| 1|
|**6**| | 0|   1| 0| 1| 1| 1| 1| 1|
|**7**| | 0|   1| 1| 1| 0| 0| 0| 0|
|**8**| | 0|   1| 1| 1| 1| 1| 1| 1|
|**9**| | 0|   1| 1| 1| 1| 0| 1| 1|
|**A**| | 0|   1| 1| 1| 0| 1| 1| 1|
|**B**| | 0|   1| 0| 1| 0| 1| 1| 1|
|**C**| | 0|   1| 0| 0| 1| 1| 1| 0|
|**D**| | 0|   1| 1| 1| 0| 1| 1| 1|
|**E**| | 0|   1| 0| 0| 1| 1| 1| 1|
|**F**| | 0|   1| 0| 0| 0| 1| 1| 1|


Dla schematu bez układu mocy ULN2803N należy zanegować wszystkie
wartości.

# Program stoper

Algorytm odlicza od wartości 9999 do 0, wyświetlając aktualny stan licznika na czterech wyświetlaczach 7seg, wykorzystując technikę przemiatania/ multipleksowania.

Po osiągnięciu wartości zerowej wyświetlona zostanie wiadomość.  


```VB

$regfile = "m8def.dat"
$crystal = 8000000

Config portd =Output
Config pinb.0=Output
Config pinb.1=Output
Config pinb.2=Output
Config pinb.3=Output
Config Timer0 = Timer , Prescale = 256

Declare Sub Pobr_znaku(cyfra As Byte)
On Timer0 Mult_wysw

Dim A As Byte , B As Byte , C As Byte , D As Byte
Dim Ia As Byte, Ib As Byte, Ic as Byte, Id as Byte

Dim Nr_wysw As Byte
Dim I As Byte
W1 Alias portb.0
W2 Alias portb.1
W3 Alias portb.2
W4 Alias portb.3

Enable Interrupts
Enable Timer0
Load Timer0 , 125

Do
A=9 : B=9 : C=9 : D=9

FOR Ia=9 to 0 Step -1
A=Ia

   FOR Ib=9 to 0 Step -1
   B=Ib

      FOR Ic=9 to 0 Step -1
      C=Ic

         FOR Id=9 to 0 Step -1
         D=Id
             wait 1      odczekaj sekundę przy odświeżaniu wyświetlaczy
         Next Id
         Next Ic
         Next Ib
         Next Ia

A=&B01001001 : B=&B10000110 : C=&B11000111 : D=&B11000000
wait 5
A=9 : B=9 : C=9 : D=9

Loop

End

Sub Pobr_znaku(cyfra As Byte)
   If Cyfra <10 Then
      Portd = Lookup(cyfra , Kody7seg)
   Else
      portd = 0
   End If
End Sub

Mult_wysw:
   Load Timer0 , 125
   Set W1
   Set W2
   Set W3
   Set W4
   Select Case Nr_wysw

     Case 0:
      Call Pobr_znaku(a)
       Reset W1
     Case 1:
      Call Pobr_znaku(b)
      Reset W2
     Case 2:
      Call Pobr_znaku(c)
      Reset W3
     Case 3:
      Call Pobr_znaku(d)
      Reset W4
   End Select
   Incr Nr_wysw

   If Nr_wysw = 4 Then
      Nr_wysw = 0
   End If
Return

Kody7seg:
Data &B11000000 , &B11111001 , &B10100100 , &B10110000 , &B10011001  ' 0, 1, 2, 3, 4
Data &B10010010 , &B10000010 , &B11111000 , &B10000000 , &B10010000  ' 5, 6, 7, 8, 9
Data &B10001001 , &B11000000 , &B11000111 , &B10000110
'     H              O           L              E
```

# Podstawowe informacje o wyświetlaczach LCD

Wyświetlacz ciekłokrystaliczny, LCD to urządzenie wyświetlające obraz, którego zasada działania oparta jest na zmianie polaryzacji światła na skutek zmian orientacji cząsteczek ciekłego kryształu pod wpływem przyłożonego pola elektrycznego.

Wyświetlacze stosowane są ze względu na ich energooszczędność, kompaktowy rozmiar jak i wszechstronność.

# Kilka instrukcji potrzebnych do konfiguracji wyświetlacza lcd 


|**komenda**|**opis**|
|:---:                   |:---:                         |
|```Config Lcd = 16*2``` |konfiguracja wyświetlacza lcd|
|```cls```                |czyści czyści zawartość ekranu lcd|
|```lcd```              |wyświetla string w pierwszym szeregu wyświetlacza |
|```lcd Chr(x)``` |wyświetla wartość zmiennej x w kodzie ASCII|
|```cursor off``` |wyłącza wyświetlanie kursora |
|```Shiftlcd``` |przesuwa wyświetlany text po ekranie wyświetlacza |

# Podsumowanie 

Do sterowanie wieloma wyświetlaczami LED używa się techniki multipleksowania, która ogranicza ilość potrzebnych części do wykonania układu tym samym obniżając koszta wykonania układu, należy jedynie pamiętać by częstotliwość odwietrzania każdego z multipleksowanych wyświetlaczy była większa niż ~25Hz.

Popularnymi wyświetlaczami korzystającymi z technologi LED są wyświetlacze 7seg, składają się one z 8 segmentów często tytułowanych A-G, kropka oznaczana jest znakiem P,DP lub H.
