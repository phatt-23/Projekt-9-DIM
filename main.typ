#import "@preview/diagraph:0.3.0"
#import "@preview/i-figured:0.2.4"
#import "@preview/oxifmt:0.2.1": strfmt
#import "@preview/alchemist:0.1.2": *

#set text(
  lang: "cs",
  // font: "Inria Sans",
  // font: "New Computer Modern",
  font: "Latin Modern Sans",
  // font: "Latin Modern Roman",
  size: 12pt,
)

#set page(paper: "us-letter")
#set heading(numbering: "1.")

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
    Diskrétní matematika -- semestrální projekt
    #h(1fr)
    #counter(page).display(
      "1/1",
      both: true,
    )
  ],
)

// #let graph_four_side(A, B, C, D) = {
//   let body;
//   body += "digraph {\n"
//   body += "  layout=twopi;\n"
//   body += "  rankdir=LR;\n"
//   body += "  labelloc=b;\n"
//   body += "  fontsize=14;\n"
//   body += "  node[shape=circle];\n"
//   body += strfmt("  {} -> {};\n", A, B);
//   body += strfmt("  {} -> {};\n", A, C);
//   body += strfmt("  {} -> {};\n", A, D);
//   body += strfmt("  {} -> {};\n", B, C);
//   body += strfmt("  {} -> {};\n", B, D);
//   body += strfmt("  {} -> {};\n", C, D);
//   body += "}";
//   diagraph.render(body)
// }

// #graph_four_side("Alpha","Beta","Gamma","Delta")

= Combinatorics
Let there be four-sided dice $A, B$ and $C$ and with numbers defined as:

$
  A = {1,4,4,4} \
  B = {2,2,5,5} \
  C = {3,3,3,6}. \
$

Given two dice $X$ and $Y$, 
when we throw them simultaneously 
and observe the number,
we say X is better than Y 
if and only if X has a higher
probability of having a greater 
number than Y. 
In other words X wins over Y and 
we denote this as $P(X > Y)$,
the probability of $X$ winning over $Y$.

Prove that $P(B > A)$, $P(C > B)$ and $P(A > C)$.

== Proof of $P(B > A)$
=== First solution
The sample space $Omega$ is every combination of B's numbers with A's numbers.

$
  Omega_(B,A) = lr([ {a,b} : b in B, a in A ], 
  size: #150%) \
$
$
  Omega_(B,A) = lr([
    &{2,1}, {2,1}, {5,1}, {5,1}, \
    &{2,4}, {2,4}, {5,4}, {5,4}, \
    &{2,4}, {2,4}, {5,4}, {5,4}, \
    &{2,4}, {2,4}, {5,4}, {5,4}
  ], size: #150%) \
$

The size of the space is $|Omega| = 16$. 
From the expanded $Omega$ we see that clearly
the the number of events where
B wins is higher than the number of 
events in which it loses.
That is:

$
  P(B > A) = (2 + 4 dot 2)/(|Omega|) 
           = 10/16 = 0.625.
$

We see that B's chance of winning is 
62.5% which is higher than 50% meaning 
it's better. $ballot$

=== Second solution 
Sample space is still the same $Omega$.
If A is 1, B wins no matter what.
If A is 4, B wins if 5 is thrown.
$
  A &= 1": " B "wins in all 4 cases"  
      & -> & 4 "events"\
  A &= 4": " B "wins, if it's 5 (2 of 4 cases)" 
      & -> & 6 "events"\
$

The reason behind the numbers: 

- #[
$P_(Omega)(A=1) = 1/4$ which then means that
number of events where $A=1$ is $1/4|Omega|=4$.
B wins in all of them.
]

// $
//   P(B|A = 1) = (P(A = 1|B) dot P(B))/(P(A = 1))
//     = (1/4 dot 1)/(1/4) 
//     = 1/4 dot 4/1 = 1
// $

- #[
$P_(Omega)(not A=1) = 3/4$ meaning the number of
events where $not (A=1)$ is $3/4|Omega|=12$ 
or one could say $3 dot 4 = 12$ (three non-1s times 
zipped with elements from dice $B$). 
Out of the 12 cases, 
in half of them $A$ is winning and 
in the other half $B$ is winning. 
That is there are 6 events where $B$ winning
when A is not 1.
]

