#import "@preview/diagraph:0.3.0"
#import "@preview/i-figured:0.2.4"
#import "@preview/oxifmt:0.2.1": strfmt
#import "@preview/alchemist:0.1.2": *
#import "@preview/codly:1.0.0": *
#import "@preview/note-me:0.3.0": *
#import "@preview/codelst:2.0.2": sourcecode

== Sestavení algoritmu
Cílem je maximalizovat parametr $p$ tak, aby současně platily:
$
  cases(
    P(B > A) space &>= space p,
    P(C > B) space &>= space p,
    P(A > C) space &> space p
  )
$
pričemž hodnoty pravděpodobnosti $P(X > Y)$ 
manipulujeme volným výběrem čísel
čtyř stěn kostek z množiny čísel $[1,6]$ 
(s možností opakování).

// Algoritmus jsem zprvu implementoval v programovacím jazyce Python.
// Rozhodl jsem se tak pro jeho čitelnou syntaxi.
// Doba běhu algoritmu avšak nesplňovala mé. 
// Po uvážení Rozhodl jsem se jej prepsat v programovacim jazyce Rust.
Algoritmus jsem se rozhodl implementovat 
v programovacím jazyce Rust 
#footnote[
  Programovací jazyk Rust:
  #link("https://www.rust-lang.org/")
].
Celý zdrojový kód naleznete 
#link("https://github.com/phatt-23/Projekt-9-DIM/blob/master/program/src/main.rs")[zde]
#footnote[
  GitHub repozitář se zdrojovým kódem:
  #link("https://github.com/phatt-23/Projekt-9-DIM/blob/master/program/src/main.rs")
].
// [`https://github.com/phatt-23/Projekt-9-DIM`]

#heading(outlined: false, offset: 2, numbering: none)[
  Základní idea algoritmu
]

