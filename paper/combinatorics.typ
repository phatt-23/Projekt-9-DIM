#import "@preview/diagraph:0.3.0"
#import "@preview/i-figured:0.2.4"
#import "@preview/oxifmt:0.2.1": strfmt
#import "@preview/alchemist:0.1.2": *
#import "@preview/codly:1.0.0": *
#import "@preview/note-me:0.3.0": *

#set page(
  header: align(right)[
    Kombinatorika
  ],
)

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

#pagebreak()

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


Algoritmus jsem zprvu psal v Pythonu pro jeho citelnou syntaxi.
Beh algoritmu ale trval delsi dobu nez se mi libilo. 
Rozhodl jsem se jej prepsat v programovacim jazyce Rust.

Zakladni idea je jednoducha:
1. #[
  Vygeneruje vsechny ciselne kombinace pro steny kostek.
  K vygenerovani kombinaci s opakovanim jsem vyuzil funkci
  `combinations_with_replacement` z knihovny `itertools` 
  ve funkci `generate_dice`.
  ```rust
  fn generate_dice(sides: usize) -> Vec<Vec<usize>> {
      (1..=6).combinations_with_replacement(sides).collect()
  }
  ```
]
+ #[
  Vypocte probabilitu $P(X > Y)$ pro kazdou dvojici kombinaci.
  Pro vypocet $P(X > Y)$ jsem si napsal funkci:

  ```rust
  // Compute P(X > Y).
  fn pairwise_probability(x: &[usize], y: &[usize]) -> f64 {
      let wins: usize = x.iter()              // Get the count of events where x > y
                         .flat_map(|&xi| y.iter().map(move |&yi| xi > yi))
                         .filter(|&b| b)
                         .count();
      let omega = (x.len() * y.len()) as f64; // Size of the probability space
      wins as f64 / omega                     // Return probability
  }
  ```

]
+ #[
  V cyklu proveri jestli pro $p$ plati ze $P(B > A) >= p, P(C > B) >= p$ a 
  $P(A > C) > p$.
  ```rust
  let ba = pairwise_probability(b, a);      // P(B > A)
  let cb = pairwise_probability(c, b);      // P(C > B)
  let ac = pairwise_probability(a, c);      // P(A > C)
  if ba >= p && cb >= p && ac >= p {        // Check them against p
    ... (do something)
  }
  ```
]
+ #[
  Soucasne nalezene maximalni $p$ ulozi a opakuje predchozi krok,
  dokud stale existuji konfigurace kostek, pro ktere plati podminky. 
  
]

#pagebreak()

Zde je algoritmus (naivni varianta):

```rust
// Finds maximal p for which the conditions hold.
// Doesnt use any caching mechanism.
fn find_max_p_naive(side_count: usize) -> f64 {
    println!("Finding maximal p:");
    let mut max_p = 0.0;                      // Holds the maximum p.
    let dice = generate_dice(side_count);     // Create all the dice combinations.
    let increment = 1.0 / (side_count * side_count) as f64; // Probability can grow 
                                                            // only by this margin
    for step in 1..=16 {                      // Iterate from 1 to 16, 
        let p = step as f64 * increment;      // incrementing by 1/|Omega|.
        let mut valid = false;                // No configurations for 
                                              // current p have yet been found.
        println!("Testing for p = {}:", p);
        'outer:                               // Tag to jump to from within the loop.
        for a in &dice {                      // Test out every single combination.
            for b in &dice {
                for c in &dice {
                    let ba = pairwise_probability(b, a);  // Get the probabilities
                    let cb = pairwise_probability(c, b);  // of P(B > A), P(C > B) ...
                    let ac = pairwise_probability(a, c);
                    if ba >= p && cb >= p && ac >= p {    // Check them against p
                        println!("A={:?}, B={:?}, C={:?}", a, b, c);
                        valid = true; // This p has a valid configuration.
                        break 'outer; // Jump to the 'outer tag.
                    }
                }
            }
        }
        if !valid {                               // If for current p configuration 
            println!("No valid configurations!"); // doesnt exist, then return the 
            return max_p;                         // last valid p.
        }
        max_p = p;                    // If configuration exists assign to max_p.
    }
    max_p                             // By default return max_p found.
}
```
Tento algoritmus je vsak velmi neefektvni. Hodnotu probabilit mezi kostkami
pocita neustale znova a znova. Pocita i ty hodnoty co uz byly vypocteny.
V dusledku je tento alogitmus velmi pomaly.

Je jednoznacne, ze algoritmu chybi cache system.
Vypoctene hodnoty ulozime do nejake datove struktury (kolekce).
Pokud bychom implementovali cache system, algoritmus by
mohl vyuzit toho, ze hodnota, ktera uz byla vypoctena,
nebude zbytecne pocitana znova. 

