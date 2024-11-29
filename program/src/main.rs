use std::{time, env};
use std::collections::HashMap;
use rayon::prelude::*;
use itertools::Itertools;


type DiceConfiguration = (Vec<usize>, Vec<usize>, Vec<usize>);


// Compute P(X > Y).
fn pairwise_probability(x: &[usize], y: &[usize]) -> f64 {
    let omega = (x.len() * y.len()) as f64;

    let wins: usize = x.iter()
                       .flat_map(|&xi| y.iter().map(move |&yi| xi > yi))
                       .filter(|&b| b)
                       .count();

    wins as f64 / omega
}


// Generate all possible dice combinations 
// for dice with provided number of sides.
fn generate_dice(side_count: usize) -> Vec<Vec<usize>> {
    (1..=6).combinations_with_replacement(side_count).collect()
}


// Precomputes the probabilities so the evulation
// isnt dont in place but can be read as cache. 
// The computations are dumped into a HashMap.
fn precompute_probabilities_hashmap(
    dice: &Vec<Vec<usize>>
) -> HashMap<(&Vec<usize>, &Vec<usize>), f64> {
    let mut cache = HashMap::new();
    for a in dice {
        for b in dice {
            let pr = pairwise_probability(a, b);
            cache.insert((a, b), pr);
        }
    }
    cache
}


// Precomputes the probabilities. 
// Dumps computations into a vector.
fn precompute_probabilities_vec(dice: &Vec<Vec<usize>>) -> Vec<Vec<f64>> {
    let size = dice.len();
    let mut cache: Vec<Vec<f64>> = vec![vec![0.0; size]; size];
    
    // Giving up space for speed
    for (i, a) in dice.iter().enumerate() {
        for (j, b) in dice.iter().enumerate() {
            cache[i][j] = pairwise_probability(a, b);
        }
    }
    cache
}


// Finds maximal p for which the conditions hold.
// Doesnt use any caching mechanism.
fn find_max_p_naive(side_count: usize) -> f64 {
    println!("Finding maximal p:");

    let dice = generate_dice(side_count);
    let mut max_p = 0.0;
    let omega_size = side_count.pow(2);
    let increment = 1.0 / omega_size as f64;

    // Iterate from 0 to 16, incrementing by 1/|Omega|.
    for step in 0..=omega_size {
        let p = step as f64 * increment;
        println!("Testing for p = {}:", p);

        let mut valid = false;

        // Test every single combinations
        'outer: 
        for a in &dice {
            for b in &dice {
                for c in &dice {
                    let ba = pairwise_probability(b, a);
                    let cb = pairwise_probability(c, b);
                    let ac = pairwise_probability(a, c);

                    if ba >= p && cb >= p && ac > p {
                        println!("  A = {:?}, B = {:?}, C = {:?}", a, b, c);
                        valid = true; // This p has a valid configuration
                        break 'outer; // Jump to the 'outer tag 
                    }
                }
            }
        }
        
        // If for p a configuration doesnt exist 
        // then return the last valid p
        if !valid {
            println!("  No valid configurations!");
            return max_p;
        }
        
        // If configuration exists assign to max_p
        max_p = p;
    }
    
    // By default return max_p found
    max_p
}

// Finds maximal p for which the conditions hold.
// Uses HashMap data structure as cache.
fn find_max_p_caching_hashmap(side_count: usize) -> f64 {
    println!("Finding maximal p:");

    let dice = generate_dice(side_count);
    let omega_size = side_count.pow(2);
    let increment = 1.0 / omega_size as f64;
    let mut max_p = 0.0;

    let cache = precompute_probabilities_hashmap(&dice);

    // Iterate from 0 to |Omega|, incrementing by 1/|Omega|.
    for step in 0..=omega_size {
        let p = step as f64 * increment;
        println!("Testing for p = {}:", p);

        let mut valid = false;

        'outer:
        for a in &dice {
            for b in &dice {
                for c in &dice {
                    let ba = cache.get(&(b, a)).unwrap_or(&0.0);
                    let cb = cache.get(&(c, b)).unwrap_or(&0.0);
                    let ac = cache.get(&(a, c)).unwrap_or(&0.0);

                    if *ba >= p && *cb >= p && *ac > p {
                        println!("  A = {:?}, B = {:?}, C = {:?}", a, b, c);
                        valid = true;
                        break 'outer;
                    }
                }
            }
        }

        if !valid {
            println!("  No valid configurations!");
            return max_p;
        }

        max_p = p;
    }

    max_p
}

// Finds maximal p for which the conditions hold.
// Uses Vec data structure as cache.
fn find_max_p_caching_vec(side_count: usize) -> f64 {
    println!("Finding maximal p:");

    let dice = generate_dice(side_count);
    let omega_size = side_count.pow(2);
    let increment = 1.0 / omega_size as f64;
    let mut max_p = 0.0;

    let cache = precompute_probabilities_vec(&dice);

    for step in 0..=omega_size {
        let p = step as f64 * increment;
        println!("Testing for p = {}:", p);

        let mut valid = false;

        'outer:
        for (i, a) in dice.iter().enumerate() {
            for (j, b) in dice.iter().enumerate() {
                if cache[j][i] < p {
                    continue;
                }
                for (k, c) in dice.iter().enumerate() {
                    if cache[k][j] >= p && cache[i][k] > p {
                        println!("  A = {:?}, B = {:?}, C = {:?}", a, b, c);
                        valid = true;
                        break 'outer;
                    }
                }
            }
        }

        if !valid {
            println!("  No valid configurations!");
            return max_p;
        }

        max_p = p;
    }

    max_p
}

