require './lib/cell'
require './lib/ship'
require './lib/board'
require './lib/player'

class Computer 
  attr_reader :board, :cruiser, :submarine
  def initialize 
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @letters = ["A", "B", "C", "D"]
    @numbers = ["1", "2", "3", "4"]
  end

  def valid_cruiser_coordinates
    coordinates = []
    until board.valid_placement?(@cruiser, coordinates) == true
      coordinates = []
      @cruiser.length.times do 
        coordinates << @letters.shuffle.first + @numbers.shuffle.first
      end
    end
    coordinates
  end

  def valid_submarine_coordinates
    coordinates = []
    until board.valid_placement?(@submarine, coordinates) == true
      coordinates = []
      @submarine.length.times do 
        coordinates << @letters.shuffle.first + @numbers.shuffle.first
      end
    end
    coordinates
  end

  def place_cruiser
    coordinates = valid_cruiser_coordinates
    coordinates.each do |coordinate|
      @board.cells[coordinate].place_ship(@cruiser)
    end
    coordinates
  end

  def place_submarine
    coordinates = valid_submarine_coordinates
    coordinates.each do |coordinate|
      @board.cells[coordinate].place_ship(@submarine)
    end
    coordinates
  end

  def computer_aim_fire

  end

end