require_relative 'utils'
require_relative 'board'
require 'colorize'
require 'active_model'
class Game
  attr_accessor :board, :player, :computer, :game_over, :turn


  include Utils

  def initialize
    puts "Welcome to Tic Tac Toe!"
    @game_over = false
    ttt
  end

  def ttt
    loop do
      start_game
      play
      print "Game Over, do you want to play again (y/n)? "
      break if (gets.chomp.downcase == 'n')
    end
  end

  def start_game
    @game_over = false
    prompt_grid_size
    prompt_player_choice
    puts "-".colorize(:light_yellow)*80
    play
  end

  def first_player
    player = [@player, @computer]
    return player[Random.rand(2)]
  end

  def next_turn
    if @turn == @player

      @turn = @computer
    else
      @turn = @player
    end
  end

  def play
    done = false
    loop do
      if @board.moves_left > 0 && check_win(@turn)
        done = true
      else
        make_play @turn
      end
      break if done
    end
  end

  def check_win player
    if (@board.win?(@turn))
      @winner = @turn
      @game_over = true
      return true
    elsif @board.moves_left == 0
      done = true
      puts "Draw."
      puts "-".colorize(:light_yellow)*80
      @game_over = true
      @board.draw = true
      return true
    else
      next_turn
      return false
    end
  end

  def make_play (player)
    require 'colorize'
    if (player == @player)
      puts "\nYour Turn\n\n".colorize(color(@player)) unless @game_over
      prompt_player_move
      @board.print_board
      puts "-".colorize(:light_yellow)*80
    else
      puts "\n\nComputer's Turn\n\n".colorize(color(@computer)) unless @game_over
      computer_move
      @board.print_board
      puts "-".colorize(:light_yellow)*80
    end
  end

  def prompt_grid_size
    valid = true
    loop do
      puts "Grid sizes (Max 12x12)".center(80).colorize(:light_white)
      puts "" "
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
            ---------------------" "".colorize(:light_white)

      print "Invalid choice. ".colorize(:light_red) if !valid

      print "Select a grid size: ".colorize(:light_green)
      choice = gets.chomp.strip
      valid = grid_size_choice? choice
      break if valid
    end
  end

  def grid_size_choice? choice
    menu = {"1" => "3x3", "2" => "4x4", "3" => "5x5", "4" => "6x6", "5" => "7x7", "6" => "8x8", "7" => "9x9", "8" => "10x10", "9" => "11x11", "10" => "12x12"};
    if menu.key? choice
      create_board menu[choice].split("x")[0].to_i
      return true
    else
      return false
    end
  end

  def create_board size
    @board = make_board size, size
    @rows = size
    @cols = size
    puts "Creating a #{size}x#{size} board"
  end

  def prompt_player_choice
    valid = true
    loop do
      print "The only valid choices are X or O. ".colorize(:light_red) if !valid
      print "Do you want to be X or O [X/O] ".colorize(:light_yellow)
      choice = gets.chomp.upcase
      if !check_if_x_or_o choice
        valid = false
      else
        valid = true
        @player = choice
        @computer = @player == "X" ? "O" : "X"
        @turn = first_player
      end
      break if valid
    end
  end

  def prompt_player_move
    valid = true
    err= "" # clear error
    loop do
      error "#{err} Valid values are [0 0 through #{@board.rows-1} #{@board.rows-1}]. " unless valid
      print "Enter a move in the form \"0 0\" Valid values are [0 0 through #{@board.rows-1} #{@board.rows-1}]: ".colorize(:light_yellow)
      move = gets.chomp.strip.split(" ")
      if move.size < 2 or move.size >2
        err = "You did not provide any input, or provided incorrect input."
        valid = false
      elsif !check_numeric move.join
        err = "Input must be numeric."
        valid = false
      elsif @board.valid_move? move[0].to_i, move[1].to_i
        @board.make_move move[0].to_i, move[1].to_i, @player
        valid = true
      else
        err = "the move #{move[0]} #{move[1]} is not valid."
        valid = false
      end
      break if valid
    end
  end

  def computer_move

    valid = false
    loop do
      # corners first
      if try_corners
        valid = true
      else
        valid = pick_random_cell
      end
      break if valid
    end
  end

  def try_corners
    found = false
    moves = [[0, 0], [0, @board.cols-1], [@board.rows-1, @board.cols-1], [@board.rows-1, 0]].select { |move| @board.valid_move? move[0], move[1] }
    puts "Corner noves available: #{moves}"
    return false unless moves
    moves.shuffle.each do |move|
      valid = @board.make_move move[0], move[1], @computer
      if valid
        puts "using [#{move[0]},#{move[1]}]"
        return true
      else
        return false
      end
    end
  end

  def pick_random_cell
    row, col = Random.rand(@board.rows), Random.rand(@board.cols);
    if @board.make_move row, col, @computer
      return true
    end
    return false
  end

  def error err
    print err.colorize(:light_red)
  end
end


