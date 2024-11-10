# frozen_string_literal: true

require_relative('../lib/tic_tac_toe')

# describe Game do
#   describe '#print_out' do
#     context 'when a board needs to be printed' do
#       subject(:print_board) { described_class.new }
#       it 'prints out each row once' do
#         allow(print_board).to receive(:users)
#         allow(print_board).to receive(:p)
#         expect(print_board).to receive(:p).exactly(3).times
#         print_board.print_out
#       end
#     end
#   end
#   describe '#users' do
#     context 'when a game is initiated' do
#       subject(:name_players) { described_class.new }
#       before do
#         allow(name_players).to receive(:users).and_return(%w[t j])
#         allow(name_players.users).to receive(:puts)
#       end
#       it 'asks for two usernames' do
#         names = %w[t j]
#       end
#     end
#   end
# end

describe Game do
  describe '#initialize' do
    context 'when game is started' do
      subject(:players) { described_class.new('t', 'j') }
      it 'returns player one correctly' do
        expected_player_one = 't'
        real_player_one = players.instance_variable_get(:@player_one)
        expect(real_player_one).to eql(expected_player_one)
      end

      it 'returns plater two correctly' do
        expected_player_two = 'j'
        real_player_two = players.instance_variable_get(:@player_two)
        expect(real_player_two).to eql(expected_player_two)
      end

      it 'assings the correct player to current player' do
        expected_current_player = 'j'
        real_current_player = players.instance_variable_get(:@current_player)
        expect(real_current_player).to eql(expected_current_player)
      end
    end
  end

  describe '#available_moves' do
    context 'retrieves all open spots on the current board' do
      subject(:moves) { described_class.new('t', 'j') }
      it 'returns an array' do
        expect(moves.available_moves).to be_a Array
      end

      it 'returns full array when board is empty' do
        expected_output = [[0, 0], [0, 1], [0, 2],
                           [1, 0], [1, 1], [1, 2],
                            [2, 0], [2, 1], [2, 2]]
        expect(moves.available_moves).to eql(expected_output)
      end

      it "returns correct number of plays when board is not empty" do
        expected_output = [[0, 0], [0, 1], [0, 2],[2, 0], [2, 1], [2, 2]]
        moves.board = [[" ", " ", " "], ["t", "t", "t"], [" ", " ", " "]]
        expect(moves.available_moves).to eql(expected_output)
      end

      it "returns no moves when board is full" do
        moves.board = [['t', 't', 't'], ['t', 't', 't'], ['t', 't', 't']]
        expect(moves.available_moves).to eql([])
      end
    end
  end

  describe "#move" do
    context "when a player decides to move" do
      subject(:mover) { described_class.new("t", "j") } 
      before do
        allow(mover).to receive(:available_moves).and_return([0,0])
        allow(mover).to receive(:greet)
      end
      it "gets the available moves on the board" do
        moves = mover.available_moves
        allow(moves).to receive(:include?).once.and_return(true)
        expect(mover).to receive(:available_moves).once
        mover.move
      end

      it "greets the user once per user input" do
        moves = mover.available_moves
        allow(moves).to receive(:include?).and_return(false, false, true)
        expect(mover).to receive(:greet).twice
        mover.move
      end

      it "returns an available move" do
        expected_move = [0,0]
        moves = mover.available_moves
        allow(moves).to receive(:include?).and_return(false, true)
        expect(mover).to receive(:gets).once.and_return("0, 0\n")
        mover.move
      end

      it "cleans up the user input" do
        expected_move = [0,0]
        move = "0, 0\n"
        moves = mover.available_moves
        allow(moves).to receive(:include?).and_return(false, true)
        allow(mover).to receive(:gets).and_return(move)
        expect(mover.move).to eql(expected_move)
      end
    end
  end
end
