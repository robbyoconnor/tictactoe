describe Strategy do
  let!(:strategy) { build(:strategy) }
  describe '#move' do
    it 'returns false' do
      expect(strategy.move).to be false
    end
  end
end
