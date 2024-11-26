#import "meta_data.typ"

#set text(
  size: 14pt,
)

#set page(
  margin: 1.2in
)

#align(top + right)[
  Vysoká škola báňská - Technická univerzita Ostrava \
  Fakulta elektrotechniky a informatiky
]

#v(50pt)

#align(horizon)[
  #text(size: 30pt, [
    *Diskrétní matematika*
  ])\
  #text(size: 24pt, [
    Semestrální projekt -- zadání #meta_data.assignment_number
  ])
]

#align(bottom)[
  #table(
    align: (center + horizon, center),
    columns: (auto, auto),
    rows: (auto, 3cm),
    stroke: none,
    table.header([Příklad], table.vline(), [Poznámky]),
    table.hline(),
    [1],[],
    [2],[],
  )
]

#v(40pt)

#align(bottom + left)[
  Jméno: #meta_data.student_fullname \
  Osobní číslo: #meta_data.student_identifier
  #h(1fr)  
  Datum: #datetime.today().display("[day]. [month]. [year]")
]


