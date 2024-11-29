#import "@preview/diagraph:0.3.0"
#import "@preview/i-figured:0.2.4"
#import "@preview/oxifmt:0.2.1": strfmt
#import "@preview/alchemist:0.1.2": *
#import "@preview/codly:1.0.0": *
#import "@preview/note-me:0.3.0": *
#import "@preview/codelst:2.0.2": sourcecode

== Sestavení algoritmu
Cílem je maximalizovat $p$ tak, aby současně platily:
$
  cases(
    P(B > A) space &>= space p,
    P(C > B) space &>= space p,
    P(A > C) space &> space p
  )
$
pričemž hodnoty pravděpodobnosti $P(X > Y)$ 
manipulujeme volným výběrem čísel
stěn kostek z množiny čísel $[1,6]$ 
(s možností opakování).

// Algoritmus jsem zprvu implementoval v programovacím jazyce Python.
// Rozhodl jsem se tak pro jeho čitelnou syntaxi.
// Doba běhu algoritmu avšak nesplňovala mé. 
// Po uvážení Rozhodl jsem se jej prepsat v programovacim jazyce Rust.
Algoritmus jsem se rozhodl implementovat 
v programovacím jazyce Rust #footnote[https://www.rust-lang.org/].
Celý zdrojový kód naleznete zde: #link("https://github.com/phatt-23/Projekt-9-DIM/blob/master/program/src/main.rs")
// [`https://github.com/phatt-23/Projekt-9-DIM`]

#heading(outlined: false, offset: 3, numbering: none)[
  Základní idea algoritmu
]

1. #[
  Nejprve se vygenerují všechny číselné kombinace čísel kostek.
  K vygenerovaní kombinací čísel kostek jsem si napsal 
  pomocnou funkci ```rust fn generate_dice```, ve které volám funkci
  ```rust fn combinations_with_replacement``` z knihovny `itertools`.

  #figure([
    #sourcecode[```rust
    fn generate_dice(sides: usize) -> Vec<Vec<usize>> {
        (1..=6).combinations_with_replacement(sides).collect()
    }
    ```]
  ], caption: [Funkce ```rust fn generate_dice```])

]

+ #[
  Vypočítání probability $P(X > Y)$ zajišťuje následující funkce:

  #figure([
    #sourcecode[```rust
    fn pairwise_probability(x: &[usize], y: &[usize]) -> f64 {
        let mut wins = 0;             // Count the number of pairs where x > y
        for &xi in x.iter() {         // Loop through each element in x and y
            for &yi in y.iter() {
                if xi > yi {
                    wins += 1;        // Increment wins if xi is greater than yi
                }
            }
        }
        let omega = (x.len() * y.len()) as f64; // Size of the probability space
        wins as f64 / omega                     // Return computed probability
    }
    ```]
  ], caption: [Funkce ```rust fn pairwise_probability```])

]

+ #[
  Použitím tří vnořených cyklů se 
  prověří, jestli pro stávající $p$ platí, že 
  $P(B > A) >= p$, \ $P(C > B) >= p$ a $P(A > C) > p$
  pro všechny možné kombinace kostek $A$, $B$ a $C$.
  #figure([
    #sourcecode[```rust
    for a in &dice {          // Check all combinations of A, B, C
        for b in &dice {
            for c in &dice {
                if pairwise_probability(b, a) >= p    // P(B > A) >= p
                  && pairwise_probability(c, b) >= p  // P(C > B) >= p
                  && pairwise_probability(a, c) > p   // P(A > C) >  p
                { /* ... do something */ }
            }
        }
    }
    ```]
  ], caption: [Kód pro prověřování podmínek])
]

// #pagebreak()

#heading(outlined: false, offset: 3, numbering: none)[
  Implementovaný algoritmus
]

Celý algoritmus (naivní varianta) je zde:

#figure([
  #sourcecode[```rust
  fn find_max_p_naive(side_count: usize) -> f64 {
      println!("Finding maximal p:");
      let mut max_p = 0.0;                  // Holds the maximum p
      let dice = generate_dice(side_count); // Create all the dice combinations
      let omega_size = side_count.pow(2);
      let increment = 1.0 / omega_size as f64; // p grows by this step
      
      for step in 0..=omega_size {          // Iterate from 0 to |Omega|
          let p = step as f64 * increment;  // Incrementing by 1/|Omega|
          let mut valid = false;            // No valid configs have yet been found
          println!("Testing for p = {}:", p);

          'outer:                           // Tag to jump to from within the loop
          for a in &dice {                  // Test out every single combination
              for b in &dice {
                  for c in &dice {
                      // Get the probabilities of P(B > A), P(C > B), P(A > C)
                      let ba = pairwise_probability(b, a);  
                      let cb = pairwise_probability(c, b);  
                      let ac = pairwise_probability(a, c);
                      if ba >= p && cb >= p && ac >= p { // Check them against p
                          valid = true; // This p has a valid configuration
                          println!("A={:?}, B={:?}, C={:?}", a, b, c);
                          break 'outer; // Jump out of loops (to the 'outer tag)
                      }
                  }
              }
          }
          // If for current p config doesnt exist, then return the last valid p
          if !valid {                               
              println!("No valid configurations!"); 
              return max_p;                         
          }

          max_p = p; // If configuration exists assign to max_p
      }
      max_p          // By default return max_p found
  }
  ```]
], caption: [Naivní varianta funkce ```rust fn find_max_p```])

Tento algoritmus je velmi neefektivní, 
protože opakovaně počítá pravděpodobnosti mezi týmiž kostkami.
V důsledku je alogitmus značně pomalý.

Je zřejmé, že by algoritmu přispělo 
předpočítat pravděpodobnosti všech 
kombinací dvou kostek.
Vypočtené hodnoty uložíme pole. 
Konkrétně použijeme dynamické pole v Rustu zvaný jako ```Rust Vec<T>```.

Pro naplnění tohoto pole předpočtenými hodnotami 
pravděpodobností, jsem si napsal následující funkci, 
která vrací matici pravděpobností kombinací kostek $X$ a $Y$
(obětuje paměť za zaručení rychlejšího vyhledání 
hodnoty pravděpodobnosti):

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
      // ... (identical with the previous)
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
      // ... (identical with the previous)
  }
  ```]
], caption: [Upravená funkce ```rust fn find_max_p```])


Posledně jsem droubnou úpravou cyklů algoritmus paralelizoval: 

#figure([
#codly(highlights: (
  (line: 8, start: 28, end: 35, fill: red),
  (line: 11, start: 23, end: 31, fill: green),
))
  #sourcecode[```rust
  fn find_max_p_parallel(side_count: usize) -> f64 {
      // ... (identical with the previous)
      
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

      // ... (identical with the previous)
  }
  ```]
], caption: [Paralení varianta funkce ```rust fn find_max_p```])

Vzhledem k tomu, že se zde zabýváme čtyřstěnnými kostkami, 
paralelizace přinesla pouze mírné časové zlepšení.

#heading(outlined: false, offset: 3, numbering: none)[
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
že maximalní hodnota, kterou $p$ může nabývat, je $9/16$ neboli $0.5625$. 
Také jsem zjístil o jaké konfigurace kostek, 
které splňuji dané podmínky, se přesně jedná.
Dvě z nich, [0] a [3], dokonce odpovídají konfiguraci ve slovním zadání,
neberu-li v potaz jejich označení.



