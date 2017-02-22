require 'active_model'
require_relative 'utils'

class Board
  attr_accessor :board, :rows, :cols, :winner_row, :winning_row, :winner_col, :winning_col, :main_diagonal_win, :minor_diagonal_win, :draw, :moves_left
  attr_writer :board
  include ActiveModel::Model
  include ActiveModel::Validations
  include Utils
  validates_numericality_of :rows, less_than_or_equal_to: 12, greater_than_or_equal_to: 3, equal_to: :cols
  validates_numericality_of :cols, less_than_or_equal_to: 12, greater_than_or_equal_to: 3, equal_to: :rows

  def initialize(rows = 3, cols = 3)
    @board = Array.new(rows) { Array.new(cols, ' ') }
    @rows = rows
    @cols = cols
    @moves_left = @rows * @cols
  end

  def valid_move?(row, col)
    if !check_dim_bound(col) && !check_dim_bound(row)
      false
    elsif @board[row].nil? || @board[row][col] != ' '
      false
    else
      true
    end
  end

  def check_dim_bound(size)
    # arbitrarily choosing rows, it doesn't matter -- it's square.
    size >= 0 && size < @rows
  end

  def make_move(row, col, player)
    return false unless valid_move?(row, col)
    @board[row][col] = player
    @moves_left = moves_left - 1
    true
  end

  def print_board
    require 'colorize'
    print "\n"
    print grid
    print "\n"
  end

  def grid
    @board.map do |row|
      row.map { |e| e.to_s.colorize(color(e)) }
         .join(' | '.colorize(:light_yellow))
    end.join("\n" + '---'.colorize(:light_white) * dashes(@cols) + "\n")
  end

  # to make shit pretty...we print out the dashes differently depending on how many columns the grid
  def dashes(cols)
    (cols > 3 ? (cols <= 9 ? cols + 2 : cols + 3) : cols)
  end

  def to_s
    print_board
  end
end
