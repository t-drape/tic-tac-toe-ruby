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
    @board = Array.new(3, Array.new(3, ' '))
    @winner = nil
  end

  def show_board
    puts self.board
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

  def update(board, move, current_player)
    board[move[0]] = board[move[0]].each_with_index.map {|val, index| index != move[1] ? val : current_player}
    return board
  end

  def greet()
      puts "Use Format column, row "
      puts "Please select an available move: "
  end

  def get_move
    move = nil
    available_moves = available_moves(self.board)
    until available_moves.include?(move) == true
      greet()
      move = gets.chomp.split(",").map(&:to_i)
    end
    move
  end

  def available_moves(board)
    moves = []
    board.each_with_index do |row, row_index|
      row.each_with_index do |spot, spot_index|
         if spot == ' '
          moves << [row_index, spot_index]
         end
      end
    end
    return moves
  end

  def print_out
    p self.board[0]
    p self.board[1]
    p self.board[2]
  end

  def play_round
    
  end

end

x = Game.new("you", "me")

x.update(x.board, x.get_move, "x")
x.print_out