#import "@preview/diagraph:0.3.0"
#import "@preview/i-figured:0.2.4"
#import "@preview/oxifmt:0.2.1": strfmt
#import "@preview/alchemist:0.1.2": *
#import "@preview/codly:1.0.0": *
#import "@preview/note-me:0.3.0": *

#set page(
  header: align(right)[
    Teorie grafů
  ],
)

= Teorie grafů

Mějme strom $T$ se sudým počtem vrcholu (je sudého řádu).
Cílem je ukázat, že pro $T$ existuje faktor $F$, kde všechny 
vrcholy grafu $F$ jsou lichého stupně (budeme říkat lichý faktor).

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
  icon-string: read("./assets/info.svg"),
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


== Důkaz jednoznačnosti faktoru $F$

Existenci faktoru $F$ jsme si odůvodnili. 
Nyní si dokážme, že takových faktorů $F$ grafu $G$, 
kde jsou všechny vrcholy lichého stupně, 
je právě jeden jediný.

Předpokladejme, že existují dva liché faktory grafu $G$.
Mějme faktory $F_1, F_2$, pro které tvrdíme, 
že jsou od sebe odlišné. Tedy musí platit,
že mají alespoň jednu hranu, která náleží 
pouze jim a ne druhému.
$
  exists e in E(F_1), e in.not E(F_2)
$

Z těchto dvou faktoru můžeme vytvořit nový graf, 
který obsahuje všechny vrcholy stromu $T$,
které jsou spojeny pouze těmi hranami, které se objevují
právě v jednom z faktoru, nikoli v obou.

$
  (V(T), E(F_1) xor E(F_2)) 
  quad "nebo také" quad
  (V(T), E(F_1) Delta E(F_2)) \
  "zkráceně potom" \
  F_1 Delta F_2
$

Při rozhodování, zda hranu $e$ do $F_1 Delta F_2$ zahrneme, postupujeme takto:
#figure(
  table(
    columns: 3,
    stroke: 0.2pt,
    table.header[hrana $e$ je zahrnuta v $F_1$][hrana $e$ je zahrnuta v $F_2$][hrane $e$ je zahrnuta v $F_1 Delta F_2$],
    [ano],[ano],[ne],
    [ne],[ano],[ano],
    [ano],[ne],[ano],
    [ne],[ne],[ne],
  )
)
nebo stručněji:
#figure(
  table(
    columns: 3,
    stroke: 0.2pt,
    table.header[$e in E(F_1)$][$e in E(F_2)$][$e in E(F_1) Delta E(F_2)$],
    [1],[1],[0],
    [0],[1],[1],
    [1],[0],[1],
    [0],[0],[0],
  )
)

Pokud je hrana $e$ obsažena v obou faktorech, tak se vyruší.
přičemž zahrneme všechny hrany incidentní s $v$ v $F_2$ ($E_(F_2)^v$). 
Obou jich je lichý počet, proto stupeň vrcholu $v$ je sudý. Tedy:  
$
  |E_(F_1)^v| &+ |E_(F_2)^v| &=& deg_(F_1 Delta F_2)(v) \
  "liché" &+ "liché" &=& underline("sudé").
$

Pokud se všechny hrany $E_(F_1)^v$ shodují s hranami $E_(F_2)^v$, tak nezahrneme ani jednu z nich - zahrneme 0 hran (sudý počet).

Pokud si některé hrany nachází $E_(F_1)^v$ a přitom také v $E_(F_2)^v$, 
tak tyto hrany do $F_1 Delta F_2$ nezahrneme. 
Nýbrž zahrneme zbytek hran, kterých musí být sudý počet.

Víme totiž, že pokud je počet hran v $E_(F_1)^v without E_(F_2)^v$ lichý, 
tak počet hran náležící oběma faktorům,
$|E_(F_1 sect F_2)^v|$, je sudý.
Tedy hran v $E_(F_2)^v without E_(F_1)^v$ musí být lichý počet. 
$
  |E_(F_1)^v without E_(F_2)^v| &+ |E_(F_2)^v without E_(F_1)^v| &=& deg_(F_1 Delta F_2)(v) \
                        "liché" &+ "liché" &=& underline("sudé").
$
Pokud je $|E_(F_1)^v without E_(F_2)^v|$ sudé, 
tak je $|E_(F_1 Delta F_2)^v|$ liché,
tedy $|E_(F_2)^v without E_(F_1)^v|$ je sudé. 
$
  |E_(F_1)^v without E_(F_2)^v| &+ |E_(F_1)^v without E_(F_2)^v| &=& deg_(F_1 Delta F_2)(v) \
                        "sudé" &+ "sudé" &=& underline("sudé").
$

Pro: 
$
  T &= (V_T,E_T) "je strom, kde" |V_T| equiv 0 space (mod 2), \
  F_1 &= (V_T, E_F_1 subset.eq E_T), " kde" 
  forall v in V(F_1), deg_(F_1)(v) equiv 1 space (mod 2), \
  F_2 &= (V_T, E_F_2 subset.eq E_T), " kde"
  forall v in V(F_2), deg_(F_2)(v) equiv 1 space (mod 2), \
$
platí, že:
$
  forall v in V(F_1 Delta F_2), deg_(F_1 Delta F_2)(v) equiv 0 space (mod 2).
$

#admonition(
  icon-string: read("./assets/info.svg"),
  color: color.blue,
  title: "Poznámka",
)[
  Obecný vzorec pro určení sudosti a lichosti 
  stupně libovolého vrcholu $v$ v symetrické diferenci 
  faktorů $S_1$ a $S_2$ stromu $T$ je:
  $
    deg_(S_1 Delta S_2)(v) = (deg_(S_1)(v) + deg_(S_2)(v)) mod 2.
  $
]

Z toho plyne, že stupně vrcholů $F_1 Delta F_2$ jsou všechny sudé.
Můžou tedy nabývat hodnot $2k, k in NN_0$ - to je včetně nuly. 
Uvažíme-li, že vrcholy nejsou stupně~0, dostaneme vrcholy, 
které jsou nuceny mít stupeň alespoň 2. 
Pokud by měli všechny vrcholy stupeň rovno dvěma, 
takový graf by spadal do třídy grafů zvané jako cesty. 
Cesty jsou cyklické -
stromy jsou jsou acyklické -
je zde kontradikce.
Ve stromě $T$ jsme našli cyklus - není možné. 
Je zjevné, že jakýkoliv graf s vyššími stupněmi vrcholů
taktéž obsahuje cyklus.
Tedy jedinou přípustnou možností je, 
že stupně vrcholů $F_1 Delta F_2$ jsou nulové, 
tedy $F_1 Delta F_2$ je nulový graf. Z toho plyne,
že fakory $F_1$ a $F_2$ popisují stejný graf.
$
  F_1 Delta F_2 = emptyset -> F_1 = F_2
$

Došli jsme k závěru, že pro strom sudého řádu 
existuje právě jeden lichý faktor. #h(1fr) $ballot$


