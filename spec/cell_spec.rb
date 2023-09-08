require 'spec_helper'

RSpec.describe Cell do
  before(:each) do
    @cruiser = Ship.new("Cruiser", 3)
    @cell = Cell.new("B4")
  end

  describe '#initialize' do
    it 'exists' do
      expect(@cell).to be_a(Cell)
      expect(@cell.coordinate).to eq("B4")
      expect(@cell.ship).to eq(nil)
    end
  end

  describe '#empty?' do
    it 'defaults to true' do
      expect(@cell.empty?).to be true
    end
  end

  describe '#place_ship' do
    it 'places a ship on the cell' do
      @cell.place_ship(@cruiser)
      expect(@cell.ship).to eq(@cruiser)
      expect(@cell.empty?).to be false
    end
  end

  describe '#fired_upon?' do
    it 'fired_upon defaults false' do
      @cell.place_ship(@cruiser)
      expect(@cell.fired_upon?).to be false
      @cell.fire_upon
      expect(@cell.ship.health).to eq(2)
      require 'pry'; binding.pry
      expect(@cell.fired_upon?).to be true
      
    end
  end
end

#stopped before 'render' method