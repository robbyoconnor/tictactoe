describe Game do
  g = Game.new
  describe "#validate_player_choice" do
    context "invalid" do
      it "validates player choices correctly" do
        player_choice g, 'XXX',false
        player_choice g, 'OOO',false
        player_choice g, 'A',false
      end
    end

    context "valid" do
      it "validates player choices correctly" do
        player_choice g, 'X',true
        player_choice g, 'O',true
      end
    end
  end

  describe "#create_board" do
    it "creates a board of the given size" do
      make_game_board(g, 3)
      make_game_board(g, 4)
      make_game_board(g, 5)
    end
  end

  describe "#create_players" do
    it "creates a player and computer player" do
      create_players(g,'X')
      create_players(g,'O')
    end
  end
end