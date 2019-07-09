class Board
  attr_reader :cells

  def initialize
    @cells = cell_generator
  end

  def cell_generator
    {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4")
    }
  end

  def valid_coordinate?(coordinate)
    @cells.keys.include?(coordinate)
  end

  def place(ship,coordinate_array)
    if valid_placement?(ship,coordinate_array)
      coordinate_array.each do |coordinate|
        @cells[coordinate].place_ship(ship)
        end
      end
  end

  def valid_placement?(ship, coordinate_array)
    # require 'pry'; binding.pry

    if ship.length == 2 && verify_valid_coordinate?(ship, coordinate_array) && validate_coor_with_ship_length?(ship, coordinate_array) && validate_no_overlapping?(ship, coordinate_array) && validate_ships_consecutive_for_submarine?(ship, coordinate_array)
      return true
    elsif ship.length == 3 && verify_valid_coordinate?(ship, coordinate_array) && validate_coor_with_ship_length?(ship, coordinate_array) && validate_no_overlapping?(ship, coordinate_array) && validate_ships_consecutive_for_cruiser?(ship, coordinate_array)
      return true
    else
      return false

    end
  end

  def verify_valid_coordinate?(ship, coordinate_array)
      coordinate_array.all? do |coordinate|
        valid_coordinate?(coordinate)
    end
  end


  def validate_coor_with_ship_length?(ship, coordinate_array)

  if ship.length == coordinate_array.length
    return true
  end

  end #end length method

  def validate_ships_consecutive_for_submarine?(ship, coordinate_array)
    total_ord_value_element_1_character_1 = 0
    total_ord_value_element_1_character_2 = 0
    total_ord_value_element_2_character_1 = 0
    total_ord_value_element_2_character_2 = 0
    coordinate_array.each_cons(2) do |coordinate_pair|
      total_ord_value_element_1_character_1 += coordinate_pair.first[0].ord
      total_ord_value_element_1_character_2 += coordinate_pair.first[1].ord
      total_ord_value_element_2_character_1 += coordinate_pair.last[0].ord
      total_ord_value_element_2_character_2 += coordinate_pair.last[1].ord
      end
    if total_ord_value_element_1_character_1 == total_ord_value_element_2_character_1 && total_ord_value_element_1_character_2 == total_ord_value_element_2_character_2 +-1
      return true
    elsif total_ord_value_element_1_character_2 == total_ord_value_element_2_character_2 && total_ord_value_element_1_character_1 == total_ord_value_element_2_character_1 +-1
      return true
    else
      return false
    end
  end



  def validate_ships_consecutive_for_cruiser?(ship, coordinate_array)
    total_ord_value_element_1_character_1 = 0
    total_ord_value_element_1_character_2 = 0
    total_ord_value_element_2_character_1 = 0
    total_ord_value_element_2_character_2 = 0
    total_ord_value_element_3_character_1 = 0
    total_ord_value_element_3_character_2 = 0
    coordinate_array.each_cons(3) do |coordinate_pair|
      total_ord_value_element_1_character_1 += coordinate_pair.first[0].ord
      total_ord_value_element_1_character_2 += coordinate_pair.first[1].ord
      total_ord_value_element_2_character_1 += coordinate_pair[1][0].ord
      total_ord_value_element_2_character_2 += coordinate_pair[1][1].ord
      total_ord_value_element_3_character_1 += coordinate_pair.last[0].ord
      total_ord_value_element_3_character_2 += coordinate_pair.last[1].ord
      end
    if total_ord_value_element_1_character_1 == total_ord_value_element_2_character_1 && total_ord_value_element_1_character_1 == total_ord_value_element_3_character_1 && (total_ord_value_element_1_character_2 + 1) == total_ord_value_element_2_character_2 && (total_ord_value_element_3_character_2 - 1) == total_ord_value_element_2_character_2
      return true
    elsif total_ord_value_element_1_character_2 == total_ord_value_element_2_character_2 && total_ord_value_element_1_character_2 == total_ord_value_element_3_character_2 && (total_ord_value_element_1_character_1 +1) == total_ord_value_element_2_character_1 && total_ord_value_element_2_character_1 == (total_ord_value_element_3_character_1 - 1)
      return true
    else
      return false
    end
  end




  def validate_no_overlapping?(ship,coordinate_array)
    coordinate_array.all? do |coordinate|
      if @cells[coordinate].empty? == true
        return true
      else
        return false
      end #enum .each
    end
  end

  def render(ship_in_cell = false)
    return "  1 2 3 4 \nA #{@cells["A1"].render(ship_in_cell)} #{@cells["A2"].render(ship_in_cell)} #{@cells["A3"].render(ship_in_cell)} #{@cells["A4"].render(ship_in_cell)} \nB #{@cells["B1"].render(ship_in_cell)} #{@cells["B2"].render(ship_in_cell)} #{@cells["B3"].render(ship_in_cell)} #{@cells["B4"].render(ship_in_cell)} \nC #{@cells["C1"].render(ship_in_cell)} #{@cells["C2"].render(ship_in_cell)} #{@cells["C3"].render(ship_in_cell)} #{@cells["C4"].render(ship_in_cell)} \nD #{@cells["D1"].render(ship_in_cell)} #{@cells["D2"].render(ship_in_cell)} #{@cells["D3"].render(ship_in_cell)} #{@cells["D4"].render(ship_in_cell)} \n"
  end

  def fire_upon(coordinate)
    @cells[coordinate].fire_upon
  end


end #end class
