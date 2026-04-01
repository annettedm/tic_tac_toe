require_relative './board'
require_relative './player'
require_relative 'modules/printable'
require_relative 'modules/validable'
require_relative 'modules/checkable'
require 'debug'

class Game
  include Printable
  include Validable
  include Checkable

  attr_reader :start_new_game

  def initialize
    @round = 1
    @new_game = false
    @next_round = false
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

    run_game_loop

    if @new_game
      puts "A new game is started."
      return
    else
      delimiter
      puts 'The game is over.'
      declare_winner
    end
  end

  def process_exit_words
    if @input == EXIT_WORDS[:stop_app]
      puts 'The game is stopped.'
      final_scores
      exit
    elsif @input == EXIT_WORDS[:new_game]
      @new_game = true
      final_scores
    elsif @input == EXIT_WORDS[:next_round]
      @next_round = true
    end
  end

  def run_game_loop
    3.times do
      @round += 1
      delimiter
      run_round
      break if @new_game
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

      break if @new_game || @next_round

      @board.assign_value(player, @input)
      @board.show_board

      break if check_for_round_winner(player)

      current_score
    end
  end

  def get_input(player)
    round_turns_instructions(player)

    valid_input
  end

  def valid_input
    loop do
      @input = gets.chomp
      if exit?
        process_exit_words
      end


      break if @board.valid_bid?(@input) || @new_game || @next_round

      invalid_input
    end
  end


  # ----------- end of round ---------

  # ----------- winner ---------

  def check_for_round_winner(player)
    if @board.round_win?(player)
      round_winner_announcement(player)
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

  # ----------- end of set board ---------

  # ----------- set players ---------

  def set_players
    puts "Now we set users."

    @p1 = Player.new(get_name(0), 'x')
    @p2 = Player.new(get_name(1), 'o')
  end


  def get_name(i)
    puts "What's player #{i + 1} name?"
    @input = gets.chomp.capitalize
    define_player_name
  end

  def define_player_name
    @input =~ /[a-zA-Z]/ ? @input : "Stranger"
  end

  # ----------- end of set players ---------

  def declare_winner
    return unless score_positive?
    current_winner
  end

  def final_scores
    current_score
    declare_winner
  end

  def current_winner
    score(@p1, @p2) if p1_score_bigger?
    score(@p2, @p1) if p2_score_bigger?
    score if p_scores_equal?
  end

end
