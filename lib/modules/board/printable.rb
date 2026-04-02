require_relative '../../board'

module Printable

  def board_row_error
    puts "The value is not valid. Please, enter an integer from #{Board::ROW_MIN} to #{Board::ROW_MAX}."
  end

end
