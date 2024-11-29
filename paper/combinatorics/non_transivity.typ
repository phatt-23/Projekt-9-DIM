
== Netranzitivita kostek

Cílem této části je analyzovat vlastnosti tří čtyřstěnných kostek 
$A$, $B$ a $C$ a ukázat, že vykazují netranzitivní chování. 
To znamená, že pravděpodobnosti výhry při "souboji" mezi 
jednotlivými kostkami splňují vztahy:
$
  &P(B > A) > 0.5 \
  &P(C > B) > 0.5 \
  &P(A > C) > 0.5
$

Pro každý pár kostek $X$ a $Y$ definujeme pravděpodobnost $P(X > Y)$ 
jako pravděpodobnost, že při hodu kostkami $X$ a $Y$ padne na kostce $X$ vyšší číslo než na kostce $Y$. 

Každá kostka má čtyři stěny, takže celkový 
počet možných kombinací výsledků
při "souboji" dvou kostek je $4 dot 4 = 16$, 
což odpovídá mohutnosti množiny
kartezského součinu $X times Y$ kostek $X$ a $Y$.

Tato pravděpodobnost se vypočítá jako podíl 
počtu případů, kdy číslo na kostce X je větší než číslo na kostce Y  
a celkového počtu možných kombinací výsledků.
$
  P(X > Y) &= (lr(|{ (x,y) in X times Y : x > y }|, size: #150%))/(|X times Y|)
$


V této části postupně určíme pravděpodobnosti 
$P(B > A)$, $P(C > B)$ a $P(A > C)$.




=== Výpočet $P(B > A)$

#heading(outlined: false, offset: 3, numbering: none)[
  *První varianta řešení*
]
Pravděpodobnostní prostor $Omega$
je kartezský součin čísel na kostkách $B$ a $A$:
// The sample space $Omega$ is every combination of B's numbers with A's numbers.

$
  B = {2,2,5,5} quad
  A = {1,4,4,4} quad
  Omega = lr({ (b,a) : b in B, a in A }, 
  size: #150%) <=> B times A quad
$
#set highlight(fill: rgb("c7f0c9"))
$
  Omega = lr({
    &(2,1), (2,1), (5,1), (5,1), \
    &(2,4), (2,4), (5,4), (5,4), \
    &(2,4), (2,4), (5,4), (5,4), \
    &(2,4), (2,4), (5,4), (5,4)
  }, size: #150%) \
$

Velikost pravděpodobnostního prostoru je $|Omega| = 16$. 
Z rozepsané $Omega$ vidíme, že
počet případů, kdy kostka $B$ vyhraje 
nad $A$ je vyšší (10) než počet, kdy prohraje (6).
Pravděpodobnost vypočteme jako:
$
  P(B > A) = (2 + 4 dot 2)/(|Omega|) 
           = 10/16 = underline(underline(0.625))
$

Vidíme, že pravděpodobnost výhry kostky $B$ nad kostkou $A$
je vyšší než $50%$. To znamená, že kostka $B$ je lepší než $A$.
#h(1fr) $ballot$

#heading(outlined: false, offset: 3, numbering: none)[
  *Druhá varianta řešení*
]

Pravděpodobnostní prostorem je stále $Omega = B times A$.
Využijeme toho, že se kostky skládají
ze dvou různých čísel.
Pokud hodnota kostky $A$ je 1, 
tak kostka $B$ vyhraje vždy a to 
bez ohledu na na její hozenou hodnotu.
Pokud padla na kostce $A$ hodnota 4, 
tak $B$ vyhraje pouze tehdy, 
když byla vržena hodnota $5$.
To zapišeme a vypočítáme následně.

$
  P(B > A) &= (P(A=1) dot P(B>A=1) dot |Omega| 
             + P(A=4) dot P(B>A=4) dot |Omega|)
            /(|Omega|) \
  &= |Omega| (P(A=1) dot P(B > 1) + P(A=4) dot P(B > 4))
            /(|Omega|) \
$
$
  &= P(A=1) dot P(B > 1) + P(A=4) dot P(B > 4) quad quad quad quad quad space
$<notice-this-prob-equation>
$
  &= P(A=1) dot P(B) + P(A=4) dot P(B=5) quad quad quad quad quad quad quad\
  &= 1/4 dot 1 + 3/4 dot 1/2 \
  &= 2/8 + 3/8 = 5/8 = underline(underline(0.625)) \
$
$P(B > A) = 5/8 > 1/2$, proto kostka $B$ je lepší než $A$. #h(1fr) $ballot$

Zbývalé pravděpodobnosti $P(C > B)$ a $P(A > C)$ 
bychom mohli vypočítat obdobně jako $P(B > A)$.
Lze to ale udělat lépe?
Všiměte si @eqt:notice-this-prob-equation.
Její tvar můžeme využitím 
zákonu celkové pravděpodobnosti
#footnote[https://en.wikipedia.org/wiki/Law_of_total_probability] 
zobecnit.




=== Výpočet pomocí zákonu celkové pravděpodobnosti 
Zákon celkové pravděpodobnosti uvádí, 
že mame-li událost $E$, která závisí 
na známých podmínkách, tak její pravděpodobnost 
lze vyjádřit jako:
$
  P(E) = sum_(i=0)^n P(C_i) dot P(E|C_i)
$
kde $C_i$ jsou disjunktní podmínky pokrývající celý 
pravdepodobnostní prostor $Omega$, tedy:
$
  union.big_(i=0)^n C_i = Omega "  a  " C_i sect C_j " pro " i eq.not j
$

Událostmi jsou v našem případě  $X > Y$ (kostka $X$ vyhraje nad kostkou $Y$).
Disjunktní podmínky $C_i$ odpovídají výsledkům hodů kostky $Y$,
která může nabývat hodnot $y_0, y_1, ..., y_n$.
Podmínky $Y=y_i$ jsou disjunktní, protože platí:
$
  union.big_(i=0)^n (Y=y_i) = Omega_(X Y) 
  "  a  " (Y=y_i) sect (Y=y_j) = emptyset " pro " i eq.not j
$
Padne-li na kostce $Y$ např. 1 nemůže zároveň padnout 3 nebo 5 apod.
Obecný vzorec pro výpočet pravděpodobnosti $P(X>Y)$ je:
$
  P(X > Y) = sum_(y in Y) P(Y = y) dot P(X > y)
$





=== Aplikace vzorce na $P(C > B)$ a $P(A > C)$
Pro připomenutí, množiny $A$, $B$ a $C$ jsou:
$
  A = {1,4,4,4} quad B = {2,2,5,5} quad C = {3,3,3,6}
$
Výpočty pravděpodobností pomocí odvozeného vzorce:

$
  P(C > B) &= sum_(b in B) P(B = b) dot P(C > b) \
    &= P(B=2) dot P(C>2) + P(C=5) dot P(C>5)  \
    &= 1/2 dot 4/4 + 1/2 dot 1/4 \
    &= 4/8 + 1/8 = 5/8 = underline(underline(0.625))\
$
$
  P(A > C) &= sum_(c in C) P(C = c) dot P(A > c) \
    &= P(C=3) dot P(A>3) + P(C=6) dot P(A>6) \
    &= 3/4 dot 3/4 + 1/4 dot 0/4 
    = 9/16 = underline(underline(0.5625))\
$

Dokázali jsme, že $B > A$, $C > B$ a $A > C$. #h(1fr) $ballot$
