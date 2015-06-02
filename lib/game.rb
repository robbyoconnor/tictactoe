require_relative 'utils'
require_relative 'board'
require_relative 'human'
require_relative 'computer'
require_relative 'conditions/condition'
require_relative 'conditions/column_win_condition'
require_relative 'conditions/row_win_condition'
require_relative 'conditions/minor_diagonal_win_condition'
require_relative 'conditions/main_diagonal_win_condition'
require 'colorize'
require 'active_model'
class Game
  attr_accessor :board, :player, :computer, :game_over, :turn, :rows, :cols

  include Utils


  def ttt
    puts 'Welcome to Tic Tac Toe!'.colorize(:light_white)
    loop do
      start_game
      print 'Game Over, do you want to play again (y/n)? '.colorize(:light_yellow)
      break if (gets.chomp.downcase == 'n')
    end
  end

  def start_game
    @game_over = false
    prompt_grid_size
    prompt_player_choice
    @turn = first_player
    @win_conditions = [ColumnWinCondition.new(self), RowWinCondition.new(self),
                       MinorDiagonalWinCondition.new(self), MainDiagonalWinCondition.new(self)]
    play
    puts '-'.colorize(:light_yellow) * 80
  end

  def first_player
    player = [@player, @computer]
    @turn = player[Random.rand(2)]
  end

  def next_turn
    (@turn.equal? @player) ? @turn = @computer : @turn = @player unless @game_over
  end

  def play
    loop do
      make_play @turn
      break if @game_over
    end
  end

  def check_win
    if @win_conditions.map(&:win?).include?(true)
      @game_over = true
      @winner = @turn
      return true
    elsif @board.moves_left == 0
      puts "Cat's Game.".colorize(:light_green)
      puts '-'.colorize(:light_yellow) * 80
      @game_over = true
      @board.draw = true
      return false
    else
      next_turn
    end
    false
  end

  def make_play(player)
    require 'colorize'
    player.move
    @board.print_board
    @game_over = true if check_win
  end

  def prompt_grid_size
    valid = true
    loop do
      display_menu
      print 'Invalid choice. '.colorize(:light_red) unless valid
      print 'Select a grid size: '.colorize(:light_green)
      valid = get_input
      break if valid
    end
  end
  def get_input
    choice = gets.chomp.strip
    grid_size_choice? choice
  end
  def display_menu
    puts 'Grid sizes (Max 12x12)'.center(80).colorize(:light_white)
    puts '' "
            ---------------------
            | 1.  3x3           |
            | 2.  4x4           |
            | 3.  5x5           |
            | 4.  6x6           |
            | 5.  7x7           |
            | 6.  8x8           |
            | 7.  9x9           |
            | 8   10x10         |
            | 9.  11x11         |
            | 10. 12x12         |
            ---------------------" ''.colorize(:light_white)
  end

  def grid_size_choice?(choice)
    menu = { '1' => '3x3', '2' => '4x4', '3' => '5x5', '4' => '6x6', '5' => '7x7', '6' => '8x8', '7' => '9x9', '8' => '10x10', '9' => '11x11', '10' => '12x12' }
    if menu.key? choice
      create_board menu[choice].split('x')[0].to_i
      true
    else
      false
    end
  end

  def create_board(size)
    @board = make_board size, size
    @rows = size
    @cols = size
  end

  def prompt_player_choice
    choice = '', valid = true
    loop do
      print_msg valid
      valid, choice = get_and_validate_choice
      break if valid
    end
    create_players choice if valid
  end

  def get_and_validate_choice
    choice = gets.chomp.strip.upcase
    valid = validate_player_choice(choice)
    [valid, choice]
  end

  def create_players(choice)
    create_player choice
    puts "#{@player} is #{@player.letter}\n".colorize(color(@player.letter))
    create_computer
    puts "#{@computer} is #{@computer.letter}\n".colorize(color(@computer.letter))
  end

  def print_first_turn
    puts "#{@turn} will go first.".colorize(color(@turn.letter))
  end

  def print_msg(valid)
    print 'The only valid choices are X or O. '.colorize(:light_red) unless valid
    print 'Do you want to be X or O [X/O (case-insensitive)]: '.colorize(:light_yellow)
  end

  def validate_player_choice(choice)
    valid = true
    valid = false unless check_if_x_or_o choice
    valid
  end

  def create_player(player_choice)
    @player = Human.new player_choice, self
  end

  def create_computer
    if @player.letter == 'X'
      @computer = Computer.new 'O', self
    else
      @computer = Computer.new 'X', self
    end
  end
end
