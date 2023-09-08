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
    it 'changes to true after fire_upon called on cell' do
      @cell.place_ship(@cruiser)
      expect(@cell.fired_upon?).to be false
      @cell.fire_upon
      expect(@cell.ship.health).to eq(2)
      expect(@cell.fired_upon?).to be true
      
    end
  end
  
  describe '#render' do
    it 'returns string representation of cell' do
      cell_1 = Cell.new("B4")
      expect(cell_1.render).to eq(".")
      cell_1.fire_upon
      # require 'pry'; binding.pry
      expect(cell_1.render).to eq("M")
      cell_2 = Cell.new("C3")
      cell_2.place_ship(@cruiser)
      expect(cell_2.render).to eq(".")
      expect(cell_2.render(true)).to eq("S")
      cell_2.fire_upon
      expect(cell_2.render).to eq("H")
      expect(@cruiser.sunk?).to be false
      @cruiser.hit
      @cruiser.hit
      # require 'pry'; binding.pry
      expect(@cruiser.sunk?).to be true
      expect(cell_2.render).to eq("X")
    end
  end
end
