require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require 'pry'

class BoardTest < Minitest::Test

  def setup
    @board = Board.new
    @submarine = Ship.new("Submarine", 2)
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_if_board_exists
    assert_instance_of Board, @board
  end

  def test_if_board_has_cells
    assert_instance_of Hash, @board.cells
    assert_equal 16, @board.cells.length
  end
  #coordinate validation
  def test_it_can_validate_coordinates_on_board
    assert @board.valid_coordinate?("A1")
    assert @board.valid_coordinate?("D4")
    refute @board.valid_coordinate?("A5")
    refute @board.valid_coordinate?("E1")
    refute @board.valid_coordinate?("A22")
  end

  #ship placement validation
  def test_if_number_or_coordinates_in_array_is_same_as_ship_length
    #reverse testing for true and false
    #assert with correct number of coordinates per ship size
    assert @board.valid_placement?(@submarine, ["A1", "A2"])
    assert @board.valid_placement?(@cruiser, ["A1", "A3", "A4"])
    #refute with incorrect number of coordinates per ship size
    refute @board.valid_placement?(@cruiser, ["A1", "A2"])
    refute @board.valid_placement?(@submarine, ["A1", "A3", "A4"])
  end

  def test_if_coordinates_are_consecutive
    skip
    #if a cruiser should be  "A1" "A2" "A3" true
    refute @board.valid_placement?(@cruiser, ["A1","A2","A4"])
    # refute @board.valid_placement?(@submarine, ["A1","C1"])
    # refute @board.valid_placement?(@cruiser, ["A3","A2","A1"])
    # refute @board.valid_placement?(@submarine, ["C1", "B1"])
  end

  def test_if_ships_overlap
    skip
  end

  def test_we_can_place_ship
    skip
    @board.place(@cruiser, ["A1", "A2", "A3"])
    @cell_1 = @board.cells["A1"]
    @cell_2 = @board.cells["A2"]
    @cell_3 = @board.cells["A3"]

    assert_equal @cruiser, @cell_1.ship
    assert_equal @cruiser, @cell_2.ship
    assert_equal @cruiser, @cell_3.ship
  end
end #end class
