require_relative '../lib/board'

describe Board do

  subject(:board) { described_class.new(5) }

  describe "run game" do

    context "public methods" do

      it 'create_board returns 25 for @board' do
        board.create_board
        expect(board.instance_variable_get(:@board).length).to eq 25
      end
    end

  end

end
