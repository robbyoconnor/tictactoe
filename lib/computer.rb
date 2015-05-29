require_relative 'game'
require_relative 'human'
require_relative 'strategies/corner_move_computer_strategy'
require_relative 'strategies/random_location_computer_strategy'
class Computer < Human
  attr_accessor :letter, :game

  def initialize(letter, game)
    @letter = letter
    @game = game
    @strategies = [CornerMoveComputerStrategy.new(@game), RandomLocationComputerStrategy.new(@game)]
  end

  def move
    puts "\n\nComputer's Turn\n\n".colorize(color(@letter)) unless @game.game_over
    loop do
      valid = @strategies[0].move
      valid = @strategies[1].move unless valid
      break if valid
    end
  end

  def to_s
    'Computer'
  end
end
