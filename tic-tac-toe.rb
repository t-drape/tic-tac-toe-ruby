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
# 4 params per mehtod


class Game
  attr_accessor :board
  def initialize(player_1, player_2)
    @player_1 = player_1
    @player_2 = player_2
    @board = Array.new(3, Array.new(3, "x"))
    @winner_exists = false
  end

  def show_board
    p @board
  end

  def check_winner(board, current_player)
    wins = []
    diags = [[board[0][0], board[1][1], board[2][2]], [board[0][2], board[1][1], board[2][0]]]
    board.each do |row|
      wins << row.all? {|element| element == current_player} ? true : false
    end
    diags.each do |row|
      wins << row.all? {|element| element == current_player} ? true : false
    end
    wins.any?(true)
  end

  private
  attr_accessor :winner_exists
end

x = Game.new("x", "y")

x.check_winner(x.board, "y")