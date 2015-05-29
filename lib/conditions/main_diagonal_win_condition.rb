require_relative 'condition'
require_relative 'diagonal_win_condition'
class MainDiagonalWinCondition < DiagonalWinCondition
  def initialize(game)
    @game = game
  end

  def win?
    require 'colorize'
    if diagonal_win('main')
      print_win('main')
      return true
    end
    false
  end
end


