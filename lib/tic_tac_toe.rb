# frozen_string_literal: true

# require_relative 'gretting'
# require_relative 'winner'

# Ruby model of a Tic Tac Toe game
class Game
  attr_accessor :board, :current_player

  def initialize(player_one, player_two)
    @player_one = player_one
    @player_two = player_two
    @board = Array.new(3, Array.new(3, ' '))
    @winner = nil
    @current_player = @player_two
  end

  def available_moves
    moves = []
    @board.each_with_index do |row, row_index|
      row.each_with_index do |spot, spot_index|
        moves << [row_index, spot_index] if spot == ' '
      end
    end
    moves
  end

  def move
    move = nil
    available_moves = available_moves()
    until available_moves.include?(move) == true
      greet
      move = gets.chomp.split(',').map(&:to_i)
    end
    move
  end

  def update(board, move, current_player)
    board[move[0]] = board[move[0]].each_with_index.map { |val, index| index != move[1] ? val : current_player }
    @board = board
    board
  end

  def check_current_player
    self.current_player = if current_player == @player_one
                            @player_two
                          else
                            @player_one
                          end
  end

  def play_game
    while check_winner(board, @current_player) != true
      print_out
      check_current_player
      update(board, move, @current_player)
      next unless available_moves.empty? && check_winner(board, @current_player) != true

      salutation
      return
    end
    print_out
    salutation(@current_player)
  end

  def salutation(player = nil)
    if player
      puts "#{player} is the winner!"
    else
      puts "Nobody won! It's a tie!"
    end
  end

  def greet
    puts 'Use Format column, row '
    puts 'Please select an available move: '
  end

  def print_out
    p board[0]
    p board[1]
    p board[2]
  end

  def player(num)
    puts "Player #{num}: "
    gets.chomp
  end

  def users
    players = []
    2.times do |t|
      puts "Player #{t + 1}: "
      players << gets.chomp
    end
    players
  end

  def check_winner(board, current_player)
    wins = []
    check_horizontals(board, current_player, wins)
    check_verts(board, current_player, wins)
    check_diagonals(board, current_player, wins)
    wins.any?(true)
  end

  def check_diagonals(board, current_player, wins)
    diagonals = [[board[0][0], board[1][1], board[2][2]], [board[0][2], board[1][1], board[2][0]]]
    diagonals.each do |row|
      wins << row.all? { |element| element == current_player } ? true : false
    end
    wins
  end

  def check_vertical(board)
    columns = [[], [], []]
    3.times do |t|
      board.each do |row|
        columns[t] << row[t]
      end
    end
    columns
  end

  def check_verts(board, current_player, wins)
    columns = check_vertical(board)
    columns.each do |column|
      wins << column.all? { |e| e == current_player } ? true : false
    end
    wins
  end

  def check_horizontals(board, current_player, wins)
    board.each do |row|
      wins << row.all? { |element| element == current_player } ? true : false
    end
    wins
  end
end
