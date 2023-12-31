class Board
  attr_reader :cells
  def initialize
    @cells = {

      "A1" => Cell.new('A1'), "A2" => Cell.new('A2'),
      "A3" => Cell.new('A3'), "A4" => Cell.new('A4'),
      "B1" => Cell.new('B1'), "B2" => Cell.new('B2'),
      "B3" => Cell.new('B3'), "B4" => Cell.new('B4'),
      "C1" => Cell.new('C1'), "C2" => Cell.new('C2'),
      "C3" => Cell.new('C3'), "C4" => Cell.new('C4'),
      "D1" => Cell.new('D1'), "D2" => Cell.new('D2'),
      "D3" => Cell.new('D3'), "D4" => Cell.new('D4') 
    }
  end

  def valid_coordinate?(coordinate)
    @cells.key?(coordinate)
  end

  def get_letters(ship, coordinates)
    coordinates.map do |coordinate|
      coordinate[0]
    end
  end

  def get_numbers(ship, coordinates)
    coordinates.map do |coordinate|
      coordinate[1].to_i
    end
  end

  def same_row?(ship, coordinates)
    letters = get_letters(ship, coordinates)
    letters.uniq.length == 1
  end

  def same_column?(ship, coordinates)
    numbers = get_numbers(ship, coordinates)
    numbers.uniq.length == 1
  end
  
  def consecutive_numbers?(ship, coordinates)
    con_numbers = get_numbers(ship, coordinates)
    range = con_numbers[0]..con_numbers[-1]
    con_numbers == range.to_a
  end
  
  def consecutive_letters?(ship, coordinates)
    con_letters = get_letters(ship, coordinates)
    range = con_letters.map do |letter|
      letter.ord
    end[0]..con_letters.map do |letter|
      letter.ord
    end[-1]
    con_letters.map do |letter|
      letter.ord
    end == range.to_a
  end

  def overlap?(ship, coordinates)
    coordinates.any? do |coord|
      @cells[coord].ship
    end
  end

  def valid_placement?(ship, coordinates)
    if 
      !overlap?(ship, coordinates) &&
      ship.length == coordinates.length &&
      same_row?(ship, coordinates) &&
      consecutive_numbers?(ship, coordinates)
      true
    elsif
      !overlap?(ship, coordinates) &&
      ship.length == coordinates.length &&
      same_column?(ship, coordinates) &&
      consecutive_letters?(ship, coordinates)
      true
    else
      false
    end
  end

  def place(ship, coordinates)
    coordinates.each do |coord|
      @cells[coord].place_ship(ship)
    end
  end

  def render(reveal_ship = false)
    rendered_cells = @cells.map do |position, cell|
      cell.render(reveal_ship)
    end
    header = "  1 2 3 4 \n"
    new_rows = rendered_cells.each_slice(4).to_a
    row_1 = "A " + new_rows[0].join(" ") + " \n"
    row_2 ="B " + new_rows[1].join(" ") + " \n"
    row_3 = "C " + new_rows[2].join(" ") + " \n"
    row_4 ="D " + new_rows[3].join(" ") + " \n"
    header + row_1 + row_2 + row_3 + row_4
  end
end