# frozen_string_literal: true

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
