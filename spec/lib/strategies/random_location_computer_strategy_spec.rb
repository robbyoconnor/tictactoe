describe RandomLocationComputerStrategy do
  before :each do
    Random.expects(:rand).returns(1)
    Random.expects(:rand).returns(1)
  end
  context 'blank board' do
    let!(:strategy) { build(:random_move_strategy, :blank) }
    describe '#pick_random_cell' do
      it 'returns a valid random cell given a blank board' do
        expect(strategy.pick_random_cell).to be true
      end
    end
    describe '#move' do
      it 'returns true if there are moves available' do
        expect(strategy.move).to be true
      end
    end
  end

  context 'full board' do
    let!(:strategy) { build(:random_move_strategy, :draw) }
    describe '#pick_random_cell' do
      it 'returns a valid random cell given a blank board' do
        expect(strategy.pick_random_cell).to be false
      end
    end
    describe '#move' do
      it 'returns false if the board is full' do
        expect(strategy.move).to be false
      end
    end
  end
end
