module Checkable

  def valid_integer? str
    Integer(str)
    true
  rescue ArgumentError, TypeError
    false
  end


  def whole_bid_valid? bid

    bid_letter_valid?(bid.slice(0).capitalize) && bid_number_valid?(bid.slice(1))
  end

  def bid_letter_valid? letter
    @alpha_array.include? letter
  end

  def bid_number_valid? number
    valid_integer?(number) && number.to_i.between?(1, @rows)
  end


  def round_win?(player)
    peg = player.peg
    board_left_cross?(peg) || board_right_cross?(peg) || board_horizontal?(peg) || board_vertical?(peg)
  end


  private

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

  def cell_empty? bid
    horizontal, vertical = convert_bid_to_numbers(bid)
    @board[horizontal][vertical] == ' '
    # any would be nil, need to check for ' '
  end

  def valid_bid?(bid)
    return false if bid.nil?

    return cell_empty? bid if bid.length == 2 && whole_bid_valid?(bid)

    false
  end

  def valid_player?(player)
    player.respond_to?(:peg) && !player.peg.nil?
  end
end
