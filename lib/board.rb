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

  # Given the following:
  # 0 | 1 | 2
  # --- --- ---
  # 3 | 4 | 5
  # --- --- ---
  # 6 | 7 | 8
  #
  # Returns: [0, 4, 8]
  def main_diagnal
    (0...@rows).collect { |i| @board[i][i] }
  end

  # Given the following:
  # 0 | 1 | 2
  # --- --- ---
  # 3 | 4 | 5
  # --- --- ---
  # 6 | 7 | 8
  #
  # Returns: [2, 4, 6]
  def minor_diagnal
    (0...@rows).collect { |i| @board[i][-i - 1] }
  end

  # Collects a given column
  def col(col)
    (0...@rows).collect { |row| @board[row][col] }
  end

  # Collects a given row
  def row(row)
    (0...@cols).collect { |col| @board[row][col] }
  end

  def count(collection, player)
    collection.count { |p| p == player }
  end

  # Check minor diagnal and then main diagnal and then rows and then cols...we bail if one of this is true
  def win?(player)
    # check minor diagnal
    if count(minor_diagnal, player.letter) == @rows
      puts "#{player} is a winner on the minor diagnal".colorize(:light_green)
      return true
      # check main diagnal
    elsif count(main_diagnal, player.letter) == @rows
      puts "#{player} is a winner on the major diagnal".colorize(:light_green)
      return true
    elsif check player, true # check rows
      return true
    elsif check player # check cols
      return true
    end

    @draw = true if @moves_left == 0
    false # no winner this time :(
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

  def check(player, rows = false)
    (0...@cols).each do |c|
      if rows
        if player_in_row(c, player) == @cols
          @winning_row = c
          puts "#{player} is a winner in row #{winning_row + 1}".colorize(:light_green)
          return true
        end
      else
        if player_in_col(c, player) == @cols
          @winning_col = c
          puts "#{player} is a winner in row #{winning_col + 1}".colorize(:light_green)
          return true
        end
      end
    end
    false
  end

  # Returns the number of times the given player is in the row
  def player_in_row(row, player)
    row(row).count { |p| p == player.letter }
  end

  # Returns the number of times the given player is in the column
  def player_in_col(col, player)
    col(col).count { |p| p == player.letter }
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
