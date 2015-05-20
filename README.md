# Tic Tac Toe written in Ruby

**Requires Ruby 2.2 or better.**

#To Run
ruby bin/ttt.rb

# How to play
- Specify Grid size (3x3 is the smallest; 12x12 is the largest)
- Choose whether you want to be X or O
- Computer has some intelligence, first it will try to select the corners and then after that will randomly pick a spot.
- First player is randomly chosen
- It's got color thanks to the [colorize gem](https://rubygems.org/gems/colorize)

## Notes about terminology used
Terminology for the diagnals is taken from Linear Algebra's Matrix terminology.

**Major Diagnal**: [0, 4, 8]

**Minor Diagnal**:  [2,4,6]

     0 | 1 | 2
     --- --- ---
     3 | 4 | 5
     --- --- ---
     6 | 7 | 8


