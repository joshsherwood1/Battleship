require './lib/ai'
require './lib/board'
require './lib/cell'
require './lib/ship'

class Game
  def initialize
    @ai_board = Board.new #board for ai
    @user_board  = Board.new #board for human player
    @ai = Ai.new(@ai_board, @user_board)
    @user_cruiser = Ship.new("Cruiser", 3)  #user object starts with two ships
    @user_submarine = Ship.new("Submarine", 2)
    @user_ships = [@user_cruiser, @user_submarine]
    @user_guesses = []
    @winner = nil
  end

  def start_up #method to call main menu and game setup methods
    main_menu #welcome message to see if user wants to play or quit

  end

  def main_menu
    print "\n" * 3
    puts "***-***" * 10
    puts "÷÷÷÷÷÷W E L C O M E ÷÷÷÷÷÷ T O ÷÷÷÷÷ B A T T L E S H I P ÷÷÷÷÷÷"
    puts"***-***" * 10
    puts "\n" * 3
    puts "Enter play to play OR Enter quit to quit:"
    user_input_menu = gets.chomp.downcase
    print "\n" * 2

  case user_input_menu
    when "play"
      puts "Time to start the game."
      play_setup
    when "quit"
      print "Hope to see you play next time, quitting game..."
      puts "\n" * 3
    else
      p "You gave me an invalid input. Please enter play or quit."
    end
  end #end main_menu method

  def play_setup
    @ai.place_cruiser_ai(@ai_board)
    @ai.place_submarine_ai(@ai_board)
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    puts "Here is what the board looks like:"
    puts @user_board.render
    puts "\n" * 3

    #will iterate over ships for the user, 1 cruiser and 1 sub
    @user_ships.map do |ship|
      puts "Enter #{ship.length} coordinates for the #{ship.name}."
      user_input = gets.chomp.upcase.split(" ")
      puts "\n" * 2

      while @user_board.valid_placement?(ship, user_input) == false
        puts "You have given invalid coordinates. Please make sure that the coordinates are consecutive in ascending order \n and are not diagonal. Example: A1 A2 A3 or A1 B2. Please try again."
        user_input = gets.chomp.upcase.split(" ")
        puts "\n" * 2
      end
      @user_board.place(ship, user_input)
      # require 'pry'; binding.pry
    end

    # puts "Here is what your board looks like:"
    # puts @user_board.render(true)
    # puts "\n" * 5
    # require 'pry'; binding.pry
    turn
  end #end play_setup

  def turn
    puts "=============COMPUTER BOARD============="
    puts @ai_board.render
    puts "=============PLAYER BOARD============="
    puts @user_board.render(true)
    puts "\n" * 2
    puts "Please enter a computer board coordinate to fire on"
    user_coordinate = gets.chomp.upcase.split(" ").pop
    puts "\n" * 2
    # require 'pry'; binding.pry

    while @ai_board.valid_coordinate?(user_coordinate) == false
      puts "You have given an invalid coordinate. Please make sure that the coordinate is one of the 16 possible coordinates on the computer's board. Please try again."
      user_coordinate = gets.chomp.upcase.split(" ")
      puts "\n" * 2
    end

    while @user_guesses.include?(user_coordinate) == true
      puts "You have already entered this coordinate. Please try again."
      user_coordinate = gets.chomp.upcase.split(" ")
      puts "\n" * 2
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
    require 'pry'; binding.pry
    #-render ai_board
    #-asks user for coordinates for a shot, via prompt
    #uses the coordinates for fired_upon and fire methods
    #confirms hit or miss with boolean
    #or lets user know those coords have already been fired upon
    #based on that hit or miss
    #return its a hit or not
    #then ai takes its turn using ai class methods
    #end a turn or each shot by displayin that turns result
    #repeat proccess until there is a winner
    #should define a winner by certain circumstances, (when all opponent ships are sunk)
    #before repeating this we need to determine if there is a winner,
    #if there is a winner at some point break out of the method
  end #end turn  method

  def end_game
    #--TODO: needs to display winner
    #can show both ai board and user board comparisons
    #congratulate winner
    #prompt to exit to main menu

  end #end end_game method

end
