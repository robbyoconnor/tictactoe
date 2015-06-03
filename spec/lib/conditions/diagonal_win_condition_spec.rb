describe DiagonalWinCondition do
  let!(:win_condition_draw) { build(:main_diagonal_win_condition, :draw) }
  describe '#main_diagonal' do
    it 'gives only elements on the main diagonal' do
      expect(win_condition_draw.main_diagonal).to eq(%w(X X O))
    end
  end
  describe '#minor_diagonal' do
    it 'gives only elements on the main diagonal' do
      expect(win_condition_draw.minor_diagonal).to eq(%w(O X X))
    end
  end

  describe '#diagonal_winner' do
    context 'main diagonal winner' do
      let!(:win_condition) { build(:main_diagonal_win_condition, :winner) }
      it 'a draw does not return as a winner' do
        expect(win_condition_draw.diagonal_win('main')).to be false
      end

      it 'returns a win if the winner has won on the main diagonal' do
        expect(win_condition.diagonal_win('main')).to be true
      end
    end
  end
  context 'minor diagonal winner' do
    let!(:win_condition) { build(:minor_diagonal_win_condition, :winner) }
    let!(:win_condition_draw) { build(:minor_diagonal_win_condition, :draw) }
    it 'a draw does not return as a winner' do
      expect(win_condition_draw.diagonal_win('main')).to be false
    end

    it 'returns a win if the winner has won on the main diagonal' do
      expect(win_condition.diagonal_win('minor')).to be true
    end
  end
end
