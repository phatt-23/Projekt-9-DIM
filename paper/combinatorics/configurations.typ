#import "@preview/diagraph:0.3.0"
#import "@preview/i-figured:0.2.4"
#import "@preview/oxifmt:0.2.1": strfmt
#import "@preview/alchemist:0.1.2": *
#import "@preview/codly:1.0.0": *
#import "@preview/note-me:0.3.0": *

== Různá rozmístění čísel na kostkách

Kostky $A$, $B$ a $C$ jsou rozlišitelné, např. mají jiné barvy. 
Kolik existuje různých konfigurací čísel, když čísla vybíráme
z množiny $[1,6]$ s možností opakovaní.

Zpusobů jak vybrat čtyři čísla z sešti (s možností opakování) je:
$
  C^*(6,4) = binom(9,4) = 126
$
Proto možných konfigurací rozmístění čísel na třech kostkách je:
$ 
  lr([C^*(6,4)], size: #150%)^3 = 126^3 
  = underline(underline(2000376))
$<computation-of-configurations>

#heading(outlined: false, offset: 3, numbering: none)[
  *Jiná úvaha (kuličky a přehrádky)*
]

Výpočet různých konfigurací pro jednu kostku, můžeme také zapsat jako:
$
  underbracket(binom(6,4)binom(3,3), #[a])
  + underbracket(binom(6,3)binom(3,2), #[b])
  + underbracket(binom(6,2)binom(3,1), #[c])
  + underbracket(binom(6,1)binom(3,0), #[d]) = 126
$<computation-of-configurations-extended>

#enum(numbering: "a)",
  enum.item(1)[
    Vybereme 4 různá čísla z 6 možných.
    Umístíme 3 oddělovače mezi 4 stěnami kostky.
    Vzniklé 4 přehrádky naplníme těmito čtyřmi čísly.
  ],
  enum.item(2)[
    Vybereme 3 čísla z 6 možných.
    Zvolíme dvě pozice ze tří, kam umístit 
    2 oddělovače mezi 4 stěnami.
    Vzniklé 3 přehrádky naplníme těmito třemi čísly.
  ],
  enum.item(3)[
    Vybereme dvě čísla z šesti možných. 
    Zvolíme jednu ze tří pozic, kam umístíme jeden oddělovač.
    Vznikle 2 přehrádky naplníme těmito dvěma čísly.
  ],
  enum.item(4)[
    Vybereme 1 číslo z 6 možných. 
    Máme jenom 1 přehrádku, 
    kterou naplníme oným číslem.
  ],
)


#heading(outlined: false, offset: 3, numbering: none)[
  Enantiomorfy kostek
]

@eqt:computation-of-configurations 
a @eqt:computation-of-configurations-extended 
platí ale pouze tehdy, 
nebereme-li v úvahu různá 
rozmístění pevně zvolených čísel na kostce.
Jestliže máme 4 různá čísla, 
tak jsme schopni tyto čísla 
na čtyrstěnnou kostku 
umístit dvěma různými způsoby.
Neboť pro čtyřstěnnou kostku (se čtyřmi různými 
čísly) existuje její zrcadlový obraz, 
který s ní není identický. 
Tento obraz tzv. představuje chirální enantiomorf 
#footnote[https://cs.wikipedia.org/wiki/Chiralita]
kostky. Ty jsou také vůči sobě izomorfní.

Příklad z chemie:
#figure(
  grid(
    columns: (1fr, 0.3fr, 1fr),
    align: (right, center, left),
    skeletize({
      molecule("C")
      branch(relative: 90deg,{
        cram-dashed-left(base-length: 6pt)
        molecule("H")
      })
      branch(relative: 210deg,{
        single()
        molecule("HOOC")
      })
      branch(relative: -50deg,{
        single()
        molecule("CH_3")
      })
      branch(relative: 10deg,{
        cram-filled-left(base-length: 4pt)
        molecule("NH_2")
      })
    }),
    [],
    skeletize({
      molecule("C")
      branch(relative: 90deg,{
        cram-dashed-left(base-length: 6pt)
        molecule("H")
      })
      branch(relative: -30deg,{
        single()
        molecule("COOH")
      })
      branch(relative: 230deg,{
        single()
        molecule("H_3C")
      })
      branch(relative: 170deg,{
        cram-filled-left(base-length: 4pt)
        molecule("H_2N")
      })
    }),
  ),
  caption: [L-alanin a D-alanin (enantioméry)]
)

Pokud bychom tedy chtěli být zcela přesní, 
tak @eqt:computation-of-configurations-extended (důvod proč byla zahrnuta)
upravíme následovně: 
$
  underbracket(
    2 dot binom(6,4), 
    #[korekce]
  )
  + binom(6,3)binom(3,1)
  + binom(6,2)binom(3,1)
  + binom(6,1) = \
  = 2 dot 15 + 20 dot 3 + 15 dot 3 + 6 = \ 
  = 30 + 60 + 45 + 6 = underline(141)
$

Pro tři kostky bude možných konfigurací 
$(141)^3 = underline(underline(2803221))$.
