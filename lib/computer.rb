require_relative 'game'
require_relative 'human'

class Computer < Human
  attr_accessor :letter, :game

  def initialize(letter, game)
    @letter = letter
    @game = game
  end

  def move
    puts "\n\nComputer's Turn\n\n".colorize(color(@letter)) unless @game.game_over
    valid = false
    loop do
      valid = try_corners
      valid = pick_random_cell unless valid
      break if valid
    end
  end

  def try_corners
    find_valid_corner_move
  end

  def pick_random_cell
    row = Random.rand(@game.board.rows)
    col = Random.rand(@game.board.cols)
    true if try_move row, col rescue false
  end

  def get_corners
    [[0, 0], [0, @game.board.cols - 1], [@game.board.rows - 1, @game.board.cols - 1], [@game.board.rows - 1, 0]]
  end

  def get_valid_corner_moves
    get_corners.select { |move| @game.board.valid_move? move[0], move[1] }.shuffle
  end

  def find_valid_corner_move
    valid = false
    get_valid_corner_moves.each do |move|
      valid = try_move move[0], move[1]
      return valid if valid
    end
  end

  def to_s
    'Computer'
  end
end
