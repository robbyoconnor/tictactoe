describe Utils do
    include Helpers
    describe "#check_if_x_or_o" do                 
        context "parameters invalid or missing" do            
            it "raises an error if not passed any parameters" do             
                expect { check_if_x_or_o }.to raise_error ArgumentError        
            end

            it "raises an error if more than one argument is given" do
                expect { check_if_x_or_o("X","O")}.to raise_error ArgumentError           
            end
        end

        context "valid input" do 
            it "X and O is valid" do             
                expect(user_choice_valid?('X')).to be true
                expect(user_choice_valid?('O')).to be true
            end
        end 

        context "invalid input" do        
            it "invalid input returns false" do            
                expect(user_choice_valid?('SSS')).to be false
                expect(user_choice_valid?('S')).to be false            
            end
        end           
    end    
end
