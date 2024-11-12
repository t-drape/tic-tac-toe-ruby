# frozen_string_literal: true

require_relative 'lib/tic_tac_toe'

puts 'Player One: '
p_one = gets.chomp
puts 'Player Two: '
p_two = gets.chomp
new_game = Game.new(p_one, p_two)

new_game.play_game
