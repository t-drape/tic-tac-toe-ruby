# frozen_string_literal: true

require_relative '../lib/gretting'
require_relative '../lib/tic_tac_toe'

describe '#salutation' do
  context 'when the game is over' do
    it 'returns tie message when no player is given' do
      tie_message = "Nobody won! It's a tie!\n"
      expect { salutation }.to output(tie_message).to_stdout
    end

    it 'returns winner message when input given' do
      win_message = "T is the winner!\n"
      expect { salutation('T') }.to output(win_message).to_stdout
    end
  end
end
