# frozen_string_literal: true

require_relative('../lib/tic_tac_toe')

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

  describe "#update" do
    context "when a move is made" do
      subject(:board_update) {described_class.new("t", "j")}
      it "returns a new board" do
        expect(board_update.update(board_update.board, [0,0], @current_player)).to be_a Array
      end

      it "updates the board to reflect the move" do
        expected_board = [["j", " ", " "], [" ", " ", " "], [" ", " ", " "]]
        expect {board_update.update(board_update.board, [0,0], "j")}.to change {board_update.board}.to(expected_board)
      end
    end
  end

  describe "#check_current_player" do
    context "it updates who the current player is" do
      subject(:current_players) { described_class.new("t", "j") }
      it "returns player one when current player is player two" do
        p_one = current_players.instance_variable_get(:@player_one)
        p_two = current_players.instance_variable_get(:@player_two)
        expect { current_players.check_current_player }.to change {current_players.current_player}.from(p_two).to(p_one)
      end

      it "returns player two when the current player is player one" do
        current_players.current_player = "t"
        p_one = current_players.instance_variable_get(:@player_one)
        p_two = current_players.instance_variable_get(:@player_two)
        expect { current_players.check_current_player }.to change {current_players.current_player}.from(p_one).to(p_two)
      end
    end
  end

  describe "#play_game" do
    context "when the game loop is started" do
      subject(:game_loop) { described_class.new("t", "j") }
      before do
        allow(game_loop).to receive(:print_out)
        allow(game_loop).to receive(:salutation)
        allow(game_loop).to receive(:update)
        allow(game_loop).to receive(:move)
      end
      it "runs the loop only if no winner exists" do
        allow(game_loop).to receive(:check_winner).and_return(true)
        expect(game_loop).to receive(:check_winner).once.and_return(true)
        game_loop.play_game
      end

      it "runs the loop until a winner exists" do
        allow(game_loop).to receive(:check_winner).and_return(false, false, false, true)
        expect(game_loop).to receive(:update).exactly(3).times
        game_loop.play_game
      end
    end

    context "when run, it calls all helper functions" do
      subject(:game_functions) { described_class.new("t", "J") }
      before do
        allow(game_functions).to receive(:check_winner).and_return(false, true)
        allow(game_functions).to receive(:print_out)
        allow(game_functions).to receive(:check_current_player)
        allow(game_functions).to receive(:update)
        allow(game_functions).to receive(:move)
        allow(game_functions).to receive(:salutation)
        allow(game_functions).to receive(:available_moves).and_return([0,0])
      end

      it "calls print out inside loop, and once outside the loop" do
        expect(game_functions).to receive(:print_out).twice
        game_functions.play_game
      end

      it "calls salutation once at the end of the game" do
        expect(game_functions).to receive(:salutation).once
        game_functions.play_game
      end

      it "calls check_current_player once per loop" do
        expect(game_functions).to receive(:check_current_player).once
        game_functions.play_game
      end

      it "calls update once per loop" do
        expect(game_functions).to receive(:update).once
        game_functions.play_game
      end

      it "calls move once inside loop inside update" do
        expect(game_functions).to receive(:move).once
        game_functions.play_game
      end

      it "calls update with the correct values" do
        allow(game_functions).to receive(:move).and_return([0,0])
        current_player = game_functions.instance_variable_get(:@current_player)
        expect(game_functions).to receive(:update).with(game_functions.board, [0,0],  current_player)
        game_functions.play_game
      end

      it "calls salutation even if the game is tied" do
        allow(game_functions).to receive(:available_moves).and_return([])
        allow(game_functions).to receive(:check_winner).and_return(false)
        expect(game_functions).to receive(:salutation).once
        game_functions.play_game
      end

      it "calls available moves once" do
        expect(game_functions).to receive(:available_moves).and_return([0,0])
        game_functions.play_game
      end

      it "calls check_winner inside the loop as well" do
        expect(game_functions).to receive(:check_winner).exactly(2).times
        game_functions.play_game
      end
    end
  end

  describe "#salutation" do
    context "when game over, uses correct phrase" do
      subject(:game_over) { described_class.new("t", "j") }
      it "prints name message if name provided" do
        expect(game_over).to receive(:puts).once.with("James is the winner!")
        game_over.salutation("James")
      end
      
      it "prints outs tie message with no input" do
        expect(game_over).to receive(:puts).once.with("Nobody won! It's a tie!")
        game_over.salutation
      end
    end
  end

  describe "#print_out" do
    context "shows the board between each round" do
      subject(:show_round) { described_class.new("t", "j") }
      it "shows each of the rows" do
        # show_round.board = [["x", "x", "x"], ["x", "x", "x"], ["x", "x", "x"]]
        allow(show_round).to receive(:p)
        expect(show_round).to receive(:p).exactly(3).times
        show_round.print_out
      end

      it "shows the rows correctly" do
        show_round.board = [['x','x', 'x'], ['x', 'o', 'x'], ['o', 'x', 'x']]
        expect {show_round.print_out}.to output(("#{show_round.board[0]}\n#{show_round.board[1]}\n#{show_round.board[2]}\n")).to_stdout
      end
    end
  end

  describe "#check_winner" do
    context "when a round is played, called to see if a winner exists" do
      subject(:winner) {described_class.new("t", "j")}
      it "returns any number of wins" do
        allow(winner).to receive(:check_horizontals).and_return([true, true])
        expect(winner.check_winner(winner.board, winner.current_player)).to be(true)
      end

      it "calls check_horizontals once" do
        allow(winner).to receive(:check_horizontals).and_return([false])
        allow(winner).to receive(:check_verts).and_return([false])
        allow(winner).to receive(:check_diagonals).and_return([false])
        expect(winner).to receive(:check_horizontals).once
        winner.check_winner(winner.board, winner.current_player)
      end
    end

    context "it calls the other check functions each once" do
      subject(:winner) {described_class.new("t", "j")}
      before do
        allow(winner).to receive(:check_horizontals).and_return([false])
        allow(winner).to receive(:check_verts).and_return([false])
        allow(winner).to receive(:check_diagonals).and_return([false])
      end

      it "calls check_horizontals once" do
        expect(winner).to receive(:check_horizontals).once
        winner.check_winner(winner.board, winner.current_player)
      end

      it "calls check_verts once" do
        expect(winner).to receive(:check_verts).once
        winner.check_winner(winner.board, winner.current_player)
      end

      it "calls check_diagonals once" do
        expect(winner).to receive(:check_diagonals).once
        winner.check_winner(winner.board, winner.current_player)
      end
    end

    context "when called, it uses the same variables for each check" do
      before do
        allow(winner).to receive(:check_horizontals).and_return([false])
        allow(winner).to receive(:check_verts).and_return([false])
        allow(winner).to receive(:check_diagonals).and_return([false])
      end
      subject(:winner) {described_class.new("t", "j")}

      it "uses the same variables for check_horizontals" do
        expect(winner).to receive(:check_horizontals).once.with(winner.board, winner.current_player, [])
        winner.check_winner(winner.board, winner.current_player)
      end

      it "uses the same variables for check_verts" do
        expect(winner).to receive(:check_verts).once.with(winner.board, winner.current_player, [false])
        winner.check_winner(winner.board, winner.current_player)
      end

      it "uses the same variables for check_diagonals" do
        expect(winner).to receive(:check_diagonals).once.with(winner.board, winner.current_player, [false, false])
        winner.check_winner(winner.board, winner.current_player)
      end
    end
  end

  describe "#check_diagonals" do
    context "when board is not full" do
      subject(:diagonals) { described_class.new("x", "o") }

      it "returns an array" do
        expect(diagonals.check_diagonals(diagonals.board, diagonals.current_player, [])).to be_kind_of(Array)
      end

      it "returns false filled array when no diagonal wins on board" do
         expect(diagonals.check_diagonals(diagonals.board, diagonals.current_player, [])).to all eql(false)
      end

      it "returns array with true when diagonal from top right is on board" do
        board = [['', '', 'x'],
                ['', 'x', ''],
                ['x', '', '']]
        expect(diagonals.check_diagonals(board, 'x', [])).to include(true)
      end

      it "returns array with true when diagonal from topl left is on the board" do
        board = [['x', '', ''],
                ['', 'x', ''],
                ['', '', 'x']]
        expect(diagonals.check_diagonals(board, 'x', [])).to include(true)
      end
    end

    context "when board is full" do
      subject(:diagonals) { described_class.new("x", "o") }
      it "returns false when no diagonal found" do
        board = [["x", "x", "x"], ["x", "o", "o"], ["x", "o", "x"]]
        current_player = "x"
        expect(diagonals.check_diagonals(board, current_player, [])).to eql([false, false])
      end

      it "returns true filled array when both diagonals are filled" do
        board = [["x", "o", "x"], ["o", "x", "o"], ["x", "o", "x"]]
        current_player = "x"
        expect(diagonals.check_diagonals(board, "x", [])).to all eql(true)
      end
    end
  end

  describe "#check_vertical" do
    context "when a board is vertically cehecked, returns the columns filled with players" do
      subject(:columns) { described_class.new("x", "o") }
      it "cycles through each row of board" do
        board = [%w[x o x],
                %w[x o x],
                %w[x o x]]
        expect(board).to receive(:each).exactly(3).times
        columns.check_vertical(board)
      end

      it "returns an array" do
        expect(columns.check_vertical(columns.board)).to be_kind_of(Array)
      end

      it "returns the correct value" do
        expected_output = [["x", "x", "x"], ["o", "x", "o"], ["x", "x", "o"]]
        board = [%w[x o x],
                %w[x x x],
                %w[x o o]]
        expect(columns.check_vertical(board)).to eql(expected_output)
      end
    end
  end

  describe "#check_verts" do
    context "when a board is checked, it checks the columns for any wins" do
      subject(:verticals) { described_class.new("x", "o") }

      before do
        allow(verticals).to receive(:check_vertical).and_return([["x", "x", "x"], ["o", "x", "o"], ["x", "x", "o"]])        
      end

      it "calls check_vertical for columns" do
        expect(verticals).to receive(:check_vertical).once
        verticals.check_verts(verticals.board, verticals.current_player, [])
      end

      it "returns an array" do
        expect(verticals.check_verts(verticals.board, verticals.current_player, [])).to be_kind_of(Array)
      end

      it "returns a win as true" do
        current_player = "x"
        expect(verticals.check_verts(verticals.board, current_player, [])).to eql([true, false, false])
      end

      it "returns all false when no column is full of one player" do
        current_player = "x"
        columns = [%w[o x o], %w[x o x], %w[o x o]]
        allow(verticals).to receive(:check_vertical).and_return(columns)
        expect(verticals.check_verts(verticals.board, current_player, [])).to all be(false)
      end
    end
  end

  describe "#check_horizontals" do
    context "when the wins are a full row across" do
      subject(:horizontals) { described_class.new("x", "o") }

      it "returns an array" do
        expect(horizontals.check_horizontals(horizontals.board, horizontals.current_player, [])).to be_kind_of(Array)
      end

      it "returns an array full of false when no values present" do
        expect(horizontals.check_horizontals(horizontals.board, horizontals.current_player, [])).to all eql(false)
      end

      it "calls each on the given input board" do
        expect(horizontals.board).to receive(:each).once
        horizontals.check_horizontals(horizontals.board, horizontals.current_player, [])
      end

      it "correctly identifies a full row and counts it as a win" do
        board = [%w[o o o ], %w[o x o], %w[o o o]]
        current_player = "o"
        expected_output = [true, false, true]
        expect(horizontals.check_horizontals(board, current_player, [])).to eql(expected_output)
      end
    end
  end
end
