require './lib/ai'
require './lib/board'
require './lib/cell'
require './lib/ship'

class Game
  def initialize
    @ai_board = Board.new
    @user_board  = Board.new
    @ai = Ai.new(@ai_board, @user_board)
    @user_cruiser = Ship.new("Cruiser", 3)
    @user_submarine = Ship.new("Submarine", 2)
    @user_ships = [@user_cruiser, @user_submarine]
    @user_guesses = []
  end

  def start_up
    main_menu
  end

  def main_menu
    def quit
      print "Hope to see you play next time, quitting game..."
      puts "\n" * 3
      exit!
    end
    print "\n" * 3
    puts "***-***" * 10
    puts "÷÷÷÷÷÷W E L C O M E ÷÷÷÷÷÷ T O ÷÷÷÷÷ B A T T L E S H I P ÷÷÷÷÷÷"
    puts"***-***" * 10
    puts "\n" * 3
    puts "Enter play to play OR Enter quit to quit:"
    user_input_menu = gets.chomp.downcase
    print "\n" * 2

    if user_input_menu == "play"
      puts "Time to start the game."
      play_setup
    elsif user_input_menu == "quit"
      quit
    else
      p "You gave me an invalid input. Please enter play or quit. Restarting game..."
      main_menu
    end
  end

  def play_setup
    @ai.place_cruiser_ai(@ai_board)
    @ai.place_submarine_ai(@ai_board)
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    puts "Here is what the board looks like:"
    puts @user_board.render
    puts "\n" * 3

    @user_ships.map do |ship|
      puts "Enter #{ship.length} coordinates for the #{ship.name}."
      user_input = gets.chomp.upcase.split(" ")
      puts "\n" * 2

      while @user_board.valid_placement?(ship, user_input) == false
        puts "You have given invalid coordinates. Please make sure that the coordinates are consecutive in ascending order \n and are not diagonal. Example: A1 A2 A3 or A1 B1. Please try again."
        user_input = gets.chomp.upcase.split(" ")
        puts "\n" * 2
      end
      @user_board.place(ship, user_input)
    end

    puts "=============COMPUTER BOARD============="
    puts @ai_board.render
    puts "=============PLAYER BOARD============="
    puts @user_board.render(true)
    turn
  end

  def turn
    puts "\n" * 2
    puts "Please enter a computer board coordinate to fire on"
    ready_to_fire = false

    until ready_to_fire
      user_coordinate = gets.chomp.upcase.split(" ").pop
      if @ai_board.valid_coordinate?(user_coordinate) == false
        puts "You have given an invalid coordinate. Please make sure that the coordinate is one of the 16 possible coordinates on the computer's board. Please try again."
        puts "\n" * 2
      elsif @user_guesses.include?(user_coordinate) == true
        puts "You have already entered this coordinate. Please try again."
        puts "\n" * 2
      else ready_to_fire = true
      end
    end

    @ai_board.fire_upon(user_coordinate)
    @user_guesses << user_coordinate

    computer_target = @ai.target
    @ai.fire(@user_board, computer_target)
    puts "=============COMPUTER BOARD============="
    puts @ai_board.render
    puts "=============PLAYER BOARD============="
    puts @user_board.render(true)
    puts "\n"
    puts "Your shot on #{user_coordinate} was a #{@ai_board.cells[user_coordinate].result_of_turn}."
    puts "My shot on #{computer_target} was a #{@user_board.cells[computer_target].result_of_turn}."

    turn until @ai.ai_ship_cruiser.sunk? && @ai.ai_ship_submarine.sunk? || @user_cruiser.sunk? && @user_submarine.sunk?
    end_game
  end

  def end_game
    if @ai.ai_ship_cruiser.sunk? && @ai.ai_ship_submarine.sunk?
      puts "\n" * 3
      puts "******** You won! ********"
    else @user_cruiser.sunk? && @user_submarine.sunk?
      puts "\n" * 3
      puts "******** The computer won! ********"
    end

    @ai_board = Board.new
    @user_board  = Board.new
    @ai = Ai.new(@ai_board, @user_board)
    @user_cruiser = Ship.new("Cruiser", 3)
    @user_submarine = Ship.new("Submarine", 2)
    @user_ships = [@user_cruiser, @user_submarine]
    @user_guesses = []

    start_up
  end
end
