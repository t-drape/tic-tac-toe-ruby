# frozen_string_literal: true

player_one, player_two = users

new_game = Game.new(player_one, player_two)

new_game.play_game
