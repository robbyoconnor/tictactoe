describe Board do
  describe '#initialize' do
    context 'valid grids' do
      it 'creates a 3x3 board by default' do
        board_valid(3, 3, true)
      end
      it 'creates a board sized rows by columns (8x8)' do
        board_valid(8, 8, true)
      end

      it 'board sized 12x12 is valid' do
        board_valid(12, 12, true)
      end
    end
    context 'invalid grids' do
      it 'not valid if less than 3x3' do
        board_valid(2, 2, false)
      end

      it 'not valid if larger than 12x12' do
        board_valid(13, 13, false)
      end

      it 'is not valid if not square' do
        board_valid(1, 2, false)
      end
    end
  end

  describe '#valid_move?' do
    context 'invalid move' do
      it 'should not be valid if indices are out of bounds' do
        valid_move(3, 3, false)
        valid_move(2, 3, false)
        valid_move(3, 2, false)
        valid_move(-2, -3, false)
      end
    end
    context 'valid move' do
      it 'valid if in bounds' do
        valid_move(0, 0, true)
        valid_move(0, 1, true)
        valid_move(0, 2, true)
        valid_move(1, 0, true)
        valid_move(1, 1, true)
        valid_move(1, 2, true)
        valid_move(2, 0, true)
        valid_move(2, 1, true)
        valid_move(2, 2, true)
      end
    end
  end
  describe '#make_move' do
    let(:board) { build(:board) }
    it 'invalid move returns false' do
      make_move(board, -1, -1, 'X', false)
      make_move(board, 3, 3, 'X', false)
    end

    it 'valid moves return true' do
      make_move(board, 0, 0, 'X', true)
      make_move(board, 0, 1, 'X', true)
      make_move(board, 0, 2, 'X', true)
    end

    it 'is invalid if not empty' do
      make_move(board, 0, 0, 'X', true)
      make_move(board, 0, 1, 'X', true)
      make_move(board, 0, 2, 'X', true)
      make_move(board, 0, 0, 'X', false)
      make_move(board, 0, 1, 'X', false)
      make_move(board, 0, 2, 'X', false)
    end
  end

  describe '#get_rows' do
    let(:board) { build(:board) }
    it 'returns an empty board correctly.' do
      expected = "\e[0;91;49m \e[0m\e[0;93;49m | \e[0m\e[0;91;49m \e[0m\e[0;93;49m | \e[0m\e[0;91;49m \e[0m\n\e[0;97;49m---\e[0m\e[0;97;49m---\e[0m\e[0;97;49m---\e[0m\n\e[0;91;49m \e[0m\e[0;93;49m | \e[0m\e[0;91;49m \e[0m\e[0;93;49m | \e[0m\e[0;91;49m \e[0m\n\e[0;97;49m---\e[0m\e[0;97;49m---\e[0m\e[0;97;49m---\e[0m\n\e[0;91;49m \e[0m\e[0;93;49m | \e[0m\e[0;91;49m \e[0m\e[0;93;49m | \e[0m\e[0;91;49m \e[0m"
      expect(board.get_rows).to eq(expected)
    end
  end

  describe '#print_rows' do
    let(:board) { build(:board) }
    it 'prints an empty board correctly' do
      expected = "\n\e[0;91;49m \e[0m\e[0;93;49m | \e[0m\e[0;91;49m \e[0m\e[0;93;49m | \e[0m\e[0;91;49m \e[0m\n\e[0;97;49m---\e[0m\e[0;97;49m---\e[0m\e[0;97;49m---\e[0m\n\e[0;91;49m \e[0m\e[0;93;49m | \e[0m\e[0;91;49m \e[0m\e[0;93;49m | \e[0m\e[0;91;49m \e[0m\n\e[0;97;49m---\e[0m\e[0;97;49m---\e[0m\e[0;97;49m---\e[0m\n\e[0;91;49m \e[0m\e[0;93;49m | \e[0m\e[0;91;49m \e[0m\e[0;93;49m | \e[0m\e[0;91;49m \e[0m\n"
      output = lambda do
        print board.to_s
      end
      expect(output).to output(expected).to_stdout
    end

    it 'prints a valid board if board is populated' do
      board = build(:board, :draw)
      expected = "\n\e[0;92;49mX\e[0m\e[0;93;49m | \e[0m\e[0;91;49mO\e[0m\e[0;93;49m | \e[0m\e[0;91;49mO\e[0m\n\e[0;97;49m---\e[0m\e[0;97;49m---\e[0m\e[0;97;49m---\e[0m\n\e[0;91;49mO\e[0m\e[0;93;49m | \e[0m\e[0;92;49mX\e[0m\e[0;93;49m | \e[0m\e[0;92;49mX\e[0m\n\e[0;97;49m---\e[0m\e[0;97;49m---\e[0m\e[0;97;49m---\e[0m\n\e[0;92;49mX\e[0m\e[0;93;49m | \e[0m\e[0;91;49mO\e[0m\e[0;93;49m | \e[0m\e[0;91;49mO\e[0m\n"

      output = lambda do
        print board.to_s
      end
      expect(output).to output(expected).to_stdout
    end
  end
end
