$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'utils'

RSpec.configure do |config|
  config.include Utils
   config.expect_with :rspec do |c|
    c.syntax = :expect    
  end
end
module Helpers
    # utility function to make exercising our utility function DRY
    def user_choice_valid? choice
        include Utils
        return check_if_x_or_o choice
    end

    def user_input_numeric choice
        include Utils
        return check_numeric choice
    end


end
