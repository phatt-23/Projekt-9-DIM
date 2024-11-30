#import "@preview/diagraph:0.3.0"
#import "@preview/i-figured:0.2.4"
#import "@preview/oxifmt:0.2.1": strfmt
#import "@preview/alchemist:0.1.2": *
#import "@preview/codly:1.0.0": *
#import "@preview/note-me:0.3.0": *
#import "@preview/outrageous:0.1.0"

#show outline.entry: outrageous.show-entry.with(
  // the typst preset retains the normal Typst appearance
  ..outrageous.presets.typst,
  // we only override a few things:
  // level-1 entries are italic, all others keep their font style
  font-style: ("italic", auto),
  // no fill for level-1 entries, a thin gray line for all deeper levels
  fill: (
    // line(length: 100%, stroke: gray + .5pt), 
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

// #outline(target: figure.where(kind: image))

// #outline(target: figure.where(kind: code))

