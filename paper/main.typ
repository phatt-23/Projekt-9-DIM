#import "@preview/diagraph:0.3.0"
#import "@preview/i-figured:0.2.4"
#import "@preview/oxifmt:0.2.1": strfmt
#import "@preview/alchemist:0.1.2": *
#import "@preview/codly:1.0.0": *
#import "@preview/note-me:0.3.0": *

#show heading: i-figured.reset-counters.with(extra-kinds: ("atom",))
#show figure: i-figured.show-figure.with(extra-prefixes: (atom: "atom:"))
#show math.equation: i-figured.show-equation.with(only-labeled: true)


#show heading.where(level: 1): it => {    
  text(24pt)[#it.body]
}

// #import "@preview/cetz:0.1.2": canvas, plot
//
// #canvas(length: 1cm, {
//   plot.plot(size: (8, 6),
//     x-tick-step: none,
//     x-ticks: ((-calc.pi, $-pi$), (0, $0$), (calc.pi, $pi$)),
//     y-tick-step: 1,
//     {
//       plot.add(
//         style: plot.palette.blue,
//         domain: (-calc.pi, calc.pi), x => calc.sin(x * 1rad))
//       plot.add(
//         hypograph: true,
//         style: plot.palette.blue,
//         domain: (-calc.pi, calc.pi), x => calc.cos(x * 1rad))
//       plot.add(
//         hypograph: true,
//         style: plot.palette.blue,
//         domain: (-calc.pi, calc.pi), x => calc.cos((x + calc.pi) * 1rad))
//     })
// })

// #show: codly-init.with()
#codly(
  languages: (
    rust: (
      name: "rust",
      color: rgb("#CE412B"),
    ),
  ),
  radius: 4pt,
  zebra-fill: luma(248),
)

#show raw: set text(font: "JetBrainsMono NF", size: 8pt)

#set raw(theme: "./Material-Theme.tmTheme")
#show raw.where(block: true): it => block(
  // fill: luma(245),
  inset: 8pt,
  radius: 5pt,
  text(it)
)
// Display inline code in a small box
// that retains the correct baseline.
#show raw.where(block: false): box.with(
  fill: luma(240),
  inset: (x: 3pt, y: 0pt),
  outset: (y: 3pt),
  radius: 2pt,
)
#show raw.where(block: true): block.with(
  stroke: (
    left: 2pt + luma(230),
    // top: 2pt + luma(230),
    // bottom: 2pt + luma(230),
  )
)
// #show math.equation: set text(font: "Neo Euler")

#set text(
  lang: "cs",
  // font: "New Computer Modern",
  // font: "Latin Modern Sans",
  font: "Latin Modern Roman",
  // font: "EB Garamond",
  size: 11pt,
)
#set page(paper: "a4")

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
    _Tranzitivní kostky a faktory stromů_
    // Diskrétní matematika -- Semestrální projekt
    #h(1fr)
    #counter(page).display(
      "1/1",
      both: true,
    )
  ],
)
// #set page(
//   header: align(right)[
//     Tranzitivní kostky a faktory stromů
//   ],
// )


#set heading(numbering: "1.")

#set par(
  justify: true,
  first-line-indent: 1em,
  linebreaks: "optimized",
)

#set block(spacing: 2em)
#set par(leading: 0.8em)

#counter(page).update(1)

// Abstract
#include "./formalities/abstract.typ"
#pagebreak()

// Outline
#include "./formalities/outline.typ"
#pagebreak()

#include "./formalities/intro.typ"
#pagebreak()

// Combinatorics
#include "./combinatorics/combinatorics.typ"

// Graph Theory
#include "./graph-theory/graph_theory.typ"

#bibliography("combinatorics/bibl.yml")



