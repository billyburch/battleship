require 'spec_helper'

RSpec.describe Game do 
  before(:each) do
    @board = Board.new
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

 