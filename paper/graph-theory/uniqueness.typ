#import "@preview/diagraph:0.3.0"
#import "@preview/i-figured:0.2.4"
#import "@preview/oxifmt:0.2.1": strfmt
#import "@preview/alchemist:0.1.2": *
#import "@preview/codly:1.0.0": *
#import "@preview/note-me:0.3.0": *

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
  icon-string: read("./../assets/info.svg"),
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
