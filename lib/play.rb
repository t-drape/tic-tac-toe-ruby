# frozen_string_literal: true

# def users
#   player_one = p_one
#   puts 'Player 2: '
#   player_two = gets.chomp
#   [player_one, player_two]
# end

def users
  players = []
  2.times do |t|
    puts "Player #{t + 1}: "
    players << gets.chomp
  end
  players
end
