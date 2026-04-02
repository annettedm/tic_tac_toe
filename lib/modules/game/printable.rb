require_relative '../../board'
require_relative '../shared/printable'

module Printable

  def current_score
    puts "Current score is "
    puts "#{@p1.name}: #{@p1.score}"
    puts "#{@p2.name}: #{@p2.score}"
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

  def score(winner = nil, loser = nil)
    if winner
      puts "#{winner.name} is the winner with the score of #{winner.score}. \n#{loser.name}'s score is #{loser.score}."
    else
      puts "Its a tie. Both players have a score of #{@p1.score}."
    end
  end

  def request_name(i)
    puts "What's player #{i + 1} name?"
  end

  def set_players_instructions
    puts "Now we set players."
  end

  def players_pegs
    puts "We have #{@p1.name} playing with #{@p1.peg}"
    puts "We have #{@p2.name} playing with #{@p2.peg}"
  end

  def game_over_message
    puts 'The game is over.'
  end

  def game_stopped_message
    puts 'The game is stopped.'
  end

  def new_game_message
    puts "A new game is started."
  end

  def new_round_message
    puts "A new round is started."
  end

  # ----------- round ---------

  def round_number
    puts "Round #{@round}"
  end

  def round_turns_instructions
    puts "#{@player.name}, make a choice, enter a letter and a number, for example, A2."
    puts "Enter #{ Game::EXIT_WORDS[:stop_app] } to stop a game. \nEnter #{ Game::EXIT_WORDS[:next_round] } to start a new round. \nEnter #{ Game::EXIT_WORDS[:new_game] } to start a new game."
  end

  def invalid_input
    puts "Your bid is invalid or the cell is already occupied. Please enter 1 letter and 1 number joined."
  end

  def round_winner_announcement
    puts "We have a round winner. #{@player.name} gets a score."
  end
  # ----------- end of round ---------

end