Datova struktura, 
ktera se pri implementaci algoritmu pro tento ukol prokazala jako nejlepsi,
je obycejne dynamicke pole - v Rustu je to ```Rust Vec<T>```.

Pro naplneni tohoto pole predpoctenymi hodnotami 
pravdepodobnosti, jsem si napsal nasledujici funkci:
```Rust
// Precomputes the probabilities. 
// Dumps computations into a vector.
fn precompute_probabilities_vec(dice: &Vec<Vec<usize>>) -> Vec<Vec<f64>> {
    let size = dice.len();
    let mut cache = vec![vec![0.0; size]; size];
    for (i, a) in dice.iter().enumerate() {
        for (j, b) in dice.iter().enumerate() {
            cache[i][j] = pairwise_probability(a, b);
        }
    }
    cache
}
```
a vyuzil jej v upravene funkci na hledani maximalni hodnoty $p$:

#codly(
  range: (1,22),
  highlights: (
    (line: 3, start: 6, end: 52, fill: green),
    (line: 8, start: 10, end: 14, fill: blue),
    (line: 16, start: 25, end: 40, fill: blue),
  )
)
```Rust
// Finds maximal p for which the conditions hold.
// Uses Vec data structure as cache.
fn find_max_p_caching_vec(side_count: usize) -> f64 {
    let cache = precompute_probabilities_vec(&dice);  // <-- precomputing
    // ... (identical with the previous)
    for step in 1..=16 {
        let p = step as f64 * increment;
        let mut valid = false;
        'outer: for (i, a) in dice.iter().enumerate() {
            for (j, b) in dice.iter().enumerate() {
                if cache[j][i] < p { continue; }    // skipping innermost loop
                                                    // if P(A > B) doesnt hold
                for (k, c) in dice.iter().enumerate() {
                    if cache[k][j] >= p && cache[i][k] > p {
                        println!("A = {:?}, B = {:?}, C = {:?}", a, b, c);
                        valid = true;
                        break 'outer;
                    }
                }
            }
        }
        // ... (identical with the previous)
    }
    // ... (identical with the previous)
}
```
Posledne jsem droubnou upravou cyklu algoritmus paralelizoval: 

#codly(highlights: (
  (line: 11, start: 28, end: 35, fill: red),
  (line: 16, start: 23, end: 31, fill: green),
))
```Rust
// Finds maximal p for which the conditions hold.
// Uses Vec data structure as cache.
// Also the iterations are done in parallel.
fn find_max_p_parallel(side_count: usize) -> f64 {
    // ... (identical with the previous)
    let cache = precompute_probabilities_vec(&dice);
    
    for step in 1..=16 {
        let p = step as f64 * increment;
        println!("Testing for p = {}:", p);

        let valid = dice.par_iter().enumerate().any(|(i, _)| {
            dice.par_iter().enumerate().any(|(j, _)| {
                if cache[j][i] < p {
                    return false;
                }
                dice.par_iter().enumerate().any(|(k, _)| {
                    cache[k][j] >= p && cache[i][k] > p
                })
            })
        });
        // ... (identical with the previous)
    }
    max_p
}
```
Cely zdrojovy kod nalezenete zde: #link("https://github.com/phatt-23/Projekt-9-DIM/blob/master/program/src/main.rs")[`https://github.com/phatt-23/Projekt-9-DIM`]

Vystup po zpusteni programu je zde:

#codly(highlights: (
  (line: 2, start: 1, end: none, fill: red),
  (line: 5, start: 1, end: none, fill: green),
))
#codly(
number-format: none
)
```stdout
Maximal p = 0.5625
Valid configurations for p = 0.5625 are:
[0] 	A = [2, 2, 5, 5] 	B = [3, 3, 3, 6] 	C = [1, 4, 4, 4]
[1] 	A = [2, 2, 5, 6] 	B = [3, 3, 3, 6] 	C = [1, 4, 4, 4]
[2] 	A = [3, 3, 3, 6] 	B = [1, 4, 4, 4] 	C = [1, 2, 5, 5]
[3] 	A = [3, 3, 3, 6] 	B = [1, 4, 4, 4] 	C = [2, 2, 5, 5]
```
Tim jsem tedy zjistil, ze maximalni hodnota $p$ je $0.5625$ neboli $9/16$. 
Take jsem zjistil o jake konfigurace kostek se presne jedna.
Dve z nich ([0] a [3]), 
odpovidaji konfiguraci v slovnim zadani 
(neberu v potaz jejich oznaceni).
