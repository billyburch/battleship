require 'spec_helper'

RSpec.describe Ship do
  before(:each) do
    @cruiser = Ship.new("Cruiser", 3)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@cruiser).to be_a(Ship)
      expect(@cruiser.name).to eq('Cruiser')
      expect(@cruiser.length).to eq(3)
      expect(@cruiser.health).to eq(@cruiser.length)
    end
  end

  describe '#sunk?' do
    it 'defaults to false' do
      expect(@cruiser.sunk?).to be false
    end
  end

  describe '#hit' do
    it 'takes hits, subtracts from health, sinks' do
      @cruiser.hit
      expect(@cruiser.health).to eq(2)
      @cruiser.hit
      expect(@cruiser.health).to eq(1)
      @cruiser.hit
      expect(@cruiser.health).to eq(0)
      expect(@cruiser.sunk?).to be true
    end
  end
end

# stops before 'Cell'