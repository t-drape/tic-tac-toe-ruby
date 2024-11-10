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
    context 'when game started' do
      it 'returns two new players' do
      end
    end
  end
end
