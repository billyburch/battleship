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

    it 'splits string elements into separate arrays of letters/numbers' do
      expect(@board.get_letters(@cruiser, ["A1", "A2"])).to eq(["A", "A"])
      expect(@board.get_numbers(@cruiser, ["A1", "A2"])).to eq([1, 2])
    end

    it 'coordinate numbers are consecutive' do
      expect(@board.consecutive_numbers?(@cruiser, ["A1", "A2", "A4"])).to be false
      expect(@board.consecutive_numbers?(@submarine, ["A1", "C1"])).to be false
      expect(@board.consecutive_numbers?(@cruiser, ["A3", "A2", "A1"])).to be false
      expect(@board.consecutive_numbers?(@submarine, ["C1", "B1"])).to be false
      expect(@board.consecutive_numbers?(@submarine, ["A1", "A2"])).to be true
      expect(@board.consecutive_numbers?(@cruiser, ["A2", "A3", "A4"])).to be true
    end

    it 'coordinate letters are consecutive' do
      expect(@board.consecutive_letters?(@cruiser, ["A1", "A2", "C4"])).to be false
      expect(@board.consecutive_letters?(@submarine, ["A1", "C1"])).to be false
      expect(@board.consecutive_letters?(@cruiser, ["A3", "A2", "A1"])).to be false
      expect(@board.consecutive_letters?(@submarine, ["C1", "B1"])).to be false
      expect(@board.consecutive_letters?(@submarine, ["A1", "B1"])).to be true
      expect(@board.consecutive_letters?(@cruiser, ["A2", "B2", "C2"])).to be true
    end

    it 'checks rows and columns' do
      expect(@board.same_row?(@cruiser, ["A1", "B2", "C3"])).to be false
      expect(@board.same_column?(@cruiser, ["A1", "B2", "C3"])).to be false
      expect(@board.same_row?(@submarine, ["A2", "A3", "A4"])).to be true
      expect(@board.same_column?(@submarine, ["A2", "A3", "A4"])).to be false
      expect(@board.same_row?(@submarine, ["A2", "B2", "C2"])).to be false
      expect(@board.same_column?(@submarine, ["A2", "B2", "C2"])).to be true
    end

    it 'coordinates are consecutive' do
      expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A4"])).to be false
      expect(@board.valid_placement?(@submarine, ["A1", "C1"])).to be false
      expect(@board.valid_placement?(@cruiser, ["A3", "A2", "A1"])).to be false
      expect(@board.valid_placement?(@submarine, ["C1", "B1"])).to be false
    end

    it 'coordinates are not diagonal' do
      expect(@board.valid_placement?(@cruiser, ["A1", "B2", "C3"])).to be false
      expect(@board.valid_placement?(@submarine, ["C2", "D3"])).to be false
    end

    it 'valid placements return true' do
      expect(@board.valid_placement?(@submarine, ["A1", "A2"])).to be true
      expect(@board.valid_placement?(@cruiser, ["B1", "C1", "D1"])).to be true
    end
  end

  describe '#place' do
    it 'places a ship on the board in given cells' do
      @board.place(@cruiser, ["A1", "A2", "A3"])
      expect(cell_1 = @board.cells["A1"]).to be_a(Cell)
      expect(cell_2 = @board.cells["A2"]).to be_a(Cell)
      expect(cell_3 = @board.cells["A3"]).to be_a(Cell)
      expect(cell_1.ship).to be_a(Ship)
      expect(cell_2.ship).to be_a(Ship)
      expect(cell_3.ship).to be_a(Ship)
      expect(cell_3.ship == cell_2.ship).to be true
    end

    it 'checks if ships are overlapping' do
      @board.place(@cruiser, ["A1", "A2", "A3"])
      cell_1 = @board.cells["A1"]
      cell_2 = @board.cells["A2"]
      cell_3 = @board.cells["A3"]
      expect(@board.valid_placement?(@submarine, ["A1", "B1"])).to be false
    end
  end

  describe '#render' do
    it 'renders an empty board' do
     expected_output = "  1 2 3 4 \n" +
                       "A . . . . \n" +
                       "B . . . . \n" +
                       "C . . . . \n" +
                       "D . . . . \n"
      expect(@board.render).to eq(expected_output)
    end

    it 'renders a board with ships' do
      @board.place(@cruiser, ["A1", "A2", "A3"])
      expected_output = "  1 2 3 4 \n" +
                        "A S S S . \n" +
                        "B . . . . \n" +
                        "C . . . . \n" +
                        "D . . . . \n"
      expect(@board.render(true)).to eq(expected_output)
    end

    it 'mimicks gameplay not showing ships' do
      @board.place(@cruiser, ["A1", "A2", "A3"])
      @board.place(@submarine, ["C1", "D1"])
      cell_1 = @board.cells["A1"]
      cell_2 = @board.cells["A2"]
      cell_3 = @board.cells["A3"]
      cell_8 = @board.cells["B4"]
      cell_9 = @board.cells["C1"]
      cell_13 = @board.cells["D1"]
      cell_1.fire_upon
      cell_8.fire_upon
      cell_9.fire_upon
      cell_13.fire_upon
      expected_output = "  1 2 3 4 \n" +
                        "A H . . . \n" +
                        "B . . . M \n" +
                        "C X . . . \n" +
                        "D X . . . \n"
      expect(@board.render).to eq(expected_output)
    end

    it 'mimicks gameplay showing ships' do
      @board.place(@cruiser, ["A1", "A2", "A3"])
      @board.place(@submarine, ["C1", "D1"])
      cell_1 = @board.cells["A1"]
      cell_2 = @board.cells["A2"]
      cell_3 = @board.cells["A3"]
      cell_8 = @board.cells["B4"]
      cell_9 = @board.cells["C1"]
      cell_13 = @board.cells["D1"]
      cell_1.fire_upon
      cell_8.fire_upon
      cell_9.fire_upon
      cell_13.fire_upon
      expected_output = "  1 2 3 4 \n" +
                        "A H S S . \n" +
                        "B . . . M \n" +
                        "C X . . . \n" +
                        "D X . . . \n"
      expect(@board.render(true)).to eq(expected_output)
    end
  end
end
