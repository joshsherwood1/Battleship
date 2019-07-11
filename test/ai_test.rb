require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/ai'

class AiTest < MiniTest::Test

  def setup
    @ai_board = Board.new
    @user_board = Board.new
    @ai = Ai.new(@ai_board, @user_board)
    @submarine = Ship.new("Submarine", 2)
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_ai_exists
    assert_instance_of Ai, @ai
  end

  def test_ai_has_a_board_rendered
    assert_equal "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n", @ai_board.render
  end

  def test_ai_has_1_ship
    skip
    @ai.place_cruiser_ai(@ai_board)

    assert_equal "  1 2 3 4 \nA S . S S \nB . . . . \nC . . . . \nD . . . . \n", @ai_board.render(true)
  end

  def test_ai_has_2_ships
    skip
    @ai.place_cruiser_ai(@ai_board)
    @ai.place_submarine_ai(@ai_board)

    assert_equal "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n", @ai_board.render(true)
  end

  def test_that_AI_has_fired
    @ai.fire(@user_board, "C2")

    assert_equal "  1 2 3 4 \nA . . . . \nB . . . . \nC . M . . \nD . . . . \n", @user_board.render
  end

  def test_that_target_method_works
    skip
    assert_equal "Random coordinate", @ai.target
  end

  def test_that_AI_has_fired_on_nine_spots
    skip
    9.times do
      @ai.fire(@user_board, @ai.target)
    end

    assert_equal "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n", @user_board.render
  end

  def test_it_can_fire_16_times
    16.times do
      @ai.fire(@user_board, @ai.target)
    end

    assert_empty @ai.possible_targets
    assert_equal "  1 2 3 4 \nA M M M M \nB M M M M \nC M M M M \nD M M M M \n", @user_board.render
  end
end
