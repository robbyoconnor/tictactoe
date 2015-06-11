require_relative '../utils'
class Strategy
  attr_accessor :game
  include Utils

  def initialize(game)
    @game = game
  end

  def move
    false
  end
end
