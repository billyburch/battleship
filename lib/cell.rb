class Cell
  attr_reader :fired_upon, :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship.nil?
  end

  def place_ship(ship_name)
    @ship = ship_name
  end

  def fired_upon?
    @fired_upon
  end
  
  def fire_upon
    @fired_upon = true
    if !@ship.nil? 
      ship.hit
    end
  end


  def render(reveal_ship = false)
    if @fired_upon && @ship.nil?
     return "M"
    elsif @fired_upon && !@ship.nil? && !@ship.sunk?
      return "H"
    elsif @fired_upon && @ship.sunk?
      return "X"
    elsif !@ship.nil? && reveal_ship == true
      return "S"
    else !@fired_upon
      return "."
    end
  end
end