describe CornerMoveComputerStrategy do
  context 'blank board' do
    let!(:strategy) {  build(:corner_move, :blank) }
    describe '#get_corners' do
      it 'returns the 4 corners of a 3x3 board' do
        expect(strategy.get_corners).to match_array [[0, 0], [0, 2], [2, 2], [2, 0]]
      end
    end
    describe '#get_valid_corner_moves' do
      it 'returns all valid corner moves' do
        expect(strategy.get_valid_corner_moves).to match_array [[0, 0], [0, 2], [2, 2], [2, 0]]
      end
    end

    describe '#find_valid_corner_move' do
      it 'finds a valid corner given a blank board' do
        srand(0)
        corner = strategy.find_valid_corner_move
        expect(corner).to_not be false
      end
    end

    describe '#move' do
      it 'returns true if a valid is move is available for a blank board' do
        expect(strategy.move).to_not be false
      end
    end
  end

  context 'full board' do
    let!(:strategy) {  build(:corner_move, :draw) }
    describe '#get_valid_corner_moves' do
      it 'returns all valid corner moves' do
        expect(strategy.get_valid_corner_moves).to match_array []
      end
    end

    describe '#find_valid_corner_move' do
      it 'finds a valid corner given a blank board' do
        srand(0)
        corner = strategy.find_valid_corner_move
        expect(corner).to be false
      end
    end

    describe '#move' do
      it 'returns true if a valid is move is available for a blank board' do
        expect(strategy.move).to be false
      end
    end
  end
end
