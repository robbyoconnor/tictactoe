require_relative 'condition'
require_relative '../utils'
class DiagonalWinCondition < Condition
  include Utils
  def initialize(game)
    super(game)
  end

  # Given the following:
  # 0 | 1 | 2
  # --- --- ---
  # 3 | 4 | 5
  # --- --- ---
  # 6 | 7 | 8
  #
  # Returns: [2, 4, 6]
  def minor_diagonal
    (0...@game.rows).collect { |i| @game.board.board[i][-i - 1] }
  end

  # Given the following:
  # 0 | 1 | 2
  # --- --- ---
  # 3 | 4 | 5
  # --- --- ---
  # 6 | 7 | 8
  #
  # Returns: [0, 4, 8]
  def main_diagonal
    (0...@game.rows).collect { |i| @game.board.board[i][i] }
  end

  def print_win(diagonal)
    puts "#{@game.turn} has won on the #{diagonal} diagonal.".colorize(color(@game.turn.letter))
  end

  def diagonal_win(diagonal)
    ret = count(send("#{diagonal}_diagonal"), @game.turn) == @game.rows
  end
end
