#import "@preview/diagraph:0.3.0"
#import "@preview/i-figured:0.2.4"
#import "@preview/oxifmt:0.2.1": strfmt
#import "@preview/alchemist:0.1.2": *
#import "@preview/codly:1.0.0": *
#import "@preview/note-me:0.3.0": *

== Důkaz existence faktoru $F$ 

Graf $T$ je strom sudého řádu.
$
  G=(V,E) \
  |V| equiv 0 space (mod 2)
$
Jelikož počet vrcholů je sudý,
tak graf $T$ musí mít sudý počet lichých stupní.
Pokud by počet lichých stupní byl lichý,
potom bychom porušili princip sudosti, jenž uvádí, že:
$
  sum_(v in V(T)) deg(v) = 2|E|.
$
Dokažme si, že stupňová posloupnosti s lichým 
počtem lichých stupní neexistuje.
Mějme libovolný graf $G$ sudého řádu.
$
  G = (V,E) quad
  |V| = n = 2k, k in ZZ \
  D_G = (d_1, d_2, ..., d_n) \
  k_e = lr(|{ d in D : d equiv 0 space (mod 2) }|, size: #150%) \
  k_o = lr(|{ d in D : d equiv 1 space (mod 2) }|, size: #150%) \
  k_o equiv 1 space (mod 2) <=> k_e equiv 1 space (mod 2)\
  sum_(v in V) deg(v) 
    = k_e dot "sudá" + k_o dot "lichá" 
    = "sudá" + "lichá" 
    = underline("lichá")
$
Součet stupní vrcholů vyšel lichý.
To je dle principu sudosti nepřípustné, 
takový graf neexistuje.
Stupňová posloupnost se tedy bude
vždy skládat ze sudého počtu lichých stupní 
a sudého počtu sudých stupní. 

Pro hledaní lichého faktoru $F$ stromu $T$
si pomožme tím, že si představíme jeho stupňovou 
posloupnost. Je nutné podotknout, že jedna posloupnost 
může popisovat více stromů.
To nám však nevadí, jelikož pracujeme 
se stromy obecně, nikoliv s konkretními stromy.

Pokud se tato posloupnost skládá z lichých čísel,
tak jsme jsme našli lichý faktor $F$ grafu $T$.
Faktorem $F$ je totiž strom $G$ samotný.

Pokud tato posloupnost obsahuje sudá čísla, 
budeme hodnoty této posloupnosti postupně 
po párech dekrementovat, 
dokud nedostaneme lichou posloupnost.
Dekrementujeme po párech, jelikož jedna hrana 
grafu je incidentní se dvěma vrcholy grafu.

Všechna kombinace dekrementace 
ve stupňovové posloupnosti jsou znázorněna zde:
// $
//     &(..., "lichá" - 1 = "sudá", ..., "lichá" - 1 = "sudá", ...) \
//     &(..., "sudá" - 1 = "lichá", ..., "sudá" - 1 = "lichá", ...) \
//     &(..., "lichá" - 1 = "sudá", ..., "sudá" - 1 = "lichá", ...) \
//     &(..., "sudá" - 1 = "lichá", ..., "lichá" - 1 = "sudá", ...).
// $
$
    &(..., "lichá", ..., "lichá", ...) 
    &|=>^((-1))
    &(..., "sudá", ..., "sudá", ...) 
\
    &(..., "sudá", ..., "sudá", ...) 
    &|=>^((-1))
    &(..., "lichá", ..., "lichá", ...) 
\
    &(..., "lichá", ..., "sudá", ...) 
    &|=>^((-1))
    &(..., "sudá", ..., "lichá", ...)
\
    &(..., "sudá", ..., "lichá", ...)
    &|=>^((-1))
    &(..., "lichá", ..., "sudá", ...) 
.
$
#admonition(
  icon-string: read("./../assets/info.svg"),
  color: color.blue,
  title: "Poznámka",
)[
  Mějme na paměti, že stupně rovno jedné nesmíme snižovat.
  Tyto stupně odpovídají stupňům listů,
  jehož incidentní hrany musí být ve faktoru $F$.
  Pokud bychom tyto hrany odstranili, 
  listy by byly stupně nula - nula není liché číslo.
]

Nakonec se nám vždy podaří lichou posloupnost(i) dostat.
Bez ohledu na to jakým způsobem provedeme
postupné snížování stupňí v posloupnosti, 
je zaručeno, že jedním z těchto vysledných posloupností 
je právě ona posloupnost faktoru $F$ grafu $G$.

Toto postupné snižování sekvence 
a vysledné nalezení sekvence s lichými hodnotami,
funguje, jelikož víme že počet vrcholů je sudý.
Fakt, že existuje sudý počet 
lichých a sudých stupňů se 
po jakékoli dekrementaci, 
nemění (není porušen princip sudosti).

Pro strom $T$ sudého stupně skutečně existuje lichý faktor $F$. 
#h(1fr) $ballot$


