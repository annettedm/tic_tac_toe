module Printable

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

  def print_score winner, loser
    if winner
      puts "#{winner.name} is the winner with the score of #{winner.score}. \n#{loser.name}'s score is #{loser.score}."
    else
       puts "Its a tie. Both players have a score of #{@p1.score}."
    end
  end
end
