FactoryGirl.define do
  factory :board, class: Board

  factory :main_diag_win, class: Board do
    board [%w(X O X), %w(O X O), %w(O O X)]
  end

  factory :minor_diag, class: Board do
    board [%w(X O O), %w(O O O), %w(O X O)]
  end

  factory :minor_diag_win, class: Board do
    board [[' ', ' ', 'X'], [' ', 'X', ' '], ['X', ' ', ' ']]
  end

  factory :major_diag_win, class: Board do
    board [['X', ' ', ' '], [' ', 'X', ' '], [' ', ' ', 'X']]
  end

  factory :row_winner, class: Board do
    board [%w(X X X), [' ', ' ', ' '], [' ', ' ', ' ']]
  end

  factory :column_winner, class: Board do
    board [['X', ' ', ' '], ['X', ' ', ' '], ['X', ' ', ' ']]
  end
  factory :draw, class: Board do
    board [%w(X O O), %w(O X X), %w(X O O)]
  end

  factory :game, class: Game do
    rows 3
    cols 3
    player { build(:human, letter: 'X', game: self) }
    computer { build(:computer, letter: 'O', game: self) }
    turn { player }
  end

  factory :human, class: Human do
    letter 'X'
    initialize_with { new(letter, game) }
  end

  factory :computer, class: Computer do
    letter 'O'
    initialize_with { new(letter, game) }
  end

  factory :column_win_condition, class: ColumnWinCondition do

    trait :winner do
      game { build(:game, board: build(:column_winner)) }
    end
    trait :draw do
      game { build(:game, board: build(:draw)) }
    end
    initialize_with { new(game) }
  end
end
