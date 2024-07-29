# tic-tac-toe-ruby
A simple tic-tac-toe game written in Ruby that allows two players to play a game from the command line.

If interested, here is the pseudocode and metal process I created for myself: (In addition, I created a flow chart/to-do list to visualize each piece coming together :)
# frozen_string_literal: true

# {[x | x | x],
# [x | x | x],
# [x | x | x] }

# Create loop for game to run until either user has three boxes in a row
# While no winner exists, play turn
# Playing a turn consists of:
# 1. User seeing old game board
# 2. User selecting box for current move
# 3. Box updating
# 4. Checking for winner
# 5. Displaying new box
# 6. If winner, display message and end play
# 7. Else, play turn until winner
# Think of game board as 3x3, a hash of arrays
# For each move, update value of hash
# Switch current player
# Get user input after prompt:
# 1. “What is your move? “
# 2. If input is invalid or
# 3. Move has already been played
# 4. Re prompt user with message
# 5. “Spot already taken or invalid input.”

# To check for winner:
# See if either user has three values in a continuous line. Horizontal, Vertical, or Diagonal.

# Variables?
# Current player
# Game Board hash
# Move choice from user

# Methods?
# IsWinner?(board)
# PlayTurn(old_board, current_user)

# Classes?
# Player, with value (X, O), name?

# 100 lines per class
# 5 lines per method
# 4 params per method

After my initial attempt, I noticed several problems from RuboCop. The main one was checking the vertical and diagonal ways to win. In my original attempt my ABCmetrics score was 46, out of 17! So after a break, and with fresh eyes, I attempted to refactor my code to reduce the problems, hopefully eliminating all of them. And after breaking the method up into several smaller ones, I was able to do just that!