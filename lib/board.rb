require_relative './modules/printable'
require_relative './modules/validable'


class Board
  include Printable
  include Validable

  ROW_MIN = 3
  ROW_MAX = 9

  attr_reader :rows

  def initialize(rows)
    @board = Array.new(rows) { Array.new(rows) }
    @rows = rows
    @alpha_array = ('A'..'Z').to_a.slice(0, rows)
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


  # ----------- validate bid ---------
  def valid_bid?(bid)
    if bid.length == 2 && whole_bid_valid?(bid)
      return cell_empty? bid
    end
    false
  end

  def convert_bid_to_numbers(bid)
    arr = bid.upcase.split('')
    horizontal = @alpha_array.index(arr[0])
    vertical = arr[1].to_i - 1

    [horizontal, vertical]
  end

  def whole_bid_valid? bid
    bid_letter_valid?(bid.slice(0)) && bid_number_valid?(bid.slice(1))
  end

  def bid_letter_valid? letter
    @alpha_array.include? letter
  end

  def bid_number_valid? number
    valid_integer?(number) && number.to_i.between?(1, @rows)
  end

  def cell_empty? bid
    horizontal, vertical = convert_bid_to_numbers(bid)
    @board[horizontal][vertical].nil?
  end

  # ----------- end of validate bid ---------

  # def value_exists?(peg, horizontal, vertical)
  #   @board[horizontal][vertical] == peg
  # end

  def round_win?(player)
    peg = player.peg
    board_left_cross?(peg) || board_right_cross?(peg) || board_horizontal?(peg) || board_vertical?(peg)
  end

  private

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

    counter == @rows
  end

  def board_right_cross?(peg)
    counter = 0
    back_counter = @rows - 1

    @rows.times do |i|
      counter += 1 if @board[i][back_counter] == peg
      back_counter -= 1
    end
    counter == @rows
  end

  def board_horizontal?(peg)
    @rows.times do |i|
      counter = 0
      @rows.times do |j|
        counter += 1 if @board[i][j] == peg
      end
      return true if counter == @rows
    end
    return false
  end

  def board_vertical?(peg)
    @rows.times do |i|
      counter = 0
      @rows.times do |j|
        counter += 1 if @board[j][i] == peg
      end
      return true if counter == @rows
    end
    return false
  end
end