1. #[
  Nejprve se vygenerují všechny číselné kombinace kostky.
  K vygenerovaní těchto kombinací jsem si napsal 
  pomocnou funkci ```rust fn generate_dice```, ve které volám funkci
  ```rust fn combinations_with_replacement``` z knihovny `itertools`
  #footnote[
    Knihovna _itertools_ napsaná v jazyce Rust: #link("https://crates.io/crates/itertools")
  ].

  #figure([
    #sourcecode[```rust
    fn generate_dice(sides: usize) -> Vec<Vec<usize>> {
        (1..=6).combinations_with_replacement(sides).collect()
    }
    ```]
  ], caption: [Funkce ```rust fn generate_dice```])

]


2. #[
  Použitím tří vnořených cyklů se 
  prověří, jestli stávající $p$ splňuje 
  $P(B > A) >= p$, \ $P(C > B) >= p$ a $P(A > C) > p$
  pro některou z kombinací kostek $A$, $B$ a $C$.
  #figure([
    #sourcecode[```rust
    for a in &dice {          // Check all combinations of A, B, C
        for b in &dice {
            for c in &dice {
                let ba = pairwise_probability(b, a);   // P(B > A)
                let cb = pairwise_probability(c, b);   // P(C > B)
                let ac = pairwise_probability(a, c);   // P(A > C) 

                if ba >= p && cb >= p && ac > p { 
                    /* ... do something */ 
                }
            }
        }
    }
    ```]
  ], caption: [Kód na prověřování podmínek])
]

#pagebreak()

3. #[
  Výpočet pravděpodobnosti $P(X > Y)$ zajišťuje následující funkce:

  #figure([
    #sourcecode[```rust
    fn pairwise_probability(x: &[usize], y: &[usize]) -> f64 {
        let mut wins = 0;             // Count the number of winning cases
        for &xi in x.iter() {         // Loop through each pair of x and y
            for &yi in y.iter() {
                if xi > yi {          // If xi is greater than yi
                    wins += 1;        // increment the number of wins 
                }
            }
        }
        let omega = (x.len() * y.len()) as f64; // Size of the probability space
        wins as f64 / omega                     // Return probability
    }
    ```]
  ], caption: [Funkce ```rust fn pairwise_probability```])

]
// #pagebreak()

#heading(outlined: false, offset: 2, numbering: none)[
  Implementace algoritmu
]

Celý algoritmus (jeho naivní varianta) je zde:

#figure([
  #sourcecode[```rust
  fn find_max_p_naive(side_count: usize) -> f64 {
      println!("Finding maximal p:");
      let mut max_p = 0.0;                  // Holds the maximum p
      let dice = generate_dice(side_count); // Create all the dice combinations
      let omega_size = side_count.pow(2);
      let increment = 1.0 / omega_size as f64; // p grows by this step
      
      for step in 0..=omega_size {         // Iterate from 0 to |Omega|
          let p = step as f64 * increment; // Incrementing by 1/|Omega|
          let mut valid = false;           // No valid configs yet found
          println!("Testing for p = {}:", p);

          'outer:                          // Tag to jump to from within the loop
          for a in &dice {                 // Test out every single combination
              for b in &dice {
                  for c in &dice {
                      // Get the probabilities of P(B > A), P(C > B), P(A > C)
                      let ba = pairwise_probability(b, a);  
                      let cb = pairwise_probability(c, b);  
                      let ac = pairwise_probability(a, c);
                      if ba >= p && cb >= p && ac >= p { // Check them against p
                          valid = true; // This p has a valid configuration
                          println!("A={:?}, B={:?}, C={:?}", a, b, c);
                          break 'outer; // Break out from the 3-nested loops
                      }
                  }
              }
          }
          // If for current p config doesnt exist, then return the last valid p
          if !valid {                               
              println!("No valid configurations!"); 
              return max_p;                         
          }

          max_p = p; // If configuration exists assign p to max_p
      }
      max_p          // By default return max_p
  }
  ```]
], caption: [Naivní varianta funkce ```rust fn find_max_p```])

Tato naivní varianta algoritmu je velmi neefektivní, 
neboť opakovaně počítá pravděpodobnosti mezi týmiž konfiguracemi kostek.
V důsledku je alogitmus znatelně pomalý.

Je zřejmé, že by algoritmu přispělo 
prvně pravděpodobnosti všech 
kombinací dvou kostek předpočítat.
Vypočtené hodnoty se uloží do matice (resp. pole polí). 
Konkrétně se použije dynamické pole ```Rust Vec<T>``` 
ze standardní knihovny jazyka Rust.

Pro naplnění tohoto pole předpočtenými hodnotami 
pravděpodobností, jsem si napsal následující funkci, 
která vrací matici pravděpobností kombinací kostek $X$ a $Y$
(obětuje se paměť pro rychlejší vyhledání 
hodnot pravděpodobností):

#figure([
  #sourcecode[```rust
  fn precompute_probabilities_vec(dice: &Vec<Vec<usize>>) -> Vec<Vec<f64>> {
      let size = dice.len();
      // Matrix of X and Y
      let mut cache: Vec<Vec<f64>> = vec![vec![0.0; size]; size]; 

      for (i, x) in dice.iter().enumerate() {
          for (j, y) in dice.iter().enumerate() {
              // Insert P(X>Y) at [i,j]
              cache[i][j] = pairwise_probability(x, y); 
          }
      }

      cache // Return the matrix of computed probabilities of X and Y
  }
  ```]
], caption: [Funkce ```rust fn precompute_probabilities_vec```])

a využil ji v upravené funkci pro hledaní maximální hodnoty $p$:

#figure([
#codly(
  range: (1,22),
  highlights: (
    (line: 1, start: 6, end: 52, fill: green),
    (line: 6, start: 10, end: 14, fill: blue),
    (line: 15, start: 31, end: 40, fill: blue),
  )
)
  #sourcecode[```rust
  fn find_max_p_caching_vec(side_count: usize) -> f64 {
      // ... (identical with the naive variant)
      let cache = precompute_probabilities_vec(&dice);  // <-- precomputing

      for step in 1..=16 {
          let p = step as f64 * increment;
          let mut valid = false;
          'outer: 
          for (i, a) in dice.iter().enumerate() {
              for (j, b) in dice.iter().enumerate() {
                  if cache[j][i] < p { continue; }  // skipping innermost loop
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

          if !valid {
            println!("No valid configurations!");
            return max_p;
          }

          max_p = p;
      }
      max_p
  }
  ```]
], caption: [Rychlejší varianta ```rust fn find_max_p``` s předpočítanými hodnotami])

Verze s předpočítanými hodnotami pravděpodobností výrazně zrychluje celý proces
a to díky tomu, že místo opakovaného výpočtu pravděpodobnosti pro každý pár kostek mezi 
každým cyklem, máme uložené hodnoty v matici, což zrychlí nalezení pravěpodobnosti 
$P(X > Y)$ na konstantní čas $O(1)$.

Posledně jsem droubnou úpravou cyklů algoritmus paralelizoval: 

#figure([
#codly(highlights: (
  (line: 8, start: 28, end: 35, fill: red),
  (line: 11, start: 23, end: 31, fill: green),
))
  #sourcecode[```rust
  fn find_max_p_parallel(side_count: usize) -> f64 {
      // ... (identical with the previous variant)
      
      for step in 1..=16 {
          let p = step as f64 * increment;
          println!("Testing for p = {}:", p);

          // Iterations done in paralel
          let valid = dice.par_iter().enumerate().any(|(i, _)| { 
              dice.par_iter().enumerate().any(|(j, _)| {
                  if cache[j][i] < p { return false; }
                  dice.par_iter().enumerate().any(|(k, _)| {
                      cache[k][j] >= p && cache[i][k] > p
                  })
              })
          });

          if !valid {
              println!("No valid configurations!");
              return max_p;
          }
        
          println!("Config found (no printout available)!");
          max_p = p;
      }

      max_p
  }
  ```]
], caption: [Paralení varianta funkce ```rust fn find_max_p```])

Vzhledem k tomu, že se zde zabýváme čtyřstěnnými kostkami, 
paralelizace přinesla pouze mírné časové zlepšení.

#heading(outlined: false, offset: 2, numbering: none)[
  Výpis po zpuštění programu
]

#codly(
  highlights: (
    (line: 2, start: 1, end: none, fill: red),
    (line: 5, start: 1, end: none, fill: green),
  ),
  number-format: none,
)

#figure([
```stdout
Maximal p = 0.5625
Valid configurations for p = 0.5625 are:
[0] 	A = [2, 2, 5, 5] 	B = [3, 3, 3, 6] 	C = [1, 4, 4, 4]
[1] 	A = [2, 2, 5, 6] 	B = [3, 3, 3, 6] 	C = [1, 4, 4, 4]
[2] 	A = [3, 3, 3, 6] 	B = [1, 4, 4, 4] 	C = [1, 2, 5, 5]
[3] 	A = [3, 3, 3, 6] 	B = [1, 4, 4, 4] 	C = [2, 2, 5, 5]
```
], caption: "Standardní výstup v konzoli")

Z výpisu algoritmu jsem zpozoroval,
že maximální hodnota, kterou $p$ může nabývat, je $9/16$ neboli $0.5625$. 
Také jsem zjistil o jaké konfigurace kostek, 
které splňují dané podmínky, se přesně jedná.
Dvě z nich dokonce odpovídají konfiguraci ve slovním zadání (index~0~a~3),
neberu-li v potaz označení kostek.



