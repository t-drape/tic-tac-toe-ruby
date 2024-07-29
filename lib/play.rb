# frozen_string_literal: true

def users
  puts 'Player 1: '
  player_one = gets.chomp
  puts 'Player 2: '
  player_two = gets.chomp
  [player_one, player_two]
end
