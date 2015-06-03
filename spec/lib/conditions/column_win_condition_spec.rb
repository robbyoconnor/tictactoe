describe ColumnWinCondition do
  describe '#win?' do
    let!(:win_condition) { build(:column_win_condition, :winner) }
    let!(:draw) { build(:column_win_condition, :draw) }

    it 'returns true if a winner is in a column' do
      expect(win_condition.win?).to be true
    end
    it 'returns false if there is not a winner in any column' do
      expect(draw.win?).to be false
    end
  end
end
