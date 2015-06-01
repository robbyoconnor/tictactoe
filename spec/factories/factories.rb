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
end
