require_relative './game'

def start_app
  game = Game.new
  game.set_game

  if game.start_new_game
    start_app
  end
end

start_app
