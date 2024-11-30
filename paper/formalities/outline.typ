#import "@preview/diagraph:0.3.0"
#import "@preview/i-figured:0.2.4"
#import "@preview/oxifmt:0.2.1": strfmt
#import "@preview/alchemist:0.1.2": *
#import "@preview/codly:1.0.0": *
#import "@preview/note-me:0.3.0": *
#import "@preview/outrageous:0.1.0"

#show outline.entry: outrageous.show-entry.with(
  ..outrageous.presets.typst,
  font-style: ("italic", auto),
  fill: (
    none,
    line(length: 100%, stroke: gray + .5pt)
  ),
)

#show outline.entry.where(
  level: 1
): it => {
  v(12pt, weak: true)
  strong(it)
}

#outline(
  indent: auto,
  title: box(
    inset: (bottom: 0.8em),
    text[Obsah],
  ),
)


