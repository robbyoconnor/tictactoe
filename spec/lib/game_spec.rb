describe Game do
  g = Game.new

  describe '#grid_size_choice' do
    context 'valid' do
      it 'returns true if valid' do
        grid_size_valid?(g, 1.to_s, true)
        grid_size_valid?(g, 2.to_s, true)
        grid_size_valid?(g, 3.to_s, true)
        grid_size_valid?(g, 4.to_s, true)
        grid_size_valid?(g, 5.to_s, true)
        grid_size_valid?(g, 6.to_s, true)
        grid_size_valid?(g, 7.to_s, true)
        grid_size_valid?(g, 8.to_s, true)
        grid_size_valid?(g, 9.to_s, true)
        grid_size_valid?(g, 10.to_s, true)
      end
    end
    context 'invalid' do
      it 'returns false if not valid' do
        grid_size_valid?(g, 11, false)
        grid_size_valid?(g, 42, false)
        grid_size_valid?(g, -3, false)
      end
    end
  end

  describe '#validate_player_choice' do
    context 'invalid' do
      it 'validates player choices correctly' do
        player_choice g, 'XXXXX', false
        player_choice g, 'OOOOO', false
        player_choice g, 'A', false
      end
    end

    context 'valid' do
      it 'validates player choices correctly' do
        player_choice g, 'X', true
        player_choice g, 'O', true
      end
    end
  end

  describe '#create_board' do
    it 'creates a board of the given size' do
      make_game_board(g, 3)
      make_game_board(g, 4)
      make_game_board(g, 5)
    end
  end

  describe '#create_players' do
    it 'creates a player and computer player' do
      create_players(g, 'X')
      create_players(g, 'O')
    end
  end

  describe '#check_win' do
    before :each do
      game.init_game
    end
    context 'blank board' do
      let!(:game) { build(:game, board: build(:board)) }
      it 'does not return as a winner for a blank board' do
        expect(game.check_win).to be false
      end
    end
    context 'draw' do
      let!(:game) { build(:game, board: build(:board, :draw)) }
      it 'successfully returns a draw' do
        expect(game.check_win).to be false
        expect(game.board.draw).to be true
      end
    end
  end
end
