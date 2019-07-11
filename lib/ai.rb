require 'pry'

class Ai
  attr_reader :ai_board, :possible_targets, :ai_ship_cruiser, :ai_ship_submarine

  def initialize(ai_board, user_board)
    @ai_board = Board.new
    @user_board = Board.new
    @possible_targets = @user_board.cells.keys.shuffle
    @ai_ship_cruiser = Ship.new("Cruiser", 3)
    @ai_ship_submarine = Ship.new("Submarine", 2)
  end

  def fire(board, target)
    board.cells[target].fire_upon
  end

  def target
    @possible_targets.pop
  end

  def place_cruiser_ai(board)
    1000000.times do
      coordinate_array_1 = []
      coordinate_array_1 << board.cells.keys.sample
      letter_value = coordinate_array_1.first[0].ord
      letter_value_2 = letter_value +1
      letter_value_3 = letter_value +2
      coordinate_array_1 << letter_value_2.chr + coordinate_array_1.first[1]
      coordinate_array_1 << letter_value_3.chr + coordinate_array_1.first[1]
      if board.valid_placement?(@ai_ship_cruiser, coordinate_array_1)
        return board.place(@ai_ship_cruiser, coordinate_array_1)
      end
      coordinate_array_1.pop(2)
      number_value = coordinate_array_1.first[1].to_i
      number_value_2 = number_value +1
      number_value_3 = number_value +2
      coordinate_array_1 << coordinate_array_1.first[0] + number_value_2.to_s
      coordinate_array_1 << coordinate_array_1.first[0] + number_value_3.to_s
      if board.valid_placement?(@ai_ship_cruiser, coordinate_array_1)
        @ai_board.place(@ai_ship_cruiser, coordinate_array_1)
      end
    end
  end

  def place_submarine_ai(board)
    100000.times do
      coordinate_array_2 = []
      coordinate_array_2 << board.cells.keys.sample
      number_value = coordinate_array_2.first[1].to_i
      number_value_2 = number_value +1
      coordinate_array_2 << coordinate_array_2.first[0] + number_value_2.to_s
      if board.valid_placement?(@ai_ship_submarine, coordinate_array_2) && board.cells[coordinate_array_2.first].empty? && board.cells[coordinate_array_2.last].empty?
        return board.place(@ai_ship_submarine, coordinate_array_2)
      end
      coordinate_array_2.pop(1)
      letter_value = coordinate_array_2.first[0].ord
      letter_value_2 = letter_value +1
      coordinate_array_2 << letter_value_2.chr + coordinate_array_2.first[1]
      if board.valid_placement?(@ai_ship_submarine, coordinate_array_2)
        @ai_board.place(@ai_ship_submarine, coordinate_array_2)
      end
    end
  end
end
