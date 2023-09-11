class Cell
  attr_accessor :coordinate, :ship
  attr_reader :fired_upon

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
    return "S" if !@ship.nil? && reveal_ship == true
    if @fired_upon && @ship.nil?
     return "M"
    elsif @fired_upon && !@ship.nil? && !@ship.sunk?
      return "H"
    elsif @fired_upon && @ship.sunk?
      return "X"   
    else !@fired_upon
      return "."
    end
  end
end