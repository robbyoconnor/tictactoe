require 'active_model'
require_relative 'utils'

class Board
  attr_accessor :board, :rows, :cols, :winner_row, :winning_row, :winner_col, :winning_col, :main_diagnal_win, :minor_diagnal_win, :draw, :moves_left
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
    return false if row >= @rows && col >= @cols # check if out of bounds
    @board[row][col] == ' '
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
    puts print_row cols
    print "\n"
  end

  def print_row(cols)
    @board.map do |row|
      row.map { |e| "#{e}".colorize(color(e)) }
        .join(' | '.colorize(:light_yellow))
    end.join("\n" + '---'.colorize(:light_white) * ((cols > 3) ? (cols <= 9 ? cols + 2 : cols + 3) : cols) + "\n").center(50)
  end

  def to_s
    print_board
  end
end
