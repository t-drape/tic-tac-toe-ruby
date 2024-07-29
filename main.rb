# frozen_string_literal: true

require_relative 'lib/tic_tac_toe'
require_relative 'lib/play'

player_one, player_two = users

new_game = Game.new(player_one, player_two)

new_game.play_game
