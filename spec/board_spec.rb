require_relative '../lib/board'
require_relative './helpers/board_helper'
require_relative '../lib/player'
include BoardHelper

describe Board do

  subject(:board) { described_class.new(5) }

  context "#create_board" do

    subject(:board_zero) { described_class.new(0) }
    subject(:board_negative) { described_class.new(-3) }

    it 'returns 25 cells for @board' do
      board.create_board
      board_array = board.instance_variable_get(:@board)
      cells = count_array_cells(board_array)
      expect(cells).to eq 25
    end

    it 'returns 0 cells if rows number is 0' do
      board_zero.create_board
      board_array = board_zero.instance_variable_get(:@board)
      cells = count_array_cells(board_array)
      expect(cells).to eq 0
    end

    it 'returns nil if rows are negative' do
      board_negative.create_board
      expect(board_negative.instance_variable_get(:@board)).to be_nil
    end
  end

  describe "#insert_peg" do
    context "#valid_player?" do

      before do
        # @player = Player.new("Stranger", 'x')
        @player = Player.new('Stranger', 'x')
        @board_instance = board.instance_variable_get(:@board)
        allow(board).to receive(:valid_bid?).and_return(true)
        allow(board).to receive(:convert_bid_to_numbers).and_return([0, 1])
      end

      it 'insert_peg sends message to valid_player?' do
        expect(board).to receive(:valid_player?)
        board.insert_peg(@player, 'a1')
      end

      it 'bid is inserted when valid_player? returns true' do
        board.insert_peg(@player, 'a1')

        expect(@board_instance[0][1]).to eq 'x'
      end

      it 'bid not inserted when player does not respond to peg' do
        player_does_not_respond_to_peg = instance_double("Player")
        board.insert_peg(player_does_not_respond_to_peg, 'a1')
        expect(@board_instance[0][1]).to eq ' '
      end

      it 'bid not inserted when player peg is nil' do
        player_peg_nil = instance_double("Player")
        allow(player_peg_nil).to receive(:peg).and_return nil
        board.insert_peg(player_peg_nil, 'a1')
        expect(@board_instance[0][1]).to eq ' '
      end
    end

    context "#valid_bid?" do
      before do
        # @player = Player.new("Stranger", 'x')
        @player = Player.new('Stranger', 'x')
        @board_instance = board.instance_variable_get(:@board)
        allow(board).to receive(:valid_player?).and_return(true)
        allow(board).to receive(:convert_bid_to_numbers).and_return([0, 1])
      end

      it 'insert_bid sends message to valid_bid?' do
        expect(board).to receive(:valid_bid?)
        board.insert_peg(@player, 'a1')
      end

      it 'bid is inserted at @board[0][1] in normal flow' do
        board.insert_peg(@player, 'a1')
        expect(@board_instance[0][1]).to eq 'x'
      end

      it 'bid not inserted when bid is nil' do
        board.insert_peg(@player, nil)
        expect(@board_instance[0][1]).to eq ' '
      end

      it 'bid not inserted when bid length is not equal to 2' do
        board.insert_peg(@player, 'a1d')
        expect(@board_instance[0][1]).to eq ' '
      end

      xit 'bid not inserted when when whole_bid_valid? returns false' do
      end

      xit 'bid not inserted when cell_empty? returns false' do

      end

      xit 'bid not inserted when both valid_player? and valid_bid? return false' do

      end
    end

    context "#whole_bid_valid?" do

    end

    context "#cell_empty?" do

    end



  end



# -----------
    xit 'normal flow' do
      # allow(board).to receive(:valid_player?).and_return(true)
      # allow(board).to receive(:valid_bid?).and_return(true)
      board.insert_peg(@player, 'a1')

      expect(@board_instance[0][1]).to eq 'x'
    end

    xit 'player does not respond to Player' do
      expect(board.insert_peg(@player, 'x')).to be_nil
    end

    xit 'player peg is empty' do
      allow(@player).to receive(:peg).and_return(nil)

      expect(board.insert_peg(@player, 'x')).to be_nil
    end

    xit 'bid is empty/invalid' do
      allow(@player).to receive(:peg).and_return('x')

      expect(board.insert_peg(@player, nil)).to be_nil
    end



    xit 'check if horizontal and vertical values are in @board array bounds' do

    end

    xit 'check if convert_bid_to_numbers is called' do

    end
end
