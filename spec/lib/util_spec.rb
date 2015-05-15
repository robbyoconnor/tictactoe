require 'spec_helper'
describe Utils do
    describe "#check_if_x_or_o" do 
        it "X is valid" do 
            user_choice = "X"
            expect(check_if_x_or_o(user_choice)).to be true
        end

        it "O is valid" do
            user_choice = "O"
            expect(check_if_x_or_o(user_choice)).to be true
        end 

        it "invalid input returns false" do
            user_choice = "SSS"
            expect(check_if_x_or_o(user_choice)).to be false
        end
    end
end
