#import "@preview/diagraph:0.3.0"
#import "@preview/i-figured:0.2.4"
#import "@preview/oxifmt:0.2.1": strfmt
#import "@preview/alchemist:0.1.2": *
#import "@preview/codly:1.0.0": *
#import "@preview/note-me:0.3.0": *

== Důkaz existence faktoru

Existenci faktoru stromu dokážeme indukci -- konkrétně jeho rekurzivní konstrukcí. 

Nechť $T = (V,E)$ je strom, kde:
$
|V(T)| equiv 0 space (mod 2)$ a $|V(T)| >= 2$.

#heading(outlined: false, offset: 2, numbering: none)[
  Základní případ
]

Pro strom $T$ se dvěma vrcholy, $|V(T)| = 2$, je zřejmé, 
že jeho lichý faktor je právě $T$.

#heading(outlined: false, offset: 2, numbering: none)[
  Indukční krok
]

Uvažujme pro $|V(T)| > 2$. 
Vybereme libovolný vrchol $v in V(T)$, 
kde $deg_T (v) > 1$ (tj. nebereme listy), a výjmeme ho z grafu. 
Výsledkem je graf $T - {v}$, jehož komponenty, 
které jsou rovněž stromy, označíme jako: 
$ 
  K_1, K_2, dots, K_(deg_T (v)) 
$
Hranu, která spojuje vrchol $v$ s komponentou $K_i$, označíme jako $e_i$.



#heading(outlined: false, offset: 2, numbering: none)[
  #text(weight: "regular")[ _Rozdělení komponent_ ]
]

Komponenty si rozdělíme do dvou množin $S$ a $L$ tak, 
aby $S$ obsahovala komponenty sudého řádu,
zatímco $L$ obsahovala komponenty lichého řádu:
$
  S = {K_i : |V(K_i)| equiv 0 } quad 
  L = {K_i : |V(K_i)| equiv 1 } quad (mod 2)
$



#heading(outlined: false, offset: 2, numbering: none)[
  #text(weight: "regular")[ _Analýza počtu vrcholů_ ]
]

Počet vrcholů grafu $T - {v}$ je lichý:
$
  |V(T - {v})| equiv 1 quad (mod 2)
$
Dále platí:
$
  T - {v} &= xor.big_(K in S) K xor xor.big_(K in L) K \
  V(T - {v}) &= xor.big_(K in S) V(K) xor xor.big_(K in L) V(K) \
$
$
  |V(T - {v})| &= sum_(K in S) |V(K)| + sum_(K in L) |V(K)| equiv 1 quad (mod 2)
$


Liché číslo lze získat pouze součtem sudého a lichého čísla:
$
  underbracket(2t, #[sudé]) 
  + underbracket((2k + 1), #[liché]) 
equiv 1 quad (mod 2), quad "pro" k,t in ZZ
$

// TODO: This sounds ass
Jedna z množin tedy musí mít lichý součet počtu vrcholů svých komponent, 
přičemž platí:
$
  sum_(K in S) |V(K)| equiv 0 quad (mod 2)
$
protože suma počtů vrcholů komponent v $S$ je vždy sudá:
$
  |V(K&)| = 2k quad "pro" k in NN
$
$
  p(2k) &equiv 0 space (mod 2) \
  0 &equiv 0 space (mod 2) \
  p &= ZZ
$

Z čehož plyne:
$
  sum_(K in L) |V(K)| equiv 1 space (mod 2)
$
tedy, že suma vrcholů všech komponent v $L$ je lichá.



#heading(outlined: false, offset: 2, numbering: none)[
  #text(weight: "regular")[ _Počet komponent v $L$_ ]
]

Součet vrcholů komponent v $S$ je vždy sudý.
Naopak součet vrcholů komponent v $L$ je lichý.
To znamená, že množina $L$ obsahuje lichý počet komponent:
$
  |L| equiv 1 quad (mod 2)
$
neboť jediný způsob, kterým získáme liché číslo součtem lichých čísel, 
je, když lichých čísel máme lichý počet.
$
  forall K in L,
  |V(K)| = 2k + 1 "pro" k in NN
$
$
  p(2k + 1) &equiv 1 quad (mod 2) \
  2p k + p &equiv 1 quad (mod 2) \
  p &equiv 1 quad (mod 2) \
$
$
  p = 2t + 1 quad "kde" t in ZZ
$



#heading(outlined: false, offset: 2, numbering: none)[
  Konstrukce faktoru 
]

Pro komponentu $K in L$ neexistuje faktor $F = (V(K), E_F)$, 
kde $E_F subset.eq E(K)$ a každý vrchol $v in V(F)$ by byl lichého stupně.
To vyplývá z principu sudosti:
$
  sum_(v in K) deg_K (v) equiv 0 space (mod 2)
$
Nemůže tedy existovat lichý faktor stromu lichého řádu, 
protože by to porušovalo tento princip.

Abychom zajistili sudost, přidáme do každého $K in L$ 
zpět výjmutý vrchol $v$ (včetně hrany $e_i$),
čímž získáme strom $K + {v}$ sudého řádu. 
Na tento strom aplikujeme indukční krok.
Vrchol $v$ bude mít stupeň roven počtu komponent v $L$:
$
  deg(v) = |L| equiv 1 quad (mod 2)
$

Komponentám v $S$ nepřidáváme vrchol $v$, 
neboť už jsou sudého řádu.
I na ně aplikujeme indukční krok.

Na konci indukce (rekurze) bude každý vrchol $v in V(T)$ mít lichý stupeň,
protože 
$ 
  deg(v) = |L|
$
přičemž velikost $L$ je v každém kroku lichá. 
Tím je existence faktoru prokázána. #h(1fr) $ballot$






