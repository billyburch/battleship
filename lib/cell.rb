class Cell
  attr_accessor :coordinate
  attr_reader :ship, :fired_upon

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
    return "S" if reveal_ship == true
    if @fired_upon and @ship.nil?
      return "M"
    elsif @fired_upon and !@ship.nil? and !@ship.sunk?
      return "H"
    elsif @fired_upon and @ship.sunk?
      return "X"   
    else !@fired_upon
      return "."
    end
  end
end