require_relative 'condition'
class RowWinCondition < Condition
  attr_reader :game

  def initialize(game)
    @game = game
  end

  def win?
    check_rows
  end

  def check_rows
    require 'colorize'
    (0...@game.rows).each do |row|
      if player_in_row(row, @game.turn) == @game.rows
        puts "#{game.turn} has won in row #{row}".colorize(color(@game.turn.letter))
        return true
      end
    end
    false
  end

  # Returns the number of times the given player is in the row
  def player_in_row(row, player)
    row(row).count { |p| p == player.letter }
  end

  # Collects a given row
  def row(row)
    (0...@game.cols).collect { |col| @game.board.board[row][col] }
  end
end
