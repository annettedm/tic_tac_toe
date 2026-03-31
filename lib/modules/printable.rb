require_relative '../board'

module Printable

  EXIT_WORDS = {
    stop_app: 's',
    next_round: 'r',
    new_game: 'g' }

  private

  def current_score
    puts "Current score is "
    puts "#{@p1.name}: #{@p1.score}"
    puts "#{@p2.name}: #{@p2.score}"
  end

  def delimiter
    puts "-----------------------------"
  end

  def initial_instructions
    delimiter
    puts "Hi. We play Tic tac toe game."
  end

  def print_board_row_error
    puts "The value is not valid. Please, enter an integer from #{Board::ROW_MIN} to #{Board::ROW_MAX}."
  end

  def print_board_size_instructions
    puts "How many cells would you like to have in a row? Please, enter an integer from #{Board::ROW_MIN} to #{Board::ROW_MAX}."
  end

  def print_score winner, loser
    if winner
      puts "#{winner.name} is the winner with the score of #{winner.score}. \n#{loser.name}'s score is #{loser.score}."
    else
       puts "Its a tie. Both players have a score of #{@p1.score}."
    end
  end
end
