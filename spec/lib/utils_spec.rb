describe Utils do
  describe '#check_if_x_or_o' do
    context 'parameters invalid or missing' do
      it 'raises an error if not passed any parameters' do
        expect { check_if_x_or_o }.to raise_error ArgumentError
      end

      it 'raises an error if more than one argument is given' do
        expect { check_if_x_or_o('X', 'O') }.to raise_error ArgumentError
      end
    end

    context 'valid input' do
      it 'X and O is valid' do
        expect(user_choice_valid?('X')).to be true
        expect(user_choice_valid?('O')).to be true
      end
    end

    context 'invalid input' do
      it 'invalid input returns false' do
        expect(user_choice_valid?('SSS')).to be false
        expect(user_choice_valid?('S')).to be false
        expect(user_choice_valid?('XX')).to be false
        expect(user_choice_valid?('OO')).to be false
        expect(user_choice_valid?('OOXX')).to be false
      end
    end
  end

  describe '#check_numeric' do
    it 'returns false if a string is not numeric' do
      expect(user_input_numeric('lorem ipsum')).to be false
      expect(user_input_numeric('May 14, 1982')).to be false
    end

    it 'returns true if all numeric' do
      expect(user_input_numeric '12').to be true
      expect(user_input_numeric '1 2').to be true
    end
  end

  describe '#error' do
    it 'prints a string which is light_red with the message given' do
      output = lambda do
        print error('testing 123')
      end
      expect(output).to output("\e[0;91;49mtesting 123\e[0m").to_stdout
    end
  end

  describe '#color' do
    it "returns light_green if the player is \"X\"" do
      expect(color('X')).to eq(:light_green)
    end

    it "returns :light_red if the player is \"O\"" do
      expect(color('O')).to eq(:light_red)
    end
  end

  describe '#try_move' do
    let!(:game) { build(:game, board: build(:board)) }
    context 'full board' do
      let!(:game) { build(:game, board: build(:board, :draw)) }
      it 'returns false when there is not a spot to play' do
        expect(try_move(game, 0, 0, 'X')).to be false
        expect(try_move(game, 0, 1, 'X')).to be false
        expect(try_move(game, 0, 2, 'X')).to be false
        expect(try_move(game, 1, 0, 'X')).to be false
        expect(try_move(game, 1, 1, 'X')).to be false
        expect(try_move(game, 1, 2, 'X')).to be false
        expect(try_move(game, 2, 0, 'X')).to be false
        expect(try_move(game, 2, 1, 'X')).to be false
        expect(try_move(game, 2, 2, 'X')).to be false
      end
    end
    context 'blank board' do
      let!(:game) { build(:game, board: build(:board)) }
      it 'returns true if the spot is empty' do
        expect(try_move(game, 0, 0, 'X')).to be true
        expect(try_move(game, 0, 1, 'X')).to be true
        expect(try_move(game, 0, 2, 'X')).to be true
      end
      it 'returns false if the spot is not empty' do
        try_move(game, 0, 0, 'X')
        try_move(game, 0, 1, 'X')
        try_move(game, 0, 2, 'X')
        expect(try_move(game, 0, 0, 'X')).to be false
        expect(try_move(game, 0, 1, 'X')).to be false
        expect(try_move(game, 0, 2, 'X')).to be false
      end
    end
    context "invalid bounds" do
      it 'returns false if the index is out of bounds' do
        expect(try_move(game, 2, 3, 'X')).to be false
        expect(try_move(game, 4, 2, 'X')).to be false
      end
    end

    context "game is over" do
      let!(:game) { build(:game, board: build(:board), game_over: true) }
      it "returns false if game is over" do
        expect(try_move(game, 0, 0, 'X')).to be false
        expect(try_move(game, 0, 1, 'X')).to be false
        expect(try_move(game, 0, 2, 'X')).to be false
      end
    end
  end
end
