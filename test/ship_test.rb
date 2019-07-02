require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require "pry"

class ShipTest < Minitest::Test

  def setup
    @ship_1 = Ship.new("Cruiser",3)
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
    @ship_1.hit
    assert_equal 2, @ship_1.health
  end

  # def test_when_ship_is_hit_once
  #
  #   assert @ship_1
  #   assert_equal 2, @ship_1.hit
  # end

  # def test_when_ship_is_hit_twice
  #   assert_equal 2, @ship_1.health
  # end

end #end test class
