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

  attr_reader :new_game

  def initialize
    @round = 0
    @new_game = false
    @next_round = false
  end

  def set_game
    initial_instructions
    set_board
    set_players
    game
  end

  # ----------- run game ---------

  def game
    players_pegs
    current_score

    game_loop

    return if @new_game

    delimiter
    game_over_message
    declare_winner
  end

  def process_exit
    if @input == EXIT_WORDS[:stop_app]
      game_stopped_message
      final_scores
      exit
    elsif @input == EXIT_WORDS[:new_game]
      @new_game = true
      final_scores
      delimiter
      new_game_message
    elsif @input == EXIT_WORDS[:next_round]
      @next_round = true
      delimiter
      new_round_message
      delimiter
      delimiter
    end
  end

  def game_loop
    3.times do
      @round += 1
      delimiter
      @board.create_board
      run_round
      break if @new_game
    end
  end

  # ----------- end of run game ---------

  # ----------- round ---------
  def run_round
    round_number
    @board.show_board

    round_turns
  end

  def assign_player(i)
    @player = i.even? ? @p1 : @p2
  end

  def round_turns
    (@board.rows ** 2).times do |i|
      assign_player(i)
      input

      break if @new_game || @next_round

      @board.assign_value(@player, @input)
      @board.show_board

      if @board.round_win?(@player)
        process_round_winner
        break
      end

      current_score
    end
  end

  def input
    round_turns_instructions
    valid_input
  end

  def valid_input
    loop do
      @input = gets.chomp
      process_exit if exit?

      break if @board.valid_bid?(@input) || @new_game || @next_round

      invalid_input
    end
  end

  # ----------- end of round ---------

  # ----------- winner ---------

  def process_round_winner
    round_winner_announcement
    @player.add_score
    current_score
  end

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
    set_players_instructions

    @p1 = Player.new(player_name(0), 'x')
    @p2 = Player.new(player_name(1), 'o')
  end


  def player_name(i)
    request_name(i)
    @input = gets.chomp.capitalize
    define_player_name
  end

  def define_player_name
    @input = @input.empty? ? "Stranger" : @input
  end

  # ----------- end of set players ---------
end
