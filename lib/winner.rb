# frozen_string_literal: true

def check_diagonals(board, current_player, wins)
  diagonals = [[board[0][0], board[1][1], board[2][2]], [board[0][2], board[1][1], board[2][0]]]
  diagonals.each do |row|
    wins << row.all? { |element| element == current_player } ? true : false
  end
end

def check_verts_zero(board, current_player, wins)
  row_zero = []
  board.each do |row|
    row.each_with_index do |val, v_index|
      row_zero << val if v_index.zero?
    end
  end
  wins << row_zero.all? { |element| element == current_player } ? true : false
end

def check_verts_one(board, current_player, wins)
  row_one = []
  board.each do |row|
    row.each_with_index do |val, v_index|
      row_one << val if v_index == 1
    end
  end
  wins << row_one.all? { |element| element == current_player } ? true : false
end

def check_verts_two(board, current_player, wins)
  row_two = []
  board.each do |row|
    row.each_with_index do |val, v_index|
      row_two << val if v_index == 2
    end
  end
  wins << row_two.all? { |element| element == current_player } ? true : false
end

def check_verts(board, current_player, wins)
  check_verts_zero(board, current_player, wins)
  check_verts_one(board, current_player, wins)
  check_verts_two(board, current_player, wins)
  wins
end

def check_winner(board, current_player)
  wins = []
  board.each do |row|
    wins << row.all? { |element| element == current_player } ? true : false
  end
  check_verts(board, current_player, wins)
  wins.any?(true)
end
