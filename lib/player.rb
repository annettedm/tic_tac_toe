class Player
  attr_accessor :score
  attr_reader :peg, :name

  def initialize(name, peg)
    @name = name
    @peg = peg
    @score = 0
  end

  def add_score
    @score += 1
  end
end
