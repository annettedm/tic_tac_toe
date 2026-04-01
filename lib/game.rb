require_relative './board'
require_relative './player'
require_relative 'modules/printable'
require_relative 'modules/validable'
require 'debug'

class Game
  include Printable
  include Validable

  attr_reader :start_new_game

  def initialize
    @round = 1
    @start_new_game = false
  end

  def set_game
    initial_instructions
    set_board
    set_players
    run_game
  end

  # ----------- run game ---------

  def run_game
    run_game_start_players
    current_score

    3.times do |i|
      @round = i + 1
      delimiter
      run_round
      if EXIT_WORDS.values.include?(@input)
        if @input == EXIT_WORDS[:stop_app]
          puts 'The game is stopped.'
          final_scores
          exit
        elsif @input == EXIT_WORDS[:new_game]
          @start_new_game = true
          final_scores
          break
        elsif @input == EXIT_WORDS[:next_round]
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

  # ----------- end of run game ---------

  # ----------- round ---------
  def run_round
    round_number
    @board.show_board

    run_round_turns
  end

  def assign_player(i)
    i.even? ? @p1 : @p2
  end

  def run_round_turns
    (@board.rows ** 2).times do |i|
      player = assign_player(i)
      get_input(player)

      break if exit?

      @board.assign_value(player, @bid)
      @board.show_board

      break if check_for_winner(player)

      current_score
    end
  end

  def exit?
    true if EXIT_WORDS.values.include?(@input)
  end

  def get_input(player)
    round_turns_instructions(player)

    valid_input
  end

  def valid_input
    loop do
      @input = gets.chomp
      break if exit?

      break if @board.valid_bid?(@input)

      invalid_input
    end
  end


  # ----------- end of round ---------

  # ----------- winner ---------

  def check_for_round_winner(player)
    if @board.round_win?(player)
      print_round_winner_announcement(player)
      player.add_score
      current_score
      return true
    end
  end


  # ----------- end of winner ---------

  # ----------- set board ---------
  def set_board
    rows = board_size
    create_board(rows)
    @board.show_board
  end

  def board_size
    board_size_instructions
    rows = nil

    loop do
      rows = gets.chomp
      break if entered_row_valid?(rows)

      board_row_error
    end

    rows
  end

  def create_board(rows)
    @board = Board.new(rows.to_i)
  end

  def entered_row_valid?(rows)
    pattern = Regexp.new(/^[#{Board::ROW_MIN}-#{Board::ROW_MAX}]$/)
    valid_integer?(rows) && rows.match(pattern)
  end

  # ----------- end of set board ---------

  # ----------- set players ---------

  def set_players
    puts "Now we set users."
    @players = []

    @players << Player.new(get_name(0), "x")
    @players << Player.new(get_name(1), "o")
    @p1 = @players[0]
    @p2 = @players[1]
  end


  def get_name(i)
    puts "What's player #{i + 1} name?"
    name = gets.chomp.capitalize
    name =~ /[a-zA-Z]/ ? name : "Stranger"
  end

# ----------- end of set players ---------

  def declare_winner
    if score_positive?
      current_winner
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

  def current_winner
    score(@p1, @p2) if p1_score_bigger?
    score(@p2, @p1) if p2_score_bigger?
    score if p_scores_equal?
  end

end
