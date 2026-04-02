require_relative 'printable'

module Checkable

  def score_positive?
    @p1.score.positive? && @p2.score.positive?
  end

  def p1_score_bigger?
    @p1.score > @p2.score
  end

  def p2_score_bigger?
    @p2.score > @p1.score
  end

  def p_scores_equal?
    @p1.score == @p2.score
  end

  def entered_row_valid?(rows)
    pattern = Regexp.new(/^[#{Board::ROW_MIN}-#{Board::ROW_MAX}]$/)
    valid_integer?(rows) && rows.match(pattern)
  end

  def exit?
    true if Game::EXIT_WORDS.values.include?(@input)
  end

  def round_win?(player)
    peg = player.peg
    board_left_cross?(peg) || board_right_cross?(peg) || board_horizontal?(peg) || board_vertical?(peg)
  end

      ## ----------- end of validate bid ---------
end
