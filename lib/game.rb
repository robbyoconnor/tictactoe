require_relative 'utils'
require_relative 'board'
require_relative 'human'
require_relative 'computer'
require 'colorize'
require 'active_model'
class Game
  attr_accessor :board, :player, :computer, :game_over, :turn, :rows, :cols

  include Utils

  def initialize
    puts 'Welcome to Tic Tac Toe!'.colorize(:light_white)
    @game_over = false
    ttt
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
    play
    puts '-'.colorize(:light_yellow) * 80
  end

  def first_player
    player = [@player, @computer]
    player[Random.rand(2)]
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

  def check_win(_player)
    if @board.win?(@turn)
      @winner = @turn
      @game_over = true
      return true
    elsif @board.moves_left == 0
      puts 'Draw.'
      puts '-'.colorize(:light_yellow) * 80
      @game_over = true
      @board.draw = true
      return true
    else
      next_turn
      false
    end
  end

  def make_play(player)
    require 'colorize'
    player.move
    @board.print_board
    @game_over = true if check_win player
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
    menu = {'1' => '3x3', '2' => '4x4', '3' => '5x5', '4' => '6x6', '5' => '7x7', '6' => '8x8', '7' => '9x9', '8' => '10x10', '9' => '11x11', '10' => '12x12'}
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
      print 'The only valid choices are X or O. '.colorize(:light_red) unless valid
      print 'Do you want to be X or O [X/O (case-insensitive)] '.colorize(:light_yellow)
      choice = gets.chomp.upcase
      unless check_if_x_or_o choice
        valid = false
        error 'Invalid.'
      else
        createPlayer choice
        createComputer
        puts "choice is X; Computer is #{@computer.letter}"
        valid = true
      end
      break if valid
    end

    @turn = first_player
    puts "#{@turn} will go first."
  end

  def createPlayer(player_choice)
    @player = Human.new(player_choice, self)
  end

  def createComputer
    if @player.letter == 'X'
      @computer = Computer.new 'O', self
    else
      @computer = Computer.new 'X', self
    end
  end
end
