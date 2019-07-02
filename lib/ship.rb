class Ship
  attr_reader :name, :health, :length
  def initialize(name, health)
    @name = name
    @dmg_count = 3
    @health = @dmg_count
    @length = @health

  end

  def sunk?
    false
  end

def hit  #tweak hit algo to rotate
  @ship_1 = Ship.new("Cruiser", @dmg_count )
  @dmg_count -= 3  #need a space between the - 1 when doing this.
  @ship_1.health
#   case yogurt
#     when 3
#       case ship_1.health - 1
#     when
#       case @dmg_store << yogurt
#     else
#       case @dmg_store << yogurt
#     end #end_case
#     @dmg_store[0]
end

  end #end class
