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




#heading(outlined: false, offset: 2, numbering: none)[
  Důkaz sporem
]

Předpokladejme, že existují dva liché faktory grafu $G$.
Mějme faktory $F_A, F_B$, u kterých tvrdíme, 
že jsou od sebe odlišné. Tedy musí platit,
že mají alespoň jednu hranu, která náleží 
pouze jim a ne druhému.
$
  exists e in E(F_A), e in.not E(F_B)
$

 
Vytvoříme nový graf $G$. 
Ten obsahuje všechny vrcholy stromu $T$
a obsahuje symetrický rozdíl hran faktorů $F_A$ a $F_B$.
Tedy obsahuje ty hrany, které se objevují
právě v jednom z faktorů, nikoliv v obou.
$
  G = lr((V(T), E(F_A) xor E(F_B)), size: #150%)
$
Výhodněji zapíšeme jako:
$
  G = F_A xor F_B
$
Pokud je graf $G$ nulovým grafem:
$
  G = lr((V(T), emptyset), size: #150%)
$
tak $E(F_A) = E(F_B)$, z čehož plyne, že $F_A = F_B$.

#heading(outlined: false, offset: 2, numbering: none)[
  #text(weight: "bold")[ 
    _Sudost a lichost stupní vrcholů $v in V(G)$_
  ]
]

Sudost a lichost stupně vrcholů grafu $G$ závisí na tom, 
jaké hrany z faktorů $F_A$ a $F_B$ budou zahrnuty do vysledného grafu $G$.
Množinu hran faktoru $F_X$, které jsou incidentní s vrcholem $v$ zapíšeme:
$
  E_(v) (F_X)
$

Při symetrickém rozdílu hran faktorů $F_A$ a $F_B$, mohou nastat tyto případy:

#enum(numbering: "a)",
  enum.item(1)[
    Faktory $F_A$ a $F_B$ nesdílejí jedinou hranu:
    $
      E(F_A) sect E(F_B) = nothing
    $
    Každý vrchol $v$ grafu $G$ je sudého stupně, neboť: 
    $
      |E_v (F_A)| = |E_v (F_B)| &equiv 1 quad (mod 2) \
      deg_G (v) = |E_v (F_B)| + |E_v (F_A)| &equiv 0 quad (mod 2)
    $
  ],
  enum.item(2)[
    Pokud se všechny hrany faktorů $F_A$ a $F_B$ shodují:
    $
        E(F_A) = E(F_B)
        quad <=> quad 
        E(F_A) xor E(F_B) = emptyset 
    $
    tak graf $G$ je nulový a pro $forall v in V(G)$ 
    platí $deg_G (v) = 0$, jsou všechny sudého stupně.
  ],
  enum.item(3)[
    Pokud se některé hrany náchazejí v obou faktorech $F_A$ a $F_B$:
    $
      exists e in E(F_A), e in E(F_B) 
      quad <=> quad 
      E(F_A) sect E(F_B) eq.not emptyset
    $
    tak jsou všechny vrcholy grafu $G$ také sudého stupně.
    což lze dokázat. Nejdříve si však zjednodušme syntaxi
    touto substitucí: 
    $
      A = E_v (F_A) \
      B = E_v (F_B)
    $
    Víme, že:
    $
      |A| = |B| equiv 1 quad (mod 2)
    $

    Pokud je počet hran ve sjednocení množin $A$ a $B$ sudý, 
    tak stupeň $v$ je sudý:
    $
      |A sect B| equiv 0 
      quad => quad
      |A without B| = |B without A| equiv 1 quad &(mod 2) \
      deg_G (v) = |A without B| 
                + |B without A| equiv 0 quad &(mod 2)
    $

    Pokud je počet hran ve sjednocení množin $A$ a $B$ lichý, 
    tak stupeň $v$ je taktéž sudý:
    $
      |A sect B| equiv 1 
      quad => quad
      |A without B| = |B without A| equiv 0 quad &(mod 2) \
      deg_G (v) = |A without B| 
                + |B without A| equiv 0 quad &(mod 2)
    $
  ],
)

Došli jsme k závěru, že vrcholy v grafu $G$ budou vždy sudého stupně:
$
  forall v in V(G), deg_G (v) = 2k quad "pro" k in NN_0
$

Pokud $k = 0$ tak $F_A = F_B$. 
Uvažujeme-li, že $k > 0$, dostaneme vrcholy stupně alespoň 2. 
Minimální graf, kde jsou všechny vrcholy alespoň druhého stupně,
je graf cesty.
Cesty jsou cyklické - stromy jsou jsou acyklické - je zde kontradikce. 
Nemůžeme z acyklického stromu získat cyklický graf.

Tedy jedinou přípustnou možností je, 
že fakory $F_A$ a $F_B$ popisují jeden a ten samý graf.
Jednoznačnost faktoru $F$ je dokázána.
#h(1fr) $ballot$




