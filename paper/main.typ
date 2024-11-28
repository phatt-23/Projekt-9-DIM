#import "@preview/diagraph:0.3.0"
#import "@preview/i-figured:0.2.4"
#import "@preview/oxifmt:0.2.1": strfmt
#import "@preview/alchemist:0.1.2": *
#import "@preview/codly:1.0.0": *
#import "@preview/note-me:0.3.0": *

#show: codly-init.with()
#codly(
  languages: (
    rust: (
      name: "Rust",
      color: rgb("#CE412B"),
    ),
  ),
  radius: 4pt,
  zebra-fill: luma(248),
)

#show raw: set text(font: "JetBrainsMonoNL NF", size: 8pt)
#set text(
  lang: "cs",
  // font: "New Computer Modern",
  font: "Latin Modern Sans",
  // font: "Latin Modern Roman",
  size: 12pt,
)
#set page(paper: "us-letter")

#include "./title.typ"

// Setting Up Paper
#set page(
  fill: none,
  margin: (
    left: 1.2in, 
    right: 1.2in, 
    top: 1in
  ),
  footer: context
  [
    Diskrétní matematika -- Semestrální projekt
    #h(1fr)
    #counter(page).display(
      "1/1",
      both: true,
    )
  ],
)


#set heading(numbering: "1.")

#set par(
  justify: true,
  first-line-indent: 1em,
  linebreaks: "optimized",
)

#set page(
  header: align(right)[
    Kombinatorika a Teorie Grafů: Analýza kostek a faktorů stromů
  ],
)

// Abstract
#place(
  top + center,
  float: true,
  clearance: 2em,
)[
  #par(justify: false)[
    #text([*Abstrakt*], size: 14pt) \
    Tato práce se zaměřuje na dvě matematické úlohy 
    z oblasti kombinatoriky a teorie grafů. 
    První část se věnuje analýze netranzitivních 
    vlastností čtyřstěnných kostek a výpočtu 
    pravděpodobností jejich vzájemných vítězství. 
    Navíc zkoumá celkový počet možných konfigurací 
    čísel na kostkách a při daných pravidlech 
    maximalizuje pravděpodobnotí jejich vztahů. 
    Druhá část se zabývá důkazem existence jednoznačného 
    faktoru ve stromech se sudým počtem vrcholů, 
    kde všechny vrcholy faktoru mají lichý stupeň. 
  ]
]
// Outline

#outline()

#pagebreak()

= Úvod

V této práci se zaměřuji
na dvě konkrétní úlohy. 
První úloha pojednává o
na kombinatorických vlastnostech
netranzitivních kostek, které 
vykazují překvapivé neintuitivní 
pravděpodobnostní vztahy.
Druhá úloha pochází z 
oblasti teorie grafů.
Zabývá se faktory 
stromů se sudým počtem vrcholů 
a hledáním jednoznačného faktoru 
s lichými stupni vrcholů. 

Kombinatorická část práce se zabývá 
výpočty pravděpodobností mezi kostkami,
rozmístěními čísel na kostkách
a maximalizací pravděpodobnostní 
hranice při splnění daných podmínek. 

V části teorie grafů se pak 
zabývám důkazem existence 
faktoru s lichými stupněmi 
ve stromech se 
sudým počtem vrchlů.
Dokážu také jednoznačnost tohoto faktoru.


// Combinatorics
#include "./combinatorics/combinatorics.typ"

#pagebreak()

// Graph Theory
#include "./graph_theory.typ"

#bibliography("combinatorics/bibl.yml")
