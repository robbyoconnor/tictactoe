describe RowWinCondition do
  describe "#win?" do
    let!(:win_condition) { build(:row_win_condition, :winner)}
    let!(:draw) { build(:row_win_condition, :draw)}

    it "returns true if a winner is in a row" do
      expect(win_condition.win?).to be true
    end
    it "returns false if there is not a winner in any row" do
      expect(draw.win?).to be false
    end
  end
end
