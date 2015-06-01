describe Utils do
  describe '#check_if_x_or_o' do
    context 'parameters invalid or missing' do
      it 'raises an error if not passed any parameters' do
        expect { check_if_x_or_o }.to raise_error ArgumentError
      end

      it 'raises an error if more than one argument is given' do
        expect { check_if_x_or_o('X', 'O') }.to raise_error ArgumentError
      end
    end

    context 'valid input' do
      it 'X and O is valid' do
        expect(user_choice_valid?('X')).to be true
        expect(user_choice_valid?('O')).to be true
      end
    end

    context 'invalid input' do
      it 'invalid input returns false' do
        expect(user_choice_valid?('SSS')).to be false
        expect(user_choice_valid?('S')).to be false
        expect(user_choice_valid?('XX')).to be false
        expect(user_choice_valid?('OO')).to be false
        expect(user_choice_valid?('OOXX')).to be false
      end
    end
  end

  describe '#check_numeric' do
    it 'returns false if a string is not numeric' do
      expect(user_input_numeric('lorem ipsum')).to be false
      expect(user_input_numeric('May 14, 1982')).to be false
    end

    it 'returns true if all numeric' do
      expect(user_input_numeric '12').to be true
      expect(user_input_numeric '1 2').to be true
    end
  end

  describe "#error" do
    it "prints a string which is light_red with the message given" do
      output = capture_stdout do
        print error("testing 123")
      end
      expect(output).to eq("\e[0;91;49mtesting 123\e[0m")
    end
  end

  describe "#color" do
    it "returns light_green if the player is \"X\"" do
      expect(color("X")).to eq(:light_green)
      expect(color("O")).to eq(:light_red)
    end
  end
end
