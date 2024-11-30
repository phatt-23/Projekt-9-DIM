
== Formulace a popis úloh
Nechť máme tři čtyřstenné kostky $A$, $B$ a $C$,
jejíchž čísla na stěnnách jsou definovaná množinami takto:

$
  A = {1,4,4,4} \
  B = {2,2,5,5} \
  C = {3,3,3,6} \
$

Zvolme si dvě kostky $X$, $Y$ a hoďme s nimi.
Když jsou kostky vrženy současně, 
řekneme, že kostka $X$ je lepší než kostka $Y$,
pokud pravděpodobnost, 
že hodnota na kostce $X$ bude vyšší 
než hodnota na kostce $Y$, je větší než $50%$.
Tuto skutečnost zapíšeme jako $X>Y$.
Pravděpodobnost výhry kostky $X$ nad kostkou $Y$
označíme potom jako $P(X > Y)$.

Úlohy jsou následující:

1. #[ 
  *Prokázání netranzitivity*

  První úkolem je ukázat, že vztahy mezi kostkami nejsou tranzitivní, 
  to znamená, že vztahy mezi kostkami jsou tzv. cyklické
  #footnote[
    Wikipedia, _Intransitivity_:
    #link("https://en.wikipedia.org/wiki/Intransitivity")
  ]
  Tvrdíme totiž, že platí $B > A$, $C > B$ a současně $A > C$.
  To znamená, že žádná kostka není "nejlepší" ve všech případech. 

  Pro každou dvojici kostek vypočítáme pravděpodobnost vítězství jedné 
  kostky nad druhou, konkrétně $P(B>A)$, $P(C>B)$ a $P(A>C)$, a ověříme, 
  že všechny tyto pravděpodobnosti jsou větší než $1/2$.
]

+ #[ 
  *Kombinatorická analýza možných konfigurací*

  V druhém úkolu máme stanovit celkový počet možných
  konfigurací čísel tří kostek.
  Čísla na stěny kostek vybíráme 
  z množiny $[1,6]$, přičemž se čísla 
  mohou opakovat. Navíc jsou kostky jsou 
  rozlišitelné (např. barvou). 
]

+ #[ 
  *Maximalizace pravděpodobností*

  Poslední úloha spočívá v nalezení 
  největší hodnoty parametru $p$ při volné 
  konfiguraci čísel na kostkách (dle druhé úlohy),
  přičemž parametr $p$ musí splňovat:

  $
    P(B>A) >= p \
    P(C>B) >= p \
    P(A>C) > p
  $

  To vyžaduje navržení algoritmu, 
  který systematicky prověří všechny možné 
  konfigurace čísel na kostkách, vypočítá 
  odpovídající pravděpodobnosti a maximalizuje $p$.  
]

