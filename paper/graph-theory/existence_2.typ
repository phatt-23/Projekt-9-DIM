#import "@preview/diagraph:0.3.0"
#import "@preview/i-figured:0.2.4"
#import "@preview/oxifmt:0.2.1": strfmt
#import "@preview/alchemist:0.1.2": *
#import "@preview/codly:1.0.0": *
#import "@preview/note-me:0.3.0": *

== Důkaz existence faktoru

Existenci faktoru stromu dokážeme rekurzivní konstrukcí. 

Nechť $T$ je strom, kde $|V(T)|$ je sudé a větší nule.

Pro strom $T$ s dvěma vrcholy je jasné, že jeho lichým faktorem, je strom $T$.

Uvažujme pro $|V(T)| > 2$. 
Vybereme libovolný vrchol $v in V(T)$, 
kde $deg_T (v) > 1$ (nebereme listy), a výjmeme ho z grafu. 
Výsledným grafem je $T - {v}$.
Jeho komponenty, které jsou rovněž stromy, nazvěme jako: 
$ 
  K_1, K_2, dots, K_(deg_T (v)) 
$

Komponenty si rozdělíme do dvou množin $S$ a $L$ následovně:
$
  S = {K_i : |V(K_i)| equiv 0 space (mod 2) } \
  L = {K_i : |V(K_i)| equiv 1 space (mod 2) } \
$
Množina $S$ obsahuje komponenty sudého řádu 
a množina $L$ obsahuje komponenty lichého řádu.

Počet vrcholů grafu $T - {v}$ je lichý:
$
  |V(T - {v})| equiv 1 space (mod 2)
$
Navíc platí, že:
$
  T - {v} = union.big_(K in S) K union union.big_(K in L) K \
  V(T - {v}) = union.big_(K in S) V(K) union union.big_(K in L) V(K) \
  |V(T - {v})| = sum_(K in S) |V(K)| + sum_(K in L) |V(K)|
$


Liché číslo součtem získáme pouze, pokud sčítáme liché číslo se sudým.
$
  underbracket(2k + 1, #[liché]) 
  + underbracket(2t, #[sudé]) equiv 1 space (mod 2) " pro " k,t in ZZ
$

Jedna z množin tedy musí mít lichý součtet počtů vrcholů jejich komponent.

Víme, že platí:
$
  sum_(K in S) |V(K)| equiv 0 space (mod 2)
$
protože součet počtů vrcholů komponent se sudým počtem vrcholů je vždy sudý:
$
  |V(K&)| = 2k " pro " k in NN
$
$
  p(2k) &equiv 0 space (mod 2) \
  0 &equiv 0 space (mod 2) \
  p &= ZZ
$

Proto musí platit:
$
  sum_(K in L) |V(K)| equiv 1 space (mod 2)
$
tedy, že součet vrcholů všech komponent s lichým počtem vrcholů je lichý.
Jediný způsob, kterým získáme liché číslo součtem z lichých čísel, 
je, když lichých čísel je lichý počet.
$
  forall K in L,
  |V(K)| = 2k + 1 "pro" k in NN
$
$
  p(2k + 1) &equiv 1 space (mod 2) \
  2p k + p &equiv 1 space (mod 2) \
  p &equiv 1 space (mod 2) \
  p &= 2t + 1 " kde " t in ZZ
$
To znamená, že $|L|$ je liché:
$
  |S| equiv 0 space (mod 2) \
  |L| equiv 1 space (mod 2) \
$

Taktéž platí, že pro žádná $K in L$ neexistuje faktor $F = (V(K), E_F)$, 
kde $E_F subset.eq E(K)$ a každý $v in V(F)$ je lichého stupně.
Dle principu sudosti má totiž platit:
$
  sum_(v in K) deg_K (v) equiv 0 space (mod 2)
$
// Nemůže existovat lichý faktor stromu lichého řádu.
// neboť porušuje princip sudosti.

Proto do každého $K in L$ přidejme vrchol $v$ (včetně hrany $e_i$). 
Získáme tím graf $K + {v}$,
což je strom sudého řádu. 
Aplikujeme na něj náš dosavadní postup.
Tím bude stupeň vrcholu $v$ rovna mohutnosti množiny $L$.
$
  deg(v) = |L| equiv 1 space (mod 2)
$

Komponentám v $S$ nepřidáváme vrchol $v$, neboť už jsou sudého řádu.
Stačí aplikovat dosavadní postup.

Na konci rekurze (indukce) bude každé $v in V(T)$ mít lichý stupeň,
protože $deg(v) = |L|$, přičemž $|L|$ je v každém kroku rekurze lichá. 
#h(1fr) $ballot$






