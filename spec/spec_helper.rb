$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'utils'
RSpec.configure do |config|
  config.order = 'random'
  config.include Utils  
end