// Finds maximal p for which the conditions hold.
// Uses Vec data structure as cache.
// Also the iterations are done in parallel.
fn find_max_p_parallel(side_count: usize) -> f64 {
    println!("Finding maximal p:");

    let dice = generate_dice(side_count);
    let omega_size = side_count.pow(2);
    let increment = 1.0 / omega_size as f64;
    let mut max_p = 0.0;

    let cache = precompute_probabilities_vec(&dice);

    for step in 0..=omega_size {
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

        if !valid {
            println!("  No valid configurations!");
            return max_p;
        }
        
        println!("  Config found (no printout available)!");
        max_p = p;
    }

    max_p
}


// Find all configurations for p 
// satifying P(B > A), P(C > B) and P(A > C).
// More sophisticated. Rejects a whole class 
// of configurations based on one condition.
fn find_all_configurations(p: f64, sides: usize) -> Vec<DiceConfiguration> {
    let dice = generate_dice(sides);
    let mut configs: Vec<DiceConfiguration> = vec![];

    for a in &dice {
        for b in &dice {
            if pairwise_probability(b, a) < p {
                continue; // Skip it, no config is possible
            }

            for c in &dice {
                if pairwise_probability(c, b) >= p
                && pairwise_probability(a, c) > p {
                    configs.push((a.to_vec(), b.to_vec(), c.to_vec()));
                }
            }
        }
    }
    
    configs
}


// Find all configurations for p 
// satifying P(B > A), P(C > B) and P(A > C).
// Uses inefficient naive approach.
fn find_all_configurations_naive(
    p: f64, 
    side_count: usize
) -> Vec<DiceConfiguration> {
    let dice = generate_dice(side_count);
    let mut configs: Vec<DiceConfiguration> = vec![];

    for a in &dice {
        for b in &dice {
            for c in &dice {
                if pairwise_probability(b, a) >= p 
                && pairwise_probability(c, b) >= p
                && pairwise_probability(a, c) > p {
                    configs.push((a.to_vec(), b.to_vec(), c.to_vec()));
                }
            }
        }
    }
    
    configs
}


// Simple logger of configurations and the probability p.
fn log_configurations(configs: &Vec<DiceConfiguration>, p: f64) {
    println!("Valid configurations for p = {} are:", p);
    for (i, c) in configs.iter().enumerate() {
        println!("[{i}] \t A = {:?} \t B = {:?} \t C = {:?}", c.0, c.1, c.2);
    }
}


// Uses naive everything.
fn naive_approach(side_count: usize) {
    // naive approach
    println!("--------------------------------------");
    let now = time::SystemTime::now();
    {
        println!("NON-CACHING NAIVE APPROACH");
        let p = find_max_p_naive(side_count);
        println!("Maximal p = {}", p);
        let configs = find_all_configurations_naive(p, side_count);
        log_configurations(&configs, p);
    }
    let elapsed = now.elapsed();
    println!("Time elapsed: {:?}", elapsed);
    println!("--------------------------------------");
}


// Uses hashmap caching approach.
fn cache_hashmap_approach(side_count: usize) {
    // caching approach using hashmap data structure
    println!("--------------------------------------");
    let now = time::SystemTime::now();
    {
        println!("CACHING VERSION HASHMAP");
        let p = find_max_p_caching_hashmap(side_count);
        println!("Maximal p = {}", p);
        let configs = find_all_configurations(p, side_count);
        log_configurations(&configs, p);
    }
    let elapsed = now.elapsed();
    println!("Time elapsed: {:?}", elapsed);
    println!("--------------------------------------");
}


// Uses vector caching approach.
fn cache_vec_approach(side_count: usize) {
    // caching approach using vector data structure
    println!("--------------------------------------");
    let now = time::SystemTime::now();
    {
        println!("CACHING VERSION VEC");
        let p = find_max_p_caching_vec(side_count);
        println!("Maximal p = {}", p);
        let configs = find_all_configurations(p, side_count);
        log_configurations(&configs, p);
    }
    let elapsed = now.elapsed();
    println!("Time elapsed: {:?}", elapsed);
    println!("--------------------------------------");
}

// Uses parallel vector caching approach.
fn cache_vec_parallel_approach(side_count: usize) {
    // caching approach using vector and parallel computation
    println!("--------------------------------------");
    let now = time::SystemTime::now();
    {
        println!("CACHING VERSION VEC PARALLEL");
        let p = find_max_p_parallel(side_count);
        println!("Maximal p = {}", p);
        let configs = find_all_configurations(p, side_count);
        log_configurations(&configs, p);
    }
    let elapsed = now.elapsed();
    println!("Time elapsed: {:?}", elapsed);
    println!("--------------------------------------");
}


fn main() {
    let args = env::args().collect_vec();

    let side_count = args[1].parse::<usize>()
                            .unwrap_or_else(|_| panic!("No side count provided"));

    let approach = args.get(2).map_or("all", |v| v);

    match approach {
        "naive" => naive_approach(side_count),
        "hash" => cache_hashmap_approach(side_count),
        "vec" => cache_vec_approach(side_count),
        "par" => cache_vec_parallel_approach(side_count),
        "all" => {
            naive_approach(side_count);
            cache_hashmap_approach(side_count);
            cache_vec_approach(side_count);
            cache_vec_parallel_approach(side_count);
        }
        _ => {}
    }
}

