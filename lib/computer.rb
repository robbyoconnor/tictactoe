require_relative 'game'
require_relative 'human'

class Computer < Human
  attr_accessor :letter, :game

  def initialize(letter, game)
    @letter = letter
    @game = game
    puts inspect
  end

  def move
    puts "\n\nComputer's Turn\n\n".colorize(color(@letter)) unless @game.game_over
    loop do
      # corners first
      if try_corners
        valid = true
      else
        valid = pick_random_cell
      end
      break if valid
    end
  end

  def try_corners
    found = false
    moves = [[0, 0], [0, @game.board.cols - 1], [@game.board.rows - 1, @game.board.cols - 1], [@game.board.rows - 1, 0]].select { |move| @game.board.valid_move? move[0], move[1] }
    puts "Corner noves available: #{moves}"
    return false unless moves
    moves.shuffle.each do |move|
      valid = @game.board.make_move move[0], move[1], @letter
      if valid
        return true
      else
        return false
      end
    end
  end

  def pick_random_cell
    row = Random.rand(@game.board.rows)
    col = Random.rand(@game.board.cols)
    return true if @game.board.make_move row, col, @letter
    false
  end

  def to_s
    'Computer'
  end
end
