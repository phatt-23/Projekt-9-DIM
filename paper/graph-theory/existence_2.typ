#import "@preview/diagraph:0.3.0"
#import "@preview/i-figured:0.2.4"
#import "@preview/oxifmt:0.2.1": strfmt
#import "@preview/alchemist:0.1.2": *
#import "@preview/codly:1.0.0": *
#import "@preview/note-me:0.3.0": *
#import "@preview/cetz:0.3.0"



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
Vybereme libovolný vrchol $v_p in V(T)$, 
kde $deg_T (v_p) > 1$ (tj. nebereme listy), a výjmeme ho z grafu. 
Výsledkem je graf $T - {v_p}$, jehož komponenty, 
které jsou rovněž stromy, označíme jako: 
$ 
  K_1, K_2, dots, K_(deg_T (v_p)) 
$
Hranu, která spojuje vrchol $v_p$ s komponentou $K_i$, označíme jako $e_i$.


#figure(
  diagraph.raw-render(```
      graph {
        layout=fdp;
        rankdir=LR;
        labelloc=b; 
        fontsize=14;
        size="8,5";

        node[shape=circle];
        v
        node[style="dashed"]
        v -- K_sec_last [xlabel="e_(i-1)", style="dashed"];
        v -- K_i [xlabel="e_i", style="dashed"];
        node[style="full"]
        v -- K_2 [xlabel="e_2"];
        v -- K_4 [xlabel="e_4"];
        v -- K_3 [xlabel="e_3"];
        v -- K_1 [xlabel="e_1"];
      }
  ```, labels: (
    "v": $v_p$,
    "K_1": [#h(3.5em) $K_1$ #h(3.5em)],
    "K_3": [#h(2em) $K_3$ #h(2em)],
    "K_2": [#h(1em) $K_2$ #h(1em)],
    "K_4": [#h(3em) $K_4$ #h(3em)],
    "K_sec_last": [#h(1em) $K_(i-1)$ #h(1em)],
    "K_i": [#h(1em) $K_i$ #h(1em)],
  )),
  caption: [Strom $T$ s vyznačeným vrcholem $v_p$],
)

#pagebreak()

#heading(outlined: false, offset: 2, numbering: none)[
  #text(weight: "regular")[ _Rozdělení komponent_ ]
]

Komponenty si rozdělíme do dvou množin $S$ a $L$ tak, 
aby $S$ obsahovala komponenty sudého řádu,
zatímco $L$ obsahovala komponenty lichého řádu:
$
  S = lr({K_i : |V(K_i)| equiv 0 }, size: #150%) quad 
  L = lr({K_i : |V(K_i)| equiv 1 }, size: #150%) quad (mod 2)
$



#heading(outlined: false, offset: 2, numbering: none)[
  #text(weight: "regular")[ _Analýza počtu vrcholů_ ]
]

Počet vrcholů grafu $T - {v_p}$ je lichý:
$
  lr(|V(T - {v_p})|, size: #150%) equiv 1 quad (mod 2)
$
Dále platí:
$
  // T - {v_p} &= (xor.big_(K in S) K) xor (xor.big_(K in L) K) \
  V(T - {v_p}) &= (xor.big_(K in S) V(K)) xor (xor.big_(K in L) V(K)) \
$
$
  |V(T - {v_p})| &= sum_(K in S) |V(K)| + sum_(K in L) |V(K)| equiv 1 quad (mod 2)
$
kde znak $xor$ představuje operátor symetrického rozdílu
#footnote[
  Wikipedia, _Symetrický rozdíl_: #link("https://en.wikipedia.org/wiki/Symmetric_difference")
]
dvou množin.

Liché číslo lze získat pouze součtem sudého a lichého čísla:
$
  underbracket(2t, #[sudé]) 
  + underbracket((2k + 1), #[liché]) 
equiv 1 quad (mod 2), quad "pro" k,t in ZZ
$

Jedna z množin tedy musí mít lichý součet počtu vrcholů svých komponent, 
přičemž pro množinu $S$ platí:
$
  sum_(K in S) |V(K)| equiv 0 quad (mod 2)
$
protože suma počtů vrcholů komponent v $S$ je vždy sudá.
// $
//   forall K in S : space |V(K)| &= 2k quad "pro" k in NN \
//   p &= |S| \
//   p(2k) equiv 0 space (mod 2)
//   quad &=> quad
//   p = NN_0
// $
Z čehož plyne:
$
  sum_(K in L) |V(K)| equiv 1 space (mod 2)
$
tedy, že suma vrcholů všech komponent v $L$ je lichá.

#pagebreak()

#heading(outlined: false, offset: 2, numbering: none)[
  #text(weight: "regular")[ _Počet komponent v $L$_ ]
]

Součet vrcholů komponent v $S$ je vždy sudý.
Naopak součet vrcholů komponent v $L$ je vždy lichý.
To znamená, že množina $L$ obsahuje lichý počet komponent:
$
  |L| equiv 1 quad (mod 2)
$
neboť jediný způsob, kterým získáme liché číslo součtem lichých čísel (počet vrcholů komponenty v $L$), 
je, když máme lichý počet (mohutnost množiny $L$) lichých čísel.
$
  forall K in L : space
  |V(K)| &= 2k + 1 quad "pro" k in NN \
  p &= |L|
$
$
  p(2k + 1) &equiv 1 quad (mod 2) \
  2p k + p &equiv 1 quad (mod 2) \
  p &equiv 1 quad (mod 2) \
$
// $
//   p = 2t + 1 quad "kde" t in ZZ
// $

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
zpět výjmutý vrchol $v_p$ (včetně hrany $e_i$),
čímž získáme stromy $K + {v_p}$ sudého řádu. 
Na tento strom aplikujeme indukční krok.
Vrchol $v_p$ bude mít stupeň roven počtu komponent v $L$:
$
  deg(v_p) = |L| equiv 1 quad (mod 2)
$

Komponentám v $S$ nepřidáváme vrchol $v_p$, 
neboť už jsou sudého řádu.
I na ně aplikujeme indukční krok.


Na konci indukce (rekurze) bude každý vrchol $v in V(T)$ lichého stupně,
protože:
$ 
  deg(v) = |L|
$
přičemž mohutnost $L$ je v každém kroku lichá. 
Tím je existence faktoru prokázána. #h(1fr) $ballot$


#heading(outlined: false, offset: 2, numbering: none)[
  Ukázka algoritmu
]

#v(9em)
#figure([
  #diagraph.raw-render(
    ```
      graph Tree {
        layout=neato;
        node[shape=circle]
        1 -- 9;
        1 -- 18;
        1 -- 2;
        1 -- 3;

            2 -- 5;
            2 -- 4;
            
            3 -- 6;
            3 -- 7;
            3 -- 8;
            3 -- 14;

                14 -- 15;
                14 -- 16;
                14 -- 17;

            9 -- 10;
            9 -- 11;
            9 -- 12;
            9 -- 13;
    }
    ```,
    labels: (
      "1": [$v_p$],
      "2": [3],
      "3": [5],
      "4": [1],
      "5": [1],
      "6": [1],
      "7": [1],
      "8": [1],
      "9": [5],
      "10": [1],
      "11": [1],
      "12": [1],
      "13": [1],
      "14": [4],
      "15": [1],
      "16": [1],
      "17": [1],
      "18": [1],
    )
  )
], caption: [Strom $T$ s vyznačenými stupněmi vrcholů a vybraným vrcholem $v_p$])

#pagebreak()
#figure([
  #diagraph.raw-render(
    ```
      graph Tree {
        layout=fdp;
        penwidth=1;
        style=dashed;
        // Nodes
        node[shape=circle]
        node [width=0.3, height=0.3, fontsize=10];
        edge [penwidth=0.5];

        // Exclude node 1 from the tree
        edge[penwidth=2]
        1 -- 9;
        1 -- 18;
        1 -- 2;
        edge[style=dashed, penwidth=1]
        1 -- 3;

        // Containers

        subgraph cluster_Container1 {
            label="K_1";
            color=blue;
            edge[style=full, penwidth=2]
            2 -- 5 [penwidth=2];
            2 -- 4 [penwidth=2];
            
            subgraph cluster_Container1_1 {
                label="K_(1,1)";
                4;
            }
            subgraph cluster_Container1_2 {
                label="K_(1,2)";
                5;
            }
        }

        subgraph cluster_Container2 {
            label="K_2";
            color=green;
            edge[style=full, penwidth=2]
            3 -- 6 [penwidth=2];
            3 -- 7 [penwidth=2];
            3 -- 8 [penwidth=2];
            edge[style=dashed, penwidth=1]
            3 -- 14;

            subgraph cluster_Container2_1 {
                label="K_(2,1)";
                6;
            }
            subgraph cluster_Container2_2 {
                label="K_(2,2)";
                7;
            }
            subgraph cluster_Container2_3 {
                label="K_(2,3)";
                8;
            }
            subgraph cluster_Container2_4 {
                label="K_(2,4)";
                edge[style=full, penwidth=2]
                14 -- 15 [penwidth=2];
                14 -- 16 [penwidth=2];
                14 -- 17 [penwidth=2];
                subgraph cluster_Container2_4_1 {
                    label="K_(2,4,1)";
                    15;
                }
                subgraph cluster_Container2_4_2 {
                    label="K_(2,4,2)";
                    16;
                }
                subgraph cluster_Container2_4_3 {
                    label="K_(2,4,3)";
                    17;
                }
            }
        }

        subgraph cluster_Container3 {
            label="K_3";
            color=red;
            edge[style=full, penwidth=2]
            9 -- 10 [penwidth=2];
            9 -- 11 [penwidth=2];
            9 -- 12 [penwidth=2];
            9 -- 13 [penwidth=2];

            subgraph cluster_Container3_1 {
                label="K_(3,1)";
                10;
            }
            subgraph cluster_Container3_2 {
                label="K_(3,2)";
                11;
            }
            subgraph cluster_Container3_3 {
                label="K_(3,3)";
                12;
            }
            subgraph cluster_Container3_4 {
                label="K_(3,4)";
                13;
            }
        }

        subgraph cluster_Container4 {
            label="K_4";
            color=orange;
            18;
        }
    }
    ```,
    labels: (
      "1": [$v_p$],
      "2": [3],
      "3": [3],
      "4": [1],
      "5": [1],
      "6": [1],
      "7": [1],
      "8": [1],
      "9": [5],
      "10": [1],
      "11": [1],
      "12": [1],
      "13": [1],
      "14": [3],
      "15": [1],
      "16": [1],
      "17": [1],
      "18": [1],
    )
  )
], caption: [Rekurzivní konstrukce lichého faktoru stromu $T$])

#pagebreak()

#v(7em)
#figure([
  #diagraph.raw-render(
    ```
      graph Tree {
        layout=neato;

        node[shape=circle]
        1 -- 9;
        1 -- 18;
        1 -- 2;
        // 1 -- 3 [penwidth=10];

            2 -- 5;
            2 -- 4;
            
            3 -- 6;
            3 -- 7;
            3 -- 8;
            // 3 -- 14 [penwidth=10];

                14 -- 15;
                14 -- 16;
                14 -- 17;

            9 -- 10;
            9 -- 11;
            9 -- 12;
            9 -- 13;
    }
    ```,
    labels: (
      "1": [$v_p$],
      "2": [3],
      "3": [3],
      "4": [1],
      "5": [1],
      "6": [1],
      "7": [1],
      "8": [1],
      "9": [5],
      "10": [1],
      "11": [1],
      "12": [1],
      "13": [1],
      "14": [3],
      "15": [1],
      "16": [1],
      "17": [1],
      "18": [1],
    )
  )
], caption: [Nalezený lichý faktor stromu $T$])
