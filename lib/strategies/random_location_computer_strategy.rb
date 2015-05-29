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
    row = Random.rand(@game.board.rows)
    col = Random.rand(@game.board.cols)
    true if try_move row, col, @game.computer.letter rescue false
  end
end
