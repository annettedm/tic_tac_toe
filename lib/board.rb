require_relative './modules/board/checkable'
require_relative './modules/board/printable'
require_relative './modules/shared/checkable'
require_relative './modules/shared/printable'


class Board
  include Printable
  include Checkable

  ROW_MIN = 3
  ROW_MAX = 9

  attr_reader :rows

  def initialize(rows)
    @rows = rows
    create_board
    assign_letters
  end

  def create_board
    @board = Array.new(@rows) { Array.new(@rows, ' ') } if @rows.is_a?(Integer) && @rows >= 0
  end

  def insert_peg(player, bid)
    return unless valid_player?(player) && valid_bid?(bid)

    horizontal, vertical = convert_bid_to_numbers(bid)

    @board[horizontal][vertical] = player.peg
  end

  def show_board
    delimiter
    puts show_board_numbers
    @board.each_with_index do |outer, i|
      line = "#{@alpha_array[i]} "

      outer.each do |inner|
        line << "[#{inner ? inner : " "}]"
      end
      puts line
    end
    delimiter
  end

  private

  def assign_letters
    @alpha_array = ('A'..'Z').to_a.slice(0, rows)
  end

  def convert_bid_to_numbers(bid)
    arr = bid.upcase.split('')
    horizontal = @alpha_array.index(arr[0])
    vertical = arr[1].to_i - 1

    [horizontal, vertical]
  end

  def show_board_numbers
    numbers = "  "
    @rows.times do |i|
      numbers << "|#{i + 1}|"
    end
    numbers
  end
end
