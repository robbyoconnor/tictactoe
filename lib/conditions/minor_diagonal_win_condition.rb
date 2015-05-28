require_relative 'condition'
require_relative 'diagonal_win_condition'
class MinorDiagonalWinCondition < DiagonalWinCondition
  def initialize(game)
    super(game)
  end

  def win?
    require 'colorize'
    if diagonal_win 'minor'
      print_win 'minor'
      return true
    end
    false
  end
end
