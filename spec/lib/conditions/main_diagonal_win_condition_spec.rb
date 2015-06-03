describe MainDiagonalWinCondition do
  describe '#win?' do
    let!(:win_condition) { build(:main_diagonal_win_condition, :winner) }
    let!(:draw) { build(:main_diagonal_win_condition, :draw) }

    it 'returns true if a winner is on the main diagonal' do
      expect(win_condition.win?).to be true
    end
    it 'returns false if there is not a winner on the minor diagonal' do
      expect(draw.win?).to be false
    end
  end
end
