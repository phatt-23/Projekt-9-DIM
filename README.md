# Discrete Maths - Project 9

My attempt at [https://homel.vsb.cz/~kov16/files/dim2024_projekt09.pdf].

## Paper Directory

This directory contains the paper itself as well as its every module. 

## Program Directory

This directory contains the program for calculating the winning probabilities between three n-sided cubes.
To run the program, `cd` into the directory and run:
```
cargo run -- 4 vec 
```
The `cargo run` will simply run the executable. The `4` and `vec` are command line arguments.
The number `4` here means that it will calculate the probablities for 4-sided cubes.
You can enter whichever number you want.
And the second argument, `vec`, is a method of calculating this probability.
Some are more efficient but more complex some are simpler but slower.
You can choose from these:
- `naive`: is the simplest, doesnt do any caching
- `hash`: uses a hash table to cache the results
- `vec`: uses a vector to cache the results
- `par`: parallelizes the computaion and uses the vector as a cache
- `all`: runs all of the above at once









