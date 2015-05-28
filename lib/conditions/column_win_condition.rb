require_relative 'condition'
class ColumnWinCondition < Condition
  attr_reader :game

  def initialize(game)
    @game = game
  end

  def win?
    check_cols
  end

  def check_cols
    require 'colorize'
    (0...@game.cols).each do |col|
      if player_in_col(col, @game.turn) == @game.cols
        puts "#{@game.turn} has won in column #{col}".colorize(color(@game.turn.letter))
        return true
      end
    end
    false
  end

  # Returns the number of times the given player is in the column
  def player_in_col(col, player)
    col(col).count { |p| p == player.letter }
  end

  # Collects a given column
  def col(col)
    (0...@game.cols).collect { |row| @game.board.board[row][col] }
  end
end
