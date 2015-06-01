describe Board do
  describe '#initialize' do
    context 'valid grids' do
      it 'creates a 3x3 board by default' do
        board_valid(3, 3, true)
      end
      it 'creates a board sized rows by columns (8x8)' do
        board_valid(8, 8, true)
      end

      it 'board larger sized 12x12 is valid' do
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
end