$
  P(B > A) = (4 + 6)/(|Omega|)
           = 10/16 = 0.625.
$

// === Comparison with the Bayesian Theorem
// $
//   P(A|B) = (P(B|A) dot P(A))/P(B)
// $
// $
//   P(X > Y) = (P(X > Y = y))/(|Omega_(X,Y)|)
// $

P(B > A) is greater then $1/2$,
therefore B is better than A. $ballot$


The remaining $P(C > B)$ and $P(A > C)$ can be done analogously.

== Proof of $P(C > B)$
=== Solution
Dice C and B are defined as:
$
  B = {2,2,5,5} \
  C = {3,3,3,6}. \
$
The sample space here is:
$
  Omega_(C,B) = lr([ {c,b} : c in C, b in B ],
  size: #150%)
$
$
  Omega_(C,B) = lr([
    & {3,2}, {3,2}, {3,5}, {6,5}, \
    & {3,2}, {3,2}, {3,5}, {6,5}, \
    & {3,2}, {3,2}, {3,5}, {6,5}, \
    & {3,2}, {3,2}, {3,5}, {6,5}
  ], size: #150%).
$

If $C=3$, then B will win $1/2$ of a time, 
meaning C will win $1/2$ of the time.
$
  P(B > C=3) = 1/2 
  space |-> space
  P(C=3 > B) = 1/2 
$
The number of outcomes where $C=3$ is:
$
  lr(| lr([
    {c,b} in Omega_(C,B) : c = 3 
  ], size: #150%) |, size: #150%) 
  = 3 dot 4 = 12.
$

If C is not 3, it is 6.
It that case it will win 
every time.
$
  P(B > C=6) = 0 space |-> space
  P(C=6 > B) = 1
$
$
  lr(| lr([
    {c,b} in Omega_(C,B) : not (b = 3)
  ], size: #150%) |, size: #150%) 
  = 1 dot 4 = 4
$
That means C will win over B with the probability of:
$
  P(C > B) = (1/2 12 + 4)/(Omega_(C,B)) 
           = (6 + 4)/16
           = 10/16 = 5/8 = 0.625
$
$ballot$


== Proof of $P(A > C)$
=== First method
The sample space here is:
$
  Omega_(A,C) = lr([{a,c} : a in A, c in C
  ], size: #150%).
$
$
  Omega_(A,C) = lr([
    & {1,3}, {1,3}, {1,3}, {1,6}, \
    & {4,3}, {4,3}, {4,3}, {4,6}, \
    & {4,3}, {4,3}, {4,3}, {4,6}, \
    & {4,3}, {4,3}, {4,3}, {4,6}
  ], size: #150%).
$

From sheer observation of $Omega_(A,C)$ we 
conclude the number of outcomes where A is 
victorious.
$
  P(A > C) = (9)/(|Omega_(A,C)|) = 9/16 = 0.5625
$
The probability of A winning over C is greater
than half, meaning A, although not by a huge 
margin, is overall better then C. $ballot$

=== Second method

If $A = 1$ than it lose no matter what.
$
  P(A=1 > C) = 0 space |-> space P(C > A=1) = 1
$

If A is not 1, it is 4 and because the distribution of the 
numbers on C is 3 on $3/4$ of the sides 
and 6 on $1/4$ of the sides, A will win $3/4$ of the time.
$
  P(A=4 > C) = 3/4 space |-> space P(C > A=4) = 1/4
$
The number of events in $Omega_(A,C)$ 
where $A = 1$ is 4. 
It will lose in all of them.
$
  P(A=1 > C) dot |Omega_(A,C)^(A=1)| = 0 dot 4 = 0
$
The number of events in $Omega_(A,C)$ 
where $not(A = 1) |-> A = 4 $ is 12.
In $3/4$ of these 12 outcomes 
it will be the winning dice. 
That means it will win in $3/4 12 = 9$ 
of the possible outcomes.
$
  P(A = 4 > C) dot |Omega_(A,C)^(A=4)| = 3/4 dot 12 = 9
$

Then the probability of A winning over C is:
$
  P(A > C) = 9/(Omega_(A,C)) = 9/16 = 0.5625.
$

A is better than C. $ballot$


== Vypocet pomoci zakonu celkove pravdepodobnosti 
From the solved probabilities, we can now come up with a general
form for this probability. Let there be probabilistically 
observable objects $A$ and $B$ whose events can be ordered.

=== Zakon celkove pravdepodobnosti
#link("https://en.wikipedia.org/wiki/Law_of_total_probability?useskin=vector")[(zdroj)]
Mame-li udalost E, ktera zavisi na podminkach,
tak jeji pravdepodobnost lze vyjadrit jako:
$
  P(E) = sum_(i=0)^n P(C_i) dot P(E|C_i)
$
kde $C_i$ jsou disjunktni podminky a pokryvaji cely 
pravdepodobnostni prostor $Omega$, tedy:
$
  union.big_(i=0)^n C_i = Omega.
$

V nasem pripade jsou udalostmi $X > Y$ (kostka X vyhraje nad Y).
Disjunktnim podminkam $C_i$ odpovidaji vysledky hodu kostky $Y$,
ktera muze nabyvat hodnoty $y_0, y_1, ..., y_n$.
Podminky jsou disjunktni $Y=y_i$, 
proto plati ze:
$
  union.big_(i=0)^n (Y=y_i) = Omega_(X Y)
$
Padne-li napr. $Y=1$ nemuze zaroven padnout $Y=3$ nebo $Y=5$ apod.
Obecny vzorec pro pravdepodobnost $P(X>Y)$ je:
$
  P(X > Y) = sum_(y in Y) P(Y = y) dot P(X > y)
$

=== Aplikace vzorce na $P(B > A)$, $P(C > B)$ a $P(A > C)$
$
  A = {1,4,4,4}, quad B = {2,2,5,5}, quad C = {3,3,3,6}
$
$
  P(B > A) &= sum_(a in A) P(A = a) dot P(B > a) =\
    &= P(A=1) dot P(B>1) + P(A=4) dot P(B>4)  =\
    &= 1/4 dot 4/4 + 3/4 dot 1/2 =\
    &= 2/8 + 3/8 = 5/8 = underline(underline(0.625))\
$
$
  P(C > B) &= sum_(b in B) P(B = b) dot P(C > b) =\
    &= P(B=2) dot P(C>2) + P(C=5) dot P(C>5)  =\
    &= 1/2 dot 4/4 + 1/2 dot 1/4 =\
    &= 4/8 + 1/8 = 5/8 = underline(underline(0.625))\
$
$
  P(A > C) &= sum_(c in C) P(C = c) dot P(A > c) =\
    &= P(C=3) dot P(A>3) + P(C=6) dot P(A>6)  =\
    &= 3/4 dot 3/4 + 1/4 dot 0/4 
    = 9/16 = underline(underline(0.5625))\
$
Dosli jsme ke stejnym vysledkum.


== Ruzne rozmisteni cisel
Kostky A, B a C maji ruzne barvy. Kolik existuje ruznych rozmisteni cisel 
z mnoziny $[1,6]$ (s opakovanim).

Rozmisteni muzeme reprezentovat jako mnozinu cisel, 
ve ktere pripoustime opakovani.
Kostka ja ctyrstenna, to znamena, ze ne kazda posloupnost 
popisuje jine rozmisteni cisel. 

Zpusobu jak vybrat 4krat z sesti cisel je:
$
  C^*(6,4) = binom(9,4) = 126.
$
Ruznych prvku z sesti moznosti bud vybereme jeden, dva, tri nebo ctyri.
Kombinaci s opakovanim muzeme prepsat jako:
$
  underbracket(
    binom(6,4), 
    #[4 ruzna cisla, \ jednina mozna \ distribuce je $|(1,1,1,1)|=1$]
  )
  + underbracket(
    binom(6,3)binom(3,1), 
    #[3 ruzna cisla, \ mozne konfigurace jsou \ $|(2,1,1),(1,2,1),(1,1,2)| = 3$]
  )
  + underbracket(
    binom(6,2)binom(3,1), 
    #[
      2 ruzna cisla, \ mozne distribuce jsou \
      $|(3,1),(2,2),(1,3)|=3$
    ]
  )
  + underbracket(
    binom(6,1), 
    #[ 1 cislo, \ jednina mozna \ distribuce je $|(4)| = 1$ ]
  )
  = 126
$

Nesmime vsak zapomenout ze pro ctyrstennou kostku plati, 
ze mame-li 4 ruzna cisla, tak je jsme na kostku schopni
umistit dvema ruznymi zpusoby.

Pokud se vybere stejne cislo ctyrikrat,
tak tyto cisla muzeme nanest na 
ctyrstennou kostku jednim jedinym zpusobem. 
Pokud se vyberou dve ruzna cisla, 
tak je na ctyrstennou kostku muzeme nanest jednim zpusobem.
Rovnez, vyberou-li se tri cisla, 
tak tyto cisla jsou mozne na kostku nanest jedinym zpusobem.

Mejme ctyri ruzna cisla $A, B, C$ a $D$.
Ctyrstennou kostku a ni nanesene cisla znazornime 
grafem. Hrany jsou prechody mezi stenami 
nizsi hodnoty do vyssi. 
// Zde budu pracovat se standardnim lexikografickym usporadanim.
Jedna ze dvou moznych konfiguraci je:

#figure(
  diagraph.raw-render(```
    graph {
      layout=twopi;
      rankdir=LR;
      label="Triangle Graph";
      labelloc=b;
      fontsize=14;
      node[shape=circle];
      A -- B;
      B -- D;
      B -- C;
      A -- C;
      A -- D;
      C -- D;
    }
  ```),
  caption: [Kostka zobrazena jako neorientovany graf]
)

Ruzne rotace kostky si muzeme predstavit jako vzajemnou zamenu 
tri vrcholu. 

#figure(
  grid(
    columns: (1fr, 1fr),
    diagraph.raw-render(```
      graph {
        layout=twopi;
        rankdir=LR;
        label="Triangle Graph";
        labelloc=b;
        fontsize=14;
        node[shape=circle];
        A -- B;
        B -- D;
        B -- C;
        A -- C;
        A -- D;
        C -- D;
        B [color=orange];
        C [color=blue];
        D [color=green];
      }
    ```),
    diagraph.raw-render(```
      graph {
        layout=twopi;
        rankdir=LR;
        labelloc=b; 
        fontsize=14;
        node[shape=circle];
        A -- D;
        A -- C;
        B -- D;
        A -- B;
        B -- C;
        C -- D;
        B [color=orange];
        C [color=blue];
        D [color=green];
      }
    ```),
  ),
  caption: [V tomto grafu se zamenili vrcholy $A, C$ a $D$]
)


#figure(
  grid(
    columns: (1fr, 1fr),
    diagraph.raw-render(```
      graph {
        layout=twopi;
        rankdir=LR;
        labelloc=b; 
        fontsize=14;
        node[shape=circle];
        A -- D;
        A -- C;
        B -- D;
        A -- B;
        B -- C;
        C -- D;
        A [color=orange];
        B [color=blue];
        D [color=green];
      }
    ```),
    diagraph.raw-render(```
      graph {
        layout=twopi;
        rankdir=LR;
        labelloc=b; 
        fontsize=14;
        node[shape=circle];
        D -- B;
        B -- C;
        A -- D;
        A -- B;
        C -- D;
        C -- A;
        A [color=orange];
        B [color=blue];
        D [color=green];
      }
    ```)
  ),
  caption: [V tomto grafu se zamenili vrcholy $A,B$ a $D$]
)

Tyto grafy reprezentuji jednu a tu samou kostku.

Kdybychom vsak zamenili vrcholy mezi sebou pouze dva, 
vznikne nam kostka, 
ktera neni identicka s kostkou predchozi.

#figure(
  grid(
    columns: (1fr, 1fr),
    diagraph.raw-render(```
      graph {
        layout=twopi;
        rankdir=LR;
        label="Triangle Graph";
        labelloc=b;
        fontsize=14;
        node[shape=circle];
        D -- B;
        B -- C;
        A -- D;
        A -- B;
        C -- D;
        C -- A;
        A [color=orange];
        D [color=blue];
      }
    ```),
    diagraph.raw-render(```
      graph {
        layout=twopi;
        rankdir=LR;
        labelloc=b; 
        fontsize=14; 
        node[shape=circle];
        A -- B;
        A -- C;
        A -- D;
        B -- C;
        B -- D;
        C -- D;
        A [color=orange];
        D [color=blue];
      }
    ```)
  ),
  caption: [V grafu se zamenili vrchly $A$ a $D$]
)

#pagebreak()

Opetovnou zamenou libovolnych dvou vrcholu dostaneme zpet puvodni kostku.


#figure(
  grid(
    columns: (1fr, 1fr),
    diagraph.raw-render(```
      graph {
        layout=twopi;
        rankdir=LR;
        labelloc=b; 
        fontsize=14; 
        node[shape=circle];
        A -- B;
        A -- C;
        A -- D;
        B -- C;
        B -- D;
        C -- D;
        B [color=orange];
        D [color=blue];
      }
    ```),
    diagraph.raw-render(```
      graph {
        layout=twopi;
        rankdir=LR;
        labelloc=b; 
        fontsize=14; 
        node[shape=circle];
        A -- D;
        A -- C;
        C -- D;
        B -- C;
        A -- B;
        B -- D;
        B [color=orange];
        D [color=blue];
      }
    ```)
  ),
  caption: [V grafu se zamenili vrchly $B$ a $D$]
)

Pricipialne funguje toto "zrcadleni" jako jev v chemii zvany chiralita. 
Dve slouceniny jsou vzajemne chiralni, jestlize jsou k sobe zrcadlove otocene.
Obsahuji stejne prvky i jejich pocty, presto ale nejsou shodne.

#figure(
  grid(
    columns: (1fr, 1fr),
    align: (center, center),
    skeletize({
      molecule("C")
      branch(relative:90deg,{
        single()
        molecule("H")
      })
      branch(relative:-30deg,{
        single()
        molecule("F")
      })
      branch(relative:230deg,{
        cram-filled-left(base-length: 4pt)
        molecule("Cl")
      })
      branch(relative:190deg,{
        cram-dashed-right(base-length: 8pt)
        molecule("Br")
      })
    }),
    grid.vline(),
    skeletize({
      molecule("C")
      branch(relative:90deg,{
        single()
        molecule("H")
      })
      branch(relative:210deg,{
        single()
        molecule("F")
      })
      branch(relative:-50deg,{
        cram-filled-left(base-length: 4pt)
        molecule("Cl")
      })
      branch(relative:-10deg,{
        cram-dashed-right(base-length: 8pt)
        molecule("Br")
      })
    })
  ),
  caption: [Bromchlorfluormethan (CHBrClF)]
)

Proto bychom meli clen odpovidajici vybranim ctyr ruznych cisel
vynasobit dvema.

$
  underbracket(
    2 dot binom(6,4), 
    #[korekce]
  )
  + binom(6,3)binom(3,1)
  + binom(6,2)binom(3,1)
  + binom(6,1) = \
  = 2 dot 15 + 20 dot 3 + 15 dot 3 + 6 = \ 
  = 30 + 60 + 45 + 6 = underline(underline(141))
$


= Sestaveni algoritmu
Cilem je maximalizovat $p$ tak, aby zaroven platilo, ze:
$
  cases(
    P(B > A) space &>= space p,
    P(C > B) space &>= space p,
    P(A > C) space &> space p
  ) space ,

$
pricemz hodnoty pravdepodobnosti $P(X > Y)$ 
manipulujeme vybiranim cisel
sten kostek z mnoziny $[1,6]$ 
(s moznosti opakovani).





