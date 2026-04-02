require_relative '../lib/player'

describe Player do
  subject(:player) { described_class.new("Stranger", 'x') }

  it 'add_score, @score equals to 1' do
    player.add_score
    expect(player.instance_variable_get(:@score)).to eq 1
  end
end
