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

  def board_row_error
    puts "The value is not valid. Please, enter an integer from #{Board::ROW_MIN} to #{Board::ROW_MAX}."
  end

  def board_size_instructions
    puts "How many cells would you like to have in a row? Please, enter an integer from #{Board::ROW_MIN} to #{Board::ROW_MAX}."
  end

  def score winner, loser
    if winner
      puts "#{winner.name} is the winner with the score of #{winner.score}. \n#{loser.name}'s score is #{loser.score}."
    else
      puts "Its a tie. Both players have a score of #{@p1.score}."
    end
  end

  def run_game_start_players
    puts "We have #{@p1.name} playing with #{@p1.peg}"
    puts "We have #{@p2.name} playing with #{@p2.peg}"
  end


  # ----------- round ---------

  def round_number
    puts "Round #{@round}"
  end

  def round_turns_instructions(player)
    puts "#{player.name}, make a choice, enter a letter and a number, for example, A2."
    puts "Enter #{ EXIT_WORDS[:stop_app] } to stop a game. \nEnter #{ EXIT_WORDS[:next_round] } to start a new round. \nEnter #{ EXIT_WORDS[:new_game] } to start a new game."
  end

  def invalid_input
    puts "Your bid is invalid or the cell is already occupied. Please enter 1 letter and 1 number joined."
  end

  def round_winner_announcement(winner)
    puts "We have a round winner. #{winner.name} gets a score."
  end
  # ----------- end of round ---------

end
