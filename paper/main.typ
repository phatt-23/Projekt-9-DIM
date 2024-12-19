#import "@preview/diagraph:0.3.0"
#import "@preview/i-figured:0.2.4"
#import "@preview/oxifmt:0.2.1": strfmt
#import "@preview/alchemist:0.1.2": *
#import "@preview/codly:1.0.0": *
#import "@preview/note-me:0.3.0": *
#import "@preview/cetz:0.3.1"


// Figures
#show heading: i-figured.reset-counters.with(extra-kinds: ("atom",))
#show figure: i-figured.show-figure.with(extra-prefixes: (atom: "atom:"))
#show math.equation: i-figured.show-equation.with(only-labeled: true)

// Link Settings
#show link: set text(fill: rgb(0, 0, 100)) // make links blue
#show link: underline // underline links

// Heading Settings
#show heading.where(level: 1): it => {    
  text(2em)[#it.body]
}
#show heading.where(level: 2): set text(size: 1.5em)
#show heading.where(level: 3): set text(size: 1.2em)
#set heading(numbering: "1.")

// Raw Blocks
#set raw(theme: "./Material-Theme.tmTheme")
#show raw: set text(font: "JetBrainsMono NF", size: 8pt)
#show raw.where(block: true): it => block(
  inset: 8pt,
  radius: 5pt,
  text(it),
  stroke: (
    left: 2pt + luma(230),
  )
)
#show raw.where(block: false): box.with(
  fill: luma(240),
  inset: (x: 3pt, y: 0pt),
  outset: (y: 3pt),
  radius: 2pt,
)

// Font and Language
#set text(
  lang: "cs",
  font: "Latin Modern Roman",
  size: 11pt,
)

// Paper Settings
#set page(paper: "a4")

#include "./formalities/title.typ"

// Paper Settings
#set page(
  fill: none,
  margin: (
    left: 1.3in, 
    right: 1.2in, 
  ),
  footer: context
  [
    _Tranzitivní kostky a faktory stromů_
    #h(1fr)
    #counter(page).display(
      "1/1",
      both: true,
    )
  ],
)

// Paragraph Settings
#set par(
  justify: true,
  first-line-indent: 1em,
  linebreaks: "optimized",
)

// Text margins
#set block(spacing: 2em)
#set par(leading: 0.8em)

// Start the Page Counter
#counter(page).update(1)

// Abstract
#v(6em)
#include "./formalities/abstract.typ"
#pagebreak()

// Outline
#v(6em)
#include "./formalities/outline.typ"
#pagebreak()

// Intro
#v(6em)
#include "./formalities/intro.typ"
#pagebreak()

// Combinatorics
#include "./combinatorics/combinatorics.typ"

// Graph Theory
#include "./graph-theory/graph_theory.typ"

// Not even 
// #bibliography("combinatorics/bibl.yml")



