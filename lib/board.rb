require 'active_model'
require_relative 'utils'
class Board
    attr_accessor :board, :rows, :cols, :winner_row, :winning_row, :winner_col, :winning_col, :main_diagnal_win, :minor_diagnal_win, :draw   
    attr_writer :board
    include ActiveModel::Model
    include ActiveModel::Validations
    include Utils
    validates_numericality_of :rows, less_than_or_equal_to: 12, greater_than_or_equal_to: 3, equal_to: :cols
    validates_numericality_of :cols, less_than_or_equal_to: 12, greater_than_or_equal_to: 3, equal_to: :rows


     def initialize rows=3, cols=3
        @board = Array.new(rows) { Array.new(cols, " ")}
        @rows = rows
        @cols = cols
    end

    # Given the following:
    # 0 | 1 | 2
    # --- --- ---
    # 3 | 4 | 5
    # --- --- ---
    # 6 | 7 | 8
    #
    # Returns: [0, 4, 8]
    def main_diagnal
        return (0...@rows).collect { |i| @board[i][i] }
    end

    # Given the following:
    # 0 | 1 | 2
    # --- --- ---
    # 3 | 4 | 5
    # --- --- ---
    # 6 | 7 | 8
    #
    # Returns: [2, 4, 6]
    def minor_diagnal
        return (0...@rows).collect { |i| @board[i][-i-1] }
    end

    # Collects a given column
    def col col
        return (0...@rows).collect { |row| @board[row][col] }

    end

    # Collects a given row
    def row row
        return (0...@cols).collect { |col| @board[row][col]}
    end

    # Check minor diagnal and then main diagnal and then rows and then cols...we bail if one of this is true
    def win? player
        # check minor diagnal
        minor_diagnal = self.minor_diagnal.select{ |p| p == player}.size
        if minor_diagnal == @rows
          puts "#{player} is a winner on the minor diagnal".colorize(:light_green)
          return true
        end

        # check main diagnal
        main_diagnal = self.main_diagnal.select { |p| p == player}.size
        if main_diagnal == @rows
            puts "#{player} is a winner on the major diagnal".colorize(:light_green)
            return true
        end

        # Check rows and if we find a winner, we return.
        return true if check_rows player
        
        # Check cols and if we find a winner, we return.
        return true  if check_cols player

        @draw = true if @moves_left == 0 
        return false # no winner this time :(
    end
    
    def valid_move? row, col
        return false if(row >= @rows and col >= @cols) # check if out of bounds
        @board[row][col] == " "
    end

    def make_move row, col, player
        return false unless valid_move?(row, col)
        @board[row][col] = player
        return true
    end

    def moves_left
        moves = @board.select {|row| row.each {|e| e == " "}}
        return moves.size
    end

    def check_cols player
        (0...@cols).each do |c|            
            if player_in_col(c,player)== @cols
                @winning_col = c
                puts "#{player} is a winner in column #{winning_col}".colorize(:light_green)
                return true
            else
                return false
            end
        end
    end 
    def check_rows player
        (0...@rows).each do |r|            
            if player_in_row(r, player)== @rows
                @winning_row = r
                puts "#{player} is a winner in row #{winning_row}".colorize(:light_green)
                return true
            else
                return false
            end
        end
    end 
    # Returns the number of times the given player is in the row 
    def player_in_row row, player
        row(row).select  { |p| p == player}.size 
    end 
    
    # Returns the number of times the given player is in the column
    def player_in_col col, player
        col(col).select  { |p| p == player}.size 
    end 

    def print_board
        require 'colorize'
        print "\n"                         
         if cols > 3
            puts @board.map {|row| row.map { |e| "#{e}".colorize(color(e)) }.join(" | ".colorize(:light_yellow)) }.join("\n"+"---".colorize(:light_white)*(cols<=9? cols+2 : cols+3)+"\n").center(50)
         else
            puts @board.map {|row| row.map { |e| "#{e}".colorize(color(e)) }.join(" | ".colorize(:light_yellow)) }.join("\n"+"---".colorize(:light_white)*(cols)+"\n").center(50) if cols==3
        end
        print "\n"        
    end 
   
end
