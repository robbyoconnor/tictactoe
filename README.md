# Tic Tac Toe written in Ruby
[![Code Climate](https://codeclimate.com/github/robbyoconnor/tictactoe/badges/gpa.svg)](https://codeclimate.com/github/robbyoconnor/tictactoe)
[![Codeship](https://codeship.com/projects/df8bbfa0-e56d-0132-c046-266c7b4e6c8b/status?branch=master)](https://codeship.com/projects/82017)
[![GitHub license](https://img.shields.io/github/license/mashape/apistatus.svg)]()
[![forthebadge](http://forthebadge.com/images/badges/built-with-ruby.svg)](http://forthebadge.com)
[![forthebadge](http://forthebadge.com/images/badges/uses-git.svg)](http://forthebadge.com)
[![forthebadge](http://forthebadge.com/images/badges/built-with-love.svg)](http://forthebadge.com)
[![forthebadge](http://forthebadge.com/images/badges/no-ragrets.svg)](http://forthebadge.com)
[![forthebadge](http://forthebadge.com/images/badges/uses-badges.svg)](http://forthebadge.com)
[![forthebadge](http://forthebadge.com/images/badges/fuck-it-ship-it.svg)](http://forthebadge.com)

**Requires Ruby 2.2*******

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


