$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'rspec'
require 'utils'
require 'board'
require 'game'
require 'factory_girl'
require 'support/fake_io'

module Helpers
  module IOUtils
    def local_io(in_str)
      old_stdin, old_stdout = $stdin, $stdout
      $stdin = StringIO.new(in_str)
      $stdout = StringIO.new
      yield
      $stdout.string
    ensure
      $stdin, $stdout = old_stdin, old_stdout
    end
  end
  module Utils
    # utility function to make exercising our utility function DRY
    def user_choice_valid?(choice)
      include Utils
      check_if_x_or_o choice
    end

    def user_input_numeric(choice)
      include Utils
      check_numeric choice
    end
  end
  module Game
    def player_choice(game,choice,expected)
      valid = game.validate_player_choice(choice)
      expect(valid).to be expected
    end

    def make_game_board(game, size)
       game.create_board size
       expect(game.board).to_not be nil
       expect(game.board.rows).to eq(size)
       expect(game.board.cols).to eq(size)
       expect(game.cols).to eq(size)
       expect(game.rows).to eq(size)
    end

    def create_players(game,choice)
      game.create_players(choice)
      expect(game.player).to_not be nil
      expect(game.computer).to_not be nil
      expect(game.player.letter).to eq choice
      computer = choice == 'X' ? 'O' : 'X'
      expect(game.computer.letter).to eq computer
    end

    def grid_size_valid?(game,choice,expectation)
      expect(game.grid_size_choice?(choice)).to be expectation
      expect(game.board).to_not be nil if expectation
    end
  end

  module Board
    def board_valid(rows = 3, cols = 3, valid)
      board = (rows == 3 && cols == 3) ? build(:board) : get_board(rows, cols)
      expect(board.rows).to(eq(rows))
      expect(board.cols).to(eq(cols))
      expect(board.valid?).to(be(valid))
    end

    def valid_move(row, col, expected)
      board = build(:board)
      expect(board.valid_move?(row, col)).to be(expected)
    end

    def get_board(rows, cols)
      build(:board, rows: rows, cols: cols)
    end

    def make_move(board, rows, cols, player, expected)
      expect(board.make_move(rows, cols, player)).to(eq(expected))
    end
  end
end

RSpec.configure do |config|
  config.include Utils
  config.include Helpers
  config.include Helpers::IOUtils
  config.include Helpers::Utils
  config.include Helpers::Board
  config.include Helpers::Game
  config.include FactoryGirl::Syntax::Methods
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  FactoryGirl.find_definitions
end
