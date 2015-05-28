class Player
  # meant to be overridden by #Human and #Computer
  def move
    false
  end

  def try_move(row, col)
    @game.board.make_move row.to_i, col.to_i, @letter
  end
end
