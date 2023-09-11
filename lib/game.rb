class Game
<<<<<<< HEAD
 
end
=======
  attr_reader :player, :computer
  def initialize
    @player = Player.new
    @computer = Computer.new
  end 

  def start 
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit."
    player_input = gets&.chomp
    if player_input != "p" && player_input != "q"
      puts "Please enter a valid command."
      player_input = gets.chomp
    end
    
    if player_input == "p"
      setup_ships 
    elsif player_input == "q"
      puts "Goodbye."
    end
    player_input
  end

  def setup_ships
    @computer.place_cruiser
    @computer.place_submarine
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    puts @player.board.render
    @player.place_cruiser
    puts @player.board.render(true)
    @player.place_submarine
    puts @player.board.render(true)
  end
end 
>>>>>>> 3f4b2c049d22df677dd01b7ebb69c6429c36fcd1
