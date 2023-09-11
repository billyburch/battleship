require 'spec_helper'

RSpec.describe Computer do
  before(:each) do
    @computer = Computer.new
  end

  describe '#initialize' do
    it 'exists and has a board and ships' do
      expect(@computer).to be_a(Computer)
      expect(@computer.board).to be_a(Board)
      expect(@computer.cruiser).to be_a(Ship)
      expect(@computer.submarine).to be_a(Ship)
    end
  end 

  describe '#place_cruiser' do
    it 'places cruiser at a random and valid coordinate' do
      test_coordinates = @computer.place_cruiser
      expect(@computer.board.cells[test_coordinates.last].empty?).to be false
    end
  end

  describe '#place_submarine' do
    it 'places cruiser at a random and valid coordinate' do
      test_coordinates = @computer.place_submarine
      expect(@computer.board.cells[test_coordinates.last].empty?).to be false
    end
  end
end