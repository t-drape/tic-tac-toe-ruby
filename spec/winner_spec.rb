# frozen_string_literal: true

require_relative('../lib/winner')

describe '#check_winner' do
  context 'when at least one win' do
    it 'returns true when first row is full' do
      board = [['x', 'x', 'x'],
               ['', '', ''],
               ['', '', '']]
      expect(check_winner(board, 'x')).to eql(true)
    end

    it 'returns true when middle row is full' do
      board = [['', '', ''],
               ['o', 'o', 'o'],
               ['', '', '']]
      expect(check_winner(board, 'o')).to eql(true)
    end

    it 'returns true when third row is full' do
      board = [['', '', ''],
               ['', '', ''],
               ['1', '1', '1']]
      expect(check_winner(board, '1')).to eql(true)
    end
  end

  context 'when no one wins' do
    it 'returns false when board is empty' do
      board = [['', '', ''],
               ['', '', ''],
               ['', '', '']]
      expect(check_winner(board, 'a')).to eql(false)
    end

    it 'returns false when board is full' do
      board = [%w[x y x],
               %w[y x x],
               %w[y x y]]
      x = check_winner(board, 'x')
      y = check_winner(board, 'y')
      expect([x, y]).to all(eql(false))
    end
  end
end
