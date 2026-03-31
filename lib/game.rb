require_relative './board'
require_relative './player'
require_relative 'modules/printable'
require 'debug'

class Game
  include Printable

  attr_reader :start_new_game

  def initialize
    @round = 1
    @exit_reason = ""
    @start_new_game = false
  end

  def set_game
    initial_instructions
    set_board
    set_players
    run_game
  end

  def run_game
    puts "We have #{@p1.name} playing with #{@p1.peg}"
    puts "We have #{@p2.name} playing with #{@p2.peg}"
    current_score

    3.times do |i|
      @round = i + 1
      delimiter
      run_round
      if EXIT_WORDS.values.include?(@exit_reason)
        if @exit_reason == EXIT_WORDS[:stop_app]
          puts 'The game is stopped.'
          final_scores
          exit
        elsif @exit_reason == EXIT_WORDS[:new_game]
          @start_new_game = true
          final_scores
          break
        elsif @exit_reason == EXIT_WORDS[:next_round]
          next
        end
      end

    end
    if @start_new_game
      puts "A new game is started."
    else
      delimiter
      puts 'The game is over.'
      declare_winner
    end
  end

  def run_round
    puts "Round #{@round}"
    create_board

    (@rows ** 2).times do |i|
      player = assign_player(i)

      puts "#{player.name}, make a choice, enter a letter and a number, for example, A2."
      puts "Enter #{EXIT_WORDS[:stop_app]} to stop a game. \nEnter #{EXIT_WORDS[:next_round]} to start a new round. \nEnter #{EXIT_WORDS[:new_game]} to start a new game."

      bid = gets.chomp

      break if exit_reason_entered?(bid)

      bid_result = @board.valid_bid?(bid)

      while !bid_result
        puts "Your bid is invalid or the cell is already occupied. Please enter 1 letter and 1 number joined."
        bid = gets.chomp

        bid_result = @board.valid_bid?(bid)
      end

      @board.assign_value(player.peg, bid)

      if @board.round_winner?(player.peg)
        round_winner(player)
        break
      end
      current_score
    end

  end

  def round_winner(winner)
    puts "We have a round winner. #{winner.name} gets a score."
    add_score(winner)
    current_score
  end

  def set_board
    get_board_size
    create_board
  end

  def get_board_size
    print_board_size_instructions

    loop do
      @rows = gets.chomp
      break if entered_row_valid?
      print_board_row_error
    end
  end

  def create_board
    @board = Board.new(@rows.to_i)
  end

  # player

  def set_players
    puts "Now we set users."
    @players = []

    @players << Player.new(get_name(0), "x")
    @players << Player.new(get_name(1), "o")
    @p1 = @players[0]
    @p2 = @players[1]
  end

  def assign_player(i)
    i.even? ? @p1 : @p2
  end

  def get_name(i)
    puts "What's player #{i + 1} name?"
    name = gets.chomp.capitalize
    name =~ /[a-zA-Z]/ ? name : "Stranger"
  end

  def add_score(winner)
    winner.score += 1
  end

  # exit reasons
  def exit_reason_entered?(bid)
    if EXIT_WORDS.values.include?(bid)
      @exit_reason = bid
      return true
    end
  end

  # show scores and winner
  def declare_winner
    if score_positive?
      show_score
    end
  end

  def final_scores
    current_score
    declare_winner
  end

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

  def show_score
    print_score(@p1, @p2) if p1_score_bigger?
    print_score(@p2, @p1) if p2_score_bigger?
    print_score if p_scores_equal?
  end

  def valid_integer? str
    Integer(str)
    true
  rescue ArgumentError, TypeError
    false
  end

  def entered_row_valid?
    pattern = Regexp.new(/^[#{Board::ROW_MIN}-#{Board::ROW_MAX}]$/)
    valid_integer?(@rows) && @rows.match(pattern)
  end
end
