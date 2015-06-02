describe Game do
  g = Game.new
  describe "#validate_player_choice" do
    context "invalid" do
      it "validates player choices correctly" do
        player_choice g, 'XXX',false
        player_choice g, 'OOO',false
        player_choice g, 'A',false
      end
    end

    context "valid" do
      it "validates player choices correctly" do
        player_choice g, 'X',true
        player_choice g, 'O',true
      end
    end
  end

end