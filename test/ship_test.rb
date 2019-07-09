require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require "pry"

class ShipTest < Minitest::Test

  def setup
    @ship_1 = Ship.new("Cruiser",3)
    @sub = Ship.new("sub", 2 )
  end

  def test_if_ship_exists
    @ship_1
    assert_instance_of Ship, @ship_1
  end

  def test_if_ship_has_a_name
    assert_equal "Cruiser", @ship_1.name
  end

  def test_if_ship_has_a_length
    assert_equal 3, @ship_1.length
  end

  def test_if_ship_has_health
    assert_equal 3, @ship_1.health
  end

  def test_if_ship_is_sunk
    refute @ship_1.sunk? #is ship sunk?
  end

  def test_ships_hit_sequence
    @ship_1.hit
    assert_equal 2, @ship_1.health
    refute @ship_1.sunk?
    @ship_1.hit
    assert_equal 1, @ship_1.health
    refute @ship_1.sunk?
    @ship_1.hit
    assert_equal 0, @ship_1.health
    assert_equal true, @ship_1.sunk?
  end

end #end_test
