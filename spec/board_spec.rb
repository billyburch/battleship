require 'spec_helper'

RSpec.describe Board do
  before(:each) do
    @board = Board.new
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  describe '#cells' do
    it 'returns a hash' do
      expect(@board.cells).to be_a(Hash)
      expect(@board.cells.length).to eq(16)
      expect(@board.cells.values.first).to be_a(Cell)
      expect(@board.cells.values[2]).to be_a(Cell)
    end
  end

  describe '#valid_coordinate?' do
    it 'tells us if coordinate is on board' do
      expect(@board.valid_coordinate?("A1")).to be true
      expect(@board.valid_coordinate?("D4")).to be true
      expect(@board.valid_coordinate?("A5")).to be false
      expect(@board.valid_coordinate?("E1")).to be false
      expect(@board.valid_coordinate?("A22")).to be false
    end
  end

  describe '#valid_placement?' do
    it 'number of coordinates equals ship length' do
      expect(@board.valid_placement?(@cruiser, ["A1", "A2"])).to be false
      expect(@board.valid_placement?(@submarine, ["A2", "A3", "A4"])).to be false
    end

    it 'coordinates are consecutive' do
      expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A4"])).to be false
      expect(@board.valid_placement?(@submarine, ["A1", "C1"])).to be false
      expect(@board.valid_placement?(@cruiser, ["A3", "A2", "A1"])).to be false
      expect(@board.valid_placement?(@submarine, ["C1", "B1"])).to be false
      expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A3"])).to be true
    end

    it 'coordinates are not diagonal' do
      expect(@board.valid_placement?(@cruiser, ["A1", "B2", "C3"])).to be false
      expect(@board.valid_placement?(@submarine, ["C2", "D3"])).to be false
    end
  end

  describe '#place' do
    xit 'places a ship on the board in given cells' do
      board.place(cruiser, ["A1", "A2", "A3"]) 
      cell_1 = board.cells["A1"]
      cell_2 = board.cells["A2"]
      cell_3 = board.cells["A3"]
      expect(cell_1.ship).to be_a(@cruiser)
      expect(cell_2.ship).to be_a(@cruiser)
      expect(cell_3.ship).to be_a(@cruiser)
      expect(cell_3.ship == cell_2.ship).to be true
    end
  end

end
