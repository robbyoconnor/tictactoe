module Utils 
    def check_if_x_or_o(choice)
        return true if (choice == 'X' || choice == 'O')
        puts"The only valid letter choices are X or O"
        return false
    end
end