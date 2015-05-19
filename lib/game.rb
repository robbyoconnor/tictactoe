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
        player = [@player,@computer]
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
        if(@board.win?(@turn))
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
      if(player == @player)
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
            puts """
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
            ---------------------""".colorize(:light_white)

            print "Invalid choice. ".colorize(:light_red) if !valid

            print "Select a grid size: ".colorize(:light_green)
            choice = gets.chomp.strip
            puts choice
            if choice ==  "1"
                @board = make_board 3, 3
                @rows = 3, @cols =3
                valid = true
            elsif choice == "2"
                @board = make_board 4, 4
                @rows = 4, @cols =4
                valid = true
            elsif choice == "3"
                @board = make_board 5, 5
                @rows = 5, @cols =5
                valid = true
            elsif choice == "4"
                @board = make_board 6, 6
                @rows = 6, @cols =6
                valid = true
            elsif choice == "5"
                @board = make_board 7, 7
                @rows = 7, @cols =7
                valid = true
            elsif choice == "6"
                @board = make_board 8, 8
                @rows = 8, @cols =8
                valid = true
            elsif choice == "7"
                @board = make_board 9, 9
                @rows = 9, @cols =9
                valid = true
            elsif choice == "8"
                @board = make_board 10, 10
                @rows = 10, @cols =10
                valid = true
            elsif choice == "9"
                @board = make_board 11, 11
                @rows = 11, @cols =11
                valid = true
            elsif choice == "10"
                @board = make_board 12, 12
                @rows = 12, @cols =12
                valid = true
            else
                valid = false
            end
            break if valid
        end
   end

   def prompt_player_choice
        valid = true
        loop do
            print "The only valid choices are X or O. ".colorize(:light_red) if !valid
            print "Do you want to be X or O [X/O] " .colorize(:light_yellow)
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
            elsif @board.valid_move? move[0].to_i , move[1].to_i
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
         if @board.make_move(0, 0,@computer) # top left hand corner
            valid = true

         elsif @board.make_move(@board.rows-1,0,@computer) # bottom left hand corner
            valid =true

        elsif @board.make_move(@board.cols-1,0,@computer) # top right hand corner
            valid = true
        elsif @board.make_move(@board.rows-1, @board.cols-1,@computer) # bottom left corner
            valid = true
        else
            valid = pick_random_cell
        end
       break if valid
     end
  end

  def pick_random_cell
    row,col = Random.rand(@board.rows), Random.rand(@board.cols);
    if @board.make_move row,col,@computer
        return true
    end
    return false
  end

   def error err
     print err.colorize(:light_red)
   end
end
