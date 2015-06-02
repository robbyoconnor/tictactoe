describe Condition do
  let!(:condition) { build(:condition) }
  describe "#win?" do
    it "returns false" do
      expect(condition.win?).to be false
    end
  end
end