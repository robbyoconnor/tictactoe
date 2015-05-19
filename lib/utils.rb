module Utils
    def check_if_x_or_o(choice)
        if choice.length > 1
            return false
        elsif choice =~ /\A[XO]{1}\Z/
            return true
        else
            return false
        end
    end

    def color player
        return  player == "X" ? :light_green : :light_red
    end

    def make_board rows, cols
        Board.new rows, cols
    end

    def check_numeric input
      if input.delete(' ') =~ /\A\d+\Z/
        return true
      else
        return false
      end
    end 
end
