#import "@preview/diagraph:0.3.0"
#import "@preview/i-figured:0.2.4"
#import "@preview/oxifmt:0.2.1": strfmt
#import "@preview/alchemist:0.1.2": *
#import "@preview/codly:1.0.0": *
#import "@preview/note-me:0.3.0": *

#set page(
  header: align(right)[
    _Teorie grafů_
  ],
)

= Teorie grafů

Mějme strom $T$ se sudým počtem vrcholu (je sudého řádu).
Cílem je ukázat, že pro $T$ existuje faktor $F$, kde všechny 
vrcholy grafu $F$ jsou lichého stupně (budeme říkat lichý faktor).

#include "./existence.typ"

#include "./uniqueness.typ"

