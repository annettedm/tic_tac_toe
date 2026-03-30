require_relative './helper'

class Board
  include Helper

  attr_reader :rows

  def initialize(rows)
    @board = Array.new(rows) { Array.new(rows) }
    @rows = rows
    @alpha_array = ('A'..'Z').to_a.slice(0, rows)
    show_board
  end

  def assign_value(value, horizontal, vertical = 0)
    horizontal_value = horizontal
    vertical_value = vertical

    if horizontal_value.length == 2
      horizontal_value, vertical_value = convert_bid_to_numbers(horizontal_value)
    end

    @board[horizontal_value][vertical_value] = value
    show_board
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

  def valid_bid?(bid)
    arr_bid = bid.upcase.split("")

    if bid.length == 2
      if @alpha_array.include?(arr_bid[0]) && arr_bid[1].to_i.between?(1, @rows)
        horizontal, vertical = convert_bid_to_numbers(bid)
        if @board[horizontal][vertical].nil?
          return true
        end
      end
    end
    false
  end

  def value_exists?(peg, horizontal, vertical)
    @board[horizontal][vertical] == peg
  end

  def round_winner?(peg)
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

  def convert_bid_to_numbers(bid)
    arr = bid.upcase.split('')
    horizontal = @alpha_array.index(arr[0])
    vertical = arr[1].to_i - 1

    [horizontal, vertical]
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
