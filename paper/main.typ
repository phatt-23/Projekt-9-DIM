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

#include "./title.typ"

// Setting Up Paper
#set heading(numbering: "1.")
#set page(
  paper: "us-letter",
  fill: none,
  margin: (
    left: 1.2in, 
    right: 1.2in, 
    top: 1in
  ),
  footer: context
  [
    Diskrétní matematika -- semestrální projekt
    #h(1fr)
    #counter(page).display(
      "1/1",
      both: true,
    )
  ],
)

#set par(
  justify: true,
  first-line-indent: 1em,
  linebreaks: "optimized",
)

// Abstract
#place(
  top + center,
  float: true,
  clearance: 2em,
)[
  #par(justify: false)[
      #text([*Abstrakt*], size: 14pt) \
      #lorem(100) 
  ]
]
// Outline
#v(3em)
#outline()

// Combinatorics
#include "./combinatorics.typ"
#pagebreak()
// Graph Theory
#include "./graph_theory.typ"

