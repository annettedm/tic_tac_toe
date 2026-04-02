module Checkable

  def valid_integer? str
    Integer(str)
    true
  rescue ArgumentError, TypeError
    false
  end

  def valid_bid?(bid)
    if bid.length == 2 && whole_bid_valid?(bid)
      return cell_empty? bid
    end
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

  def cell_empty? bid
    horizontal, vertical = convert_bid_to_numbers(bid)
    @board[horizontal][vertical].nil?
  end

  def round_win?(player)
    peg = player.peg
    board_left_cross?(peg) || board_right_cross?(peg) || board_horizontal?(peg) || board_vertical?(peg)
  end

end
