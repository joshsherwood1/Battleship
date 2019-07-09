class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @empty = true
    @ship = ship
    @fired_upon = false

  end

  def place_ship(cruiser_or_sub)
    @ship = cruiser_or_sub
  end

  def empty?
    @ship.nil?
  end

  def fired_upon?
    if @ship.health < 3
      return true
    else
      return false
    end
  end

  def fire_upon
    @fired_upon = true
    if empty? == false
     return @ship.hit
    end
  end

  def render(ship_in_cell = false)

    if @fired_upon == true && @ship.nil? == false && @ship.health == 0
      return "X"
    elsif @fired_upon == true && @ship.nil? == false && @ship.health > 0
      return "H"
    elsif ship_in_cell == true && @ship.nil? == false
      return "S"
    elsif empty? && @fired_upon == true
      return "M"
    else empty? && @fired_upon == false
      return "."
    end
  end
end
