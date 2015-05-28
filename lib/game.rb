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
  attr_accessor :board, :player, :computer, :game_over, :turn, :rows, :cols, :winner, :col_winner, :row_winner, :diag

  include Utils

  def initialize
    puts 'Welcome to Tic Tac Toe!'.colorize(:light_white)
    @game_over = false
  end

  def ttt
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
    @win_conditions = [ColumnWinCondition.new(self), RowWinCondition.new(self),
                       MinorDiagonalWinCondition.new(self), MainDiagonalWinCondition.new(self)]
    play
    puts '-'.colorize(:light_yellow) * 80
  end

  def first_player
    player = [@player, @computer]
    @turn = player[Random.rand(2)]
    puts "#{@turn} will go first.".colorize(color(@turn.letter))
    @turn
  end

  def next_turn
    (@turn.equal? @player) ? @turn = @computer : @turn = @player unless @game_over
  end

  def play
    done = false
    loop do
      if @board.moves_left > 0 && @game_over
        done = true
      else
        make_play @turn
      end
      break if done
    end
  end

  def check_win
    if @win_conditions.map(&:win?).include? true
      @game_over = true
      @winner = @turn
      return true
    elsif @board.moves_left == 0
      puts 'Draw.'.colorsize(:light_green)
      puts '-'.colorize(:light_yellow) * 80
      @game_over = true
      @board.draw = true
      return true
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
      puts 'Grid sizes (Max 12x12)'.center(80).colorize(:light_white)
      puts '' "
            ---------------------
            | 1.  3x3 [default] |
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

      print 'Invalid choice. '.colorize(:light_red) unless valid

      print 'Select a grid size: '.colorize(:light_green)
      choice = gets.chomp.strip
      valid = grid_size_choice? choice
      break if valid
    end
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
    valid = true
    loop do
      print_msg valid
      choice = gets.chomp.upcase
      valid = validate_player_choice(choice)
      if valid
        create_player choice
        create_computer
      end
      break if valid
    end
    @turn = first_player
  end

  def print_msg(valid)
    print 'The only valid choices are X or O. '.colorize(:light_red) unless valid
    print 'Do you want to be X or O [X/O (case-insensitive)] '.colorize(:light_yellow)
  end

  def validate_player_choice(choice)
    err = '', valid = false
    unless check_if_x_or_o choice
      err ' Invalid choice'
      valid = false
    end
    [err, valid]
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
