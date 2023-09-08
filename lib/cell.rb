class Cell
  attr_reader :coordinate, :ship
  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
  end

  def empty?
    @ship.nil?
  end

  def place_ship(ship_name)
    @ship = ship_name
  end

  def fire_upon
    if !@ship.nil? 
      ship.health -= 1
    end
  end

  def fired_upon?
    if @fire_upon >= 1
      true
    else
      false
    end
  end
end