class Cell
  attr_reader :coordinate, :ship, :fired_upon

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
    # if @fire_upon 
    #   true
    # else
    #   false
    # end
  end
  
  def fire_upon
    @fired_upon = true
    if !@ship.nil? 
      ship.hit
    end
  end

  def render(reveal_ship = false)
    return "S" if reveal_ship == true
    # if @fired_upon
    #   if !empty? and !@ship.nil?
    #     return "S" if reveal_ship == true
    #     @ship.sunk?
    #     return "X"
    #   elsif !@ship.nil?
    #     return "H"
    #   elsif @ship.nil?
    #     return "M"
    #   else
    #     "."
    #   end
    # end
    # if !@fired_upon
    #   return "."
    # elsif @fired_upon and @ship.nil?
    #   return "M"
    # elsif @fired_upon and @ship.hit
    #   return "H"
    # else @fired_upon and @ship.hit and @ship.sunk?
    #   return "X"    
    # end
    
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