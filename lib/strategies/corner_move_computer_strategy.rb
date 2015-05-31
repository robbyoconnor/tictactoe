require_relative 'strategy'
class CornerMoveComputerStrategy < Strategy
  attr_accessor :game

  def initialize(game)
    super(game)
  end

  def move
    find_valid_corner_move
  end

  def get_corners
    [[0, 0], [0, @game.board.cols - 1], [@game.board.rows - 1, @game.board.cols - 1], [@game.board.rows - 1, 0]]
  end

  def get_valid_corner_moves
    get_corners.select { |move| @game.board.valid_move? move[0], move[1] }.shuffle
  end

  def find_valid_corner_move
    corner = get_valid_corner_moves.first
    corner ? (try_move(corner[0], corner[1], @game.computer.letter)) : false
  end
end
