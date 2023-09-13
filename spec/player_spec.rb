require 'spec_helper'

RSpec.describe Player do
  before(:each) do
    @player = Player.new
  end

  describe '#player' do
    it 'exists and has a board and ships' do
      expect(@player).to be_a(Player)
      expect(@player.board).to be_a(Board)
      expect(@player.cruiser).to be_a(Ship)
      expect(@player.submarine).to be_a(Ship)
    end
  end
end