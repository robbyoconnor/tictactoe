# Tic Tac Toe written in Ruby
[![Code Climate](https://codeclimate.com/github/robbyoconnor/tictactoe/badges/gpa.svg)](https://codeclimate.com/github/robbyoconnor/tictactoe)
[![Test Coverage](https://codeclimate.com/github/robbyoconnor/tictactoe/badges/coverage.svg)](https://codeclimate.com/github/robbyoconnor/tictactoe/coverage)
[![Build Status](https://travis-ci.org/robbyoconnor/tictactoe.svg?branch=master)](https://travis-ci.org/robbyoconnor/tictactoe)
![Github License](https://img.shields.io/badge/License-MIT-green.svg)
[![forthebadge](http://forthebadge.com/images/badges/built-with-ruby.svg)](http://forthebadge.com)
[![forthebadge](http://forthebadge.com/images/badges/uses-git.svg)](http://forthebadge.com)
[![forthebadge](http://forthebadge.com/images/badges/built-by-developers.svg)](http://forthebadge.com)
[![forthebadge](http://forthebadge.com/images/badges/uses-git.svg)](http://forthebadge.com)
[![forthebadge](http://forthebadge.com/images/badges/built-with-love.svg)](http://forthebadge.com)
[![forthebadge](http://forthebadge.com/images/badges/no-ragrets.svg)](http://forthebadge.com)
[![forthebadge](http://forthebadge.com/images/badges/uses-badges.svg)](http://forthebadge.com)
[![forthebadge](http://forthebadge.com/images/badges/fuck-it-ship-it.svg)](http://forthebadge.com)
[![forthebadge](http://forthebadge.com/images/badges/compatibility-emacs.svg)](http://forthebadge.com)
[![forthebadge](http://forthebadge.com/images/badges/fo-sho.svg)](http://forthebadge.com)
[![forthebadge](http://forthebadge.com/images/badges/fo-shizzle.svg)](http://forthebadge.com)
[![forthebadge](http://forthebadge.com/images/badges/for-sharks.svg)](http://forthebadge.com)
[![forthebadge](http://forthebadge.com/images/badges/oooo-kill-em.svg)](http://forthebadge.com)
[![forthebadge](http://forthebadge.com/images/badges/powered-by-netflix.svg)](http://forthebadge.com)
[![forthebadge](http://forthebadge.com/images/badges/compatibility-club-penguin.svg)](http://forthebadge.com)
[![forthebadge](http://forthebadge.com/images/badges/made-with-crayons.svg)](http://forthebadge.com)
[![forthebadge](http://forthebadge.com/images/badges/makes-people-smile.svg)](http://forthebadge.com)


**Requires Ruby 2.0.0++**

#To Run
```sh
ruby bin/ttt.rb
```

# How to play
- Specify Grid size (3x3 is the smallest; 12x12 is the largest)
- Choose whether you want to be X or O
- Computer has some intelligence, first it will try to select the corners and then after that will randomly pick a spot.
- First player is randomly chosen
- It's got color thanks to the [colorize gem](https://rubygems.org/gems/colorize)

## Notes about terminology used
Terminology for the diagonals is taken from Linear Algebra's Matrix terminology.

**Major Diagonal**: [0, 4, 8]

**Minor Diagonal**:  [2,4,6]

     0 | 1 | 2
     --- --- ---
     3 | 4 | 5
     --- --- ---
     6 | 7 | 8

# About the design 

- WinConditions have a common super class of Condition
- Computer Move strategies are each in their own class and again modular to improve testability with a common subclass of Strategy.
- Grid Size **must** be square ```(nxn)``` and starts at 3x3 and maxes out at 12x12. This was due to it not looking great on my system. 
 
 
This design can be  very easily tweaked to handle the [n-queens problem](http://en.wikipedia.org/wiki/Eight_queens_puzzle).

If we relax the requirement that the board size be square, then we have [Connect Four](http://en.wikipedia.org/wiki/Connect_Four).
  

