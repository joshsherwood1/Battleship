require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require 'pry'

class CellTest < Minitest::Test
  def setup
    @cell = Cell.new("B4")
    @cell_1 = Cell.new("B4")
    @cell_2 = Cell.new("B5")
    @cell_3 = Cell.new("B6")
    @ship_1 = Ship.new("Cruiser",3)
  end

  def test_that_cell_exists
    assert_instance_of Cell, @cell
  end

  def test_to_show_coordinate
    assert_equal "B4", @cell.coordinate
  end

  def test_to_show_ship_value_is_nil
    assert_nil @cell.ship
  end

  def test_to_show_cell_is_empty
    assert_equal true, @cell.empty?
  end

  def test_that_cruiser_exists
    assert_instance_of Ship, @ship_1
  end

  def test_cell_has_ship
    @cell.place_ship(@ship_1)

    assert_instance_of Ship, @cell.ship
  end

  def test_is_cell_is_not_empty_now
    @cell.place_ship(@ship_1)

    assert_equal false, @cell.empty?
    refute @cell.empty?
  end

  def test_cell_is_not_fired_upon_yet
    @cell.place_ship(@ship_1)

    assert_equal false, @cell.fired_upon?
    refute @cell.fired_upon?
  end

  def test_cell_has_been_fired_upon
    @cell.place_ship(@ship_1)
    @cell.fire_upon

    assert_equal 2, @cell.ship.health
    assert @cell.fired_upon?
  end

  def test_render_for_cell_that_has_not_been_fired_upon
    assert_equal ".", @cell_1.render
  end

  def test_that_cell_was_hit_but_had_no_ship_to_result_in_miss
    @cell_1.fire_upon

    assert_equal "M", @cell_1.render
  end

  def test_that_cell_2_has_ship_but_not_fired_on_yet
    @cell_1.fire_upon
    @cell_2.place_ship(@ship_1)

    assert_equal ".", @cell_2.render
  end

  def test_that_user_can_see_ship
    @cell_1.fire_upon
    @cell_2.place_ship(@ship_1)

    assert_equal "S", @cell_2.render(true)
  end

  def test_that_cell_has_ship_and_was_fired_upon
    @cell_1.fire_upon
    @cell_2.place_ship(@ship_1)
    @cell_2.fire_upon

    assert_equal "H", @cell_2.render
  end

  def test_that_cruiser_is_hit_but_not_sunk
    @cell_1.fire_upon
    @cell_2.place_ship(@ship_1)
    @cell_2.fire_upon

    assert_equal false, @ship_1.sunk?
  end

  def test_that_ship_has_sunk
    @cell_1.fire_upon
    @cell_2.place_ship(@ship_1)
    @cell_2.fire_upon
    @cell_2.fire_upon
    @cell_2.fire_upon

    assert_equal true, @ship_1.sunk?
  end

  def test_that_cell_has_a_ship_that_has_sunk
    @cell_1.fire_upon
    @cell_2.place_ship(@ship_1)
    @cell_2.fire_upon
    @cell_2.fire_upon
    @cell_2.fire_upon

    assert_equal "X", @cell_2.render
  end

  def test_result_of_turn_for_each_possibility
    @cell_1.fire_upon

    assert_equal "miss", @cell_1.result_of_turn

    @cell_2.place_ship(@ship_1)
    @cell_2.fire_upon
    @cell_2.fire_upon

    assert_equal "hit", @cell_2.result_of_turn
    
    @cell_2.fire_upon

    assert_equal "sunk ship", @cell_2.result_of_turn
  end
end
