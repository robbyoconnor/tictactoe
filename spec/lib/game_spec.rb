describe Game do
  describe '#initialize' do
    let(:game) { build(:game)}
    it "sets @game_over to false" do
      expect(game.game_over).to be(false)
    end
  end
end
