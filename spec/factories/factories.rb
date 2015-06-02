FactoryGirl.define do
  factory :board, class: Board do
    rows 3
    cols 3
    moves_left 9
    trait :main_diag_win do
      board [%w(X O X), %w(O X O), %w(O O X)]
    end

    trait :minor_diag do
      board [%w(X O O), %w(O O O), %w(O X O)]
    end

    trait :minor_diag_win do
      board [[' ', ' ', 'X'], [' ', 'X', ' '], ['X', ' ', ' ']]
    end

    trait :major_diag_win do
      board [['X', ' ', ' '], [' ', 'X', ' '], [' ', ' ', 'X']]
    end

    trait :row_winner do
      board [%w(X X X), [' ', ' ', ' '], [' ', ' ', ' ']]
    end

    trait :column_winner do
      board [['X', ' ', ' '], ['X', ' ', ' '], ['X', ' ', ' ']]
    end
    trait :draw do
      board [%w(X O O), %w(O X X), %w(X O O)]
    end

    trait :blank do
      board [[' ', ' ', ' '], [' ', ' ', ' '], [' ', ' ', ' ']]
    end
  end

  factory :game, class: Game do
    rows 3
    cols 3
    player { build(:human, letter: 'X', game: self) }
    computer { build(:computer, letter: 'O', game: self) }
    turn { player }
    trait :computer_turn do
      turn { computer }
    end

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
      game { build(:game, board: build(:board, :column_winner)) }
    end
    trait :draw do
      game { build(:game, board: build(:board, :draw)) }
    end
    initialize_with { new(game) }
  end
end