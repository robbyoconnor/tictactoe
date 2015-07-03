require_relative 'strategy'
class RandomLocationComputerStrategy < Strategy
  attr_accessor :game

  def initialize(game)
    super(game)
  end

  def move
    pick_random_cell
  end

  def pick_random_cell
    row = random_num
    col = random_num
    return true if try_move @game, row, col, @game.computer.letter
    false
  end

  def random_num
    Random.rand(@game.board.rows) # arbitrary
  end
end
