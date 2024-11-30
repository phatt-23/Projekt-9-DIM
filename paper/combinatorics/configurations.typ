#import "@preview/diagraph:0.3.0"
#import "@preview/i-figured:0.2.4"
#import "@preview/oxifmt:0.2.1": strfmt
#import "@preview/alchemist:0.1.2": *
#import "@preview/codly:1.0.0": *
#import "@preview/note-me:0.3.0": *

== Různá rozmístění čísel na kostkách

Kostky $A$, $B$ a $C$ jsou rozlišitelné, například mají odlišné barvy.
Jaký je počet různých konfigurací čísel, pokud vybíráme čísla z množiny
z množiny $[1,6]$ s možností opakovaní.

Počet zpusobů, jak vybrat čtyři čísla z sešti (s možností opakování), je:
$
  C^*(6,4) = binom(9,4) = 126
$
Proto možných konfigurací čísel na třech kostkách je:
$ 
  lr([C^*(6,4)], size: #150%)^3 = 126^3 
  = underline(underline(2000376))
$<computation-of-configurations>

#heading(outlined: false, offset: 3, numbering: none)[
  *Jiná úvaha (kuličky a přehrádky)*
]

Počet různých konfigurací pro jednu kostku lze také vyjádřit jako:
$
  underbracket(binom(6,4)binom(3,3), #[a])
  + underbracket(binom(6,3)binom(3,2), #[b])
  + underbracket(binom(6,2)binom(3,1), #[c])
  + underbracket(binom(6,1)binom(3,0), #[d]) = 126
$<computation-of-configurations-extended>

Vysvětlení členů:
#enum(numbering: "a)",
  enum.item(1)[
    _Vybereme čtyři různá čísla z šesti možných._ \
    Umístíme tři oddělovače mezi čtyřmi stěnami kostky (kuličky). 
    Vzniklé čtyři přehrádky naplníme těmito vybranými čísly.
  ],
  enum.item(2)[
    _Vybereme tři čísla z šesti možných._ \
    Zvolíme dvě pozice ze tří, kam umístit dva oddělovače mezi čtyřmi stěnami. 
    Vzniklé tři přehrádky naplníme těmito čísly.
  ],
  enum.item(3)[
    _Vybereme dvě čísla z šesti možných._ \
    Zvolíme jednu ze tří pozic, kam umístíme jeden oddělovač. 
    Vzniklé dvě přehrádky naplníme těmito čísly.
  ],
  enum.item(4)[
    _Vybereme jedno číslo z šesti možných._ \
    Máme pouze jednu přehrádku, kterou naplníme tímto číslem.
  ],
)

#pagebreak()

#heading(outlined: false, offset: 3, numbering: none)[
  Enantiomorfy kostek
]

Výpočet konfigurací podle @eqt:computation-of-configurations-extended platí 
pouze za předpokladu, že nebereme v úvahu různá rozmístění pevně zvolených 
čísel na kostce. Pokud máme například 4 různá čísla, lze je na čtyřstěnnou 
kostku rozmístit dvěma různými způsoby, neboť každá konfigurace má svůj 
zrcadlový obraz, který s ní není totožný. Tento obraz se nazývá chirální 
enantiomorf 
#footnote[
  Wikipedia, _Chiralita_: #link("https://cs.wikipedia.org/wiki/Chiralita")
]. 

Podobný jev lze pozorovat v chemii u enantiomérů, 
což představuje analogii k našim kostkám.

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

Pokud bychom chtěli být zcela přesní, je třeba výpočet podle
@eqt:computation-of-configurations-extended
upravit následujícím způsobem: 
$
  underbracket(
    2 dot binom(6,4), 
    #[korekce]
  )
  + binom(6,3)binom(3,1)
  + binom(6,2)binom(3,1)
  + binom(6,1) \
$

Tento výpočet se dále rozepíše jako:
$
  2 dot 15 + 20 dot 3 + 15 dot 3 + 6 \
  = 30 + 60 + 45 + 6 = underline(141)
$

Pro tři kostky tedy bude možných konfigurací:
$ (141)^3 = underline(underline(2803221)) $
