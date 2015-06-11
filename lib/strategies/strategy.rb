require_relative '../utils'
class Strategy
  attr_accessor :game
  include Utils

  def initialize(game)
    @game = game
  end
# :nocov:
  def move
    false
  end
  # :nocov:
end
