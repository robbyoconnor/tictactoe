require_relative '../utils'
class Condition
  attr_reader :game
  include Utils

  def initialize(game)
    @game = game
  end

  # overridden by subclasses
  def win?
    false
  end
end
