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
# 4 params per mehtod

# Ruby model of a Tic Tac Toe game
class Game
  attr_accessor :board, :current_player

  def initialize(player_one, player_two)
    @player_one = player_one
    @player_two = player_two
    @board = Array.new(3, Array.new(3, ' '))
    @winner = nil
    @current_player = player_two
  end

  def dv
    diagonals = [[board[0][0], board[1][1], board[2][2]], [board[0][2], board[1][1], board[2][0]]]
    verts = [[board[0][0], board[1][0], board[2][0]], [board[0][1], board[1][1], board[2][1]],
             [board[0][2], board[1][2], board[2][2]]]
    diagonals + verts
  end

  def check_winner(board, current_player)
    wins = []
    board.each do |row|
      wins << row.all? { |element| element == current_player } ? true : false
    end
    dv.each do |row|
      wins << row.all? { |element| element == current_player } ? true : false
    end
    wins.any?(true)
  end

  def update(board, move, current_player)
    board[move[0]] = board[move[0]].each_with_index.map { |val, index| index != move[1] ? val : current_player }
    board
  end

  def greet
    puts 'Use Format column, row '
    puts 'Please select an available move: '
  end

  def move
    move = nil
    available_moves = available_moves(board)
    until available_moves.include?(move) == true
      greet
      move = gets.chomp.split(',').map(&:to_i)
    end
    move
  end

  def available_moves(board)
    moves = []
    board.each_with_index do |row, row_index|
      row.each_with_index do |spot, spot_index|
        moves << [row_index, spot_index] if spot == ' '
      end
    end
    moves
  end

  def print_out
    p board[0]
    p board[1]
    p board[2]
  end

  def check_current_player
    self.current_player = if current_player == @player_one
                            @player_two
                          else
                            @player_one
                          end
  end

  def salutation(player = nil)
    print_out
    if player
      puts "#{current_player} is the winner!"
    else
      puts "Nobody won! It's a tie!"

    end
  end

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
end

def users
  puts 'Player 1: '
  player_one = gets.chomp
  puts 'Player 2: '
  player_two = gets.chomp
  [player_one, player_two]
end

players = users
player_one = players[0]
player_two = players[1]

new_game = Game.new(player_one, player_two)
new_game.play_game
