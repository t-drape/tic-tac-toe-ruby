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
  attr_accessor :current_player
  def initialize(player_1, player_2)
    @player_1 = player_1
    @player_2 = player_2
    @board = Array.new(3, Array.new(3, ' '))
    @winner = nil
    @current_player = player_2
  end

  def show_board
    puts self.board
  end

  def check_winner(board, current_player)
    wins = []
    diags_and_verts = [[board[0][0], board[1][1], board[2][2]], [board[0][2], board[1][1], board[2][0]], [board[0][0], board[1][0], board[2][0]], [board[0][1], board[1][1], board[2][1]], [board[0][2], board[1][2], board[2][2]]]
    board.each do |row|
      wins << row.all? {|element| element == current_player} ? true : false
    end
    diags_and_verts.each do |row|
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

  def play_game
    while check_winner(self.board, @current_player) != true
      if self.current_player == @player_1
        self.current_player = @player_2
      else
        self.current_player = @player_1
      end
      print_out()
      update(self.board, get_move(), self.current_player)
      if available_moves(self.board).empty?
        print_out()
        puts "Nobody won! It's a tie!"
        return
      end


    end
    print_out
    puts "#{self.current_player} is the winner!"
  end

end

def get_users
  puts "Player 1: "
  player_1 = gets.chomp
  puts "Player 2: "
  player_2 = gets.chomp
  return [player_1, player_2]
end


  players = get_users()
  player_1 = players[0]
  player_2 = players[1]

  new_game = Game.new(player_1, player_2)
  new_game.play_game




