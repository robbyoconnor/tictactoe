module Utils
  def check_if_x_or_o(choice)
    if choice.length > 1
      false
    elsif choice =~ /\A[XO]\Z/
      true
    else
      false
    end
  end

  def color(player)
    player == 'X' ? :light_green : :light_red
  end

  def make_board(rows, cols)
    Board.new rows, cols
  end

  def check_numeric(input)
    if input.delete(' ') =~ /\A\d+\Z/
      true
    else
      false
    end
  end

  def error(err)
    print err.colorize(:light_red)
  end

  def count(collection, player)
    collection.count { |p| p == player.letter }
  end

  def try_move(row, col, player)
    @game.board.make_move row.to_i, col.to_i, player
  end

  def err(msg)
    print "#{msg}".colorize(:light_red)
  end
end
