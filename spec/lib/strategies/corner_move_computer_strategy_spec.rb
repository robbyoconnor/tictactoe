describe CornerMoveComputerStrategy do
  context "blank board" do
    let!(:strategy) {  build(:corner_move, game: build(:game,board: build(:board, :blank)))}
    describe "#get_corners" do
      it "returns the 4 corners of a 3x3 board" do
        expect(strategy.get_corners).to match_array [[0, 0], [0, 2], [2, 2], [2, 0]]
      end
    end
    describe "#get_valid_corner_moves" do
      it "returns all valid corner moves" do
        expect(strategy.get_valid_corner_moves).to match_array [[0, 0], [0, 2], [2, 2], [2, 0]]
      end
    end

  end
end