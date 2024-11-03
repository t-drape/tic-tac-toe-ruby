# frozen_string_literal: true

require_relative('../lib/winner')

describe '#check_horizontals' do
  context 'when a player wins on a full row' do
    it 'returns true when first row is full' do
      board = [['x', 'x', 'x'],
               ['', '', ''],
               ['', '', '']]
      expect(check_horizontals(board, 'x', [])).to include(true)
    end

    it 'returns true when the middle row if full' do
      board = [['', '', ''],
               ['o', 'o', 'o'],
               ['', '', '']]
      expect(check_horizontals(board, 'o', [])).to include(true)
    end

    it 'returns true when the third row is full' do
      board = [['', '', ''],
               ['', '', ''],
               ['1', '1', '1']]
      expect(check_horizontals(board, '1', [])).to include(true)
    end
  end
  context 'when called' do
    it 'calls each for board' do
      board = [['', '', ''],
               ['', '', ''],
               ['1', '1', '1']]
      expect(board).to receive(:each)
      check_horizontals(board, 'x', [])
    end
  end
end

describe '#check_verts' do # rubocop:disable Metrics/BlockLength
  context 'when no column is filled' do
    it 'returns false' do
      board = [['', '', ''],
               ['', '', ''],
               ['', '', '']]
      expect(check_verts(board, 'x', [])).to all(eql(false))
    end
  end

  context 'when at least one column is filled' do
    it 'returns true for column zero' do
      board = [['1', '', ''],
               ['1', '', ''],
               ['1', '', '']]
      expect(check_verts(board, '1', []).first).to be(true)
    end

    it 'returns true for column one' do
      board = [['', '1', ''],
               ['', '1', ''],
               ['', '1', '']]
      expect(check_verts(board, '1', [])[1]).to be(true)
    end

    it 'returns true for column two' do
      board = [['', '', 'x'],
               ['', '', 'x'],
               ['', '', 'x']]
      expect(check_verts(board, 'x', []).last).to be(true)
    end

    it 'returns the wins as an array' do
      board = [['', '', 'x'],
               ['', '', 'x'],
               ['', '', 'x']]
      expect(check_verts(board, 'x', [])).to eql([false, false, true])
    end
  end
end

describe '#check_diagonals' do
  context 'when board empty' do
    it 'returns false' do
      board = [['', '', ''],
               ['', '', ''],
               ['', '', '']]
      expect(check_diagonals(board, 'x', [])).to all(eql(false))
    end
  end
end

# Move to tic tac toe spec file!!!!

# describe '#check_winner' do
#   context 'when one player has two wins' do
#     it 'returns true' do
#       board = [['x', '', ''],
#                ['', 'x', ''],
#                ['x', 'x', 'x']]
#       expect(check_winner(board, 'x')).to eql(true)
#     end
#   end

#   context 'when no one wins' do
#     it 'returns false when board is empty' do
#       board = [['', '', ''],
#                ['', '', ''],
#                ['', '', '']]
#       expect(check_winner(board, 'a')).to eql(false)
#     end

#     it 'returns false when board is full' do
#       board = [%w[x y x],
#                %w[y x x],
#                %w[y x y]]
#       x = check_winner(board, 'x')
#       y = check_winner(board, 'y')
#       expect([x, y]).to all(eql(false))
#     end
#   end

#   context 'when check_winner called' do
#     subject(:function_tests) { Game.new('t', 'j') }
#     before do
#       allow(function_tests).to receive(:check_winner).and_return(true)
#     end
#     it 'returns true' do
#       board = [['', '', ''],
#                ['', '', ''],
#                ['', '', '']]
#       expect(function_tests.check_winner(board, 'x')).to eql(true)
#     end
#   end
