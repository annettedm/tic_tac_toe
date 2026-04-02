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
    @board = Array.new(@rows) { Array.new(@rows) }
  end

  def assign_value(player, horizontal, vertical = 0)
    peg = player.peg
    horizontal_value = horizontal
    vertical_value = vertical

    horizontal_value, vertical_value = convert_bid_to_numbers(horizontal_value) if horizontal_value.length == 2

    @board[horizontal_value][vertical_value] = peg
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

  # private

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

  def board_left_cross?(peg)
    counter = 0

    @rows.times do |i|
      counter += 1 if @board[i][i] == peg
    end

    counter_equals_rows?(counter)
  end

  def board_right_cross?(peg)
    counter = 0
    back_counter = @rows - 1

    @rows.times do |i|
      counter += 1 if @board[i][back_counter] == peg
      back_counter -= 1
    end
    counter_equals_rows?(counter)
  end

  def board_horizontal?(peg)
    @rows.times do |i|
      counter = 0
      @rows.times do |j|
        counter += 1 if @board[i][j] == peg
      end
      return true if counter_equals_rows?(counter)
    end
    false
  end

  def board_vertical?(peg)
    @rows.times do |i|
      counter = 0
      @rows.times do |j|
        counter += 1 if @board[j][i] == peg
      end
      return true if counter_equals_rows?(counter)
    end
    false
  end

  def counter_equals_rows?(counter)
    counter == @rows
  end
end
