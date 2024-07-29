# frozen_string_literal: true

def play_game
  while check_winner(board, @current_player) != true
    print_out
    check_current_player
    update(board, move, @current_player)
    next unless available_moves(board).empty? && check_winner(board, @current_player) != true

    salutation
    return
  end
  salutation(@current_player)
end

def users
  puts 'Player 1: '
  player_one = gets.chomp
  puts 'Player 2: '
  player_two = gets.chomp
  [player_one, player_two]
end
