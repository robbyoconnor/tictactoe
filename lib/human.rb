require_relative 'game'
require_relative 'player'
require_relative 'utils'

class Human < Player
  include Utils
  attr_accessor :letter, :game

  def initialize(letter, game)
    @letter = letter
    @game = game
  end

  def move
    puts "\nYour Turn\n\n".colorize(color(@letter)) unless @game.game_over
    prompt_player_move
  end

  def prompt_player_move
    valid = true
    err = '' # clear error
    loop do
      print_prompt err, valid
      move = gets.chomp.strip.split(' ')
      err, valid = validate_move move
      break if valid
    end
  end



  def validate_move(move)
    err = ''
    if is_numeric(move)
      err = 'Input must be numeric.'
      valid = false
    elsif invalid?(move.size >= 2)
      err = 'You did not provide any input, or provided incorrect input.'
      valid = false
    elsif try_move(move[0], move[1])
      valid = true
    else
      err = "The move (#{move[0]},#{move[1]}) is not valid."
      valid = false
    end
    [err, valid]
  end

  def invalid?(cond)
    !cond
  end

  def is_numeric(move)
    check_numeric move
  end

  def invalid_move(move)
    move.size < 2 || move.size > 2
  end

  def print_prompt(err, valid)
    error "#{err} Valid values are [0 0 through #{@game.rows - 1} #{@game.rows - 1}]. " unless valid
    print "Enter a move in the form \"0 0\" Valid values are [0 0 through #{@game.rows - 1} #{@game.rows - 1}]: ".colorize(:light_yellow)
  end

  def to_s
    'Player'
  end
end
