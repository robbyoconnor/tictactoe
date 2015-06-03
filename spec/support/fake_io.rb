# 'support/fake_io'
class FakeIO
  attr_accessor :input, :output

  def initialize(input)
    @input = input
    @output = ''
  end

  def gets
    @input.shift.to_s
  end

  def puts(string)
    @output << "#{string}\n"
  end

  def write(string)
    @output << string
  end

  def self.each_input(input)
    io = new(input)
    $stdin = io
    $stdout = io

    yield

    io.output
  ensure
    $stdin = STDIN
    $stdout = STDOUT
  end
end
