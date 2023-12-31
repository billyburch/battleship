class Game
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
      play_game 
    elsif player_input == "q"
      puts "Goodbye."
      exit
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

  def play_game
    computer_loss = @computer.cruiser.sunk? && @computer.submarine.sunk?
    player_loss = @player.cruiser.sunk? && @player.submarine.sunk?
    until computer_loss || player_loss
      puts "\n\nLET'S PLAY!\n\n"
      puts "=============COMPUTER BOARD============="
      puts @computer.board.render
      puts "==============PLAYER BOARD=============="
      puts @player.board.render(true)
      player_aim_fire
      computer_aim_fire
      computer_loss = @computer.cruiser.sunk? && @computer.submarine.sunk?
      player_loss = @player.cruiser.sunk? && @player.submarine.sunk?
    end
    if computer_loss
      print "You won! \n"
    elsif player_loss
      print "I won! \n"
    end
    start
  end
  
  def player_aim_fire
    puts "\nEnter the coordinate for your shot:"
    player_input = gets.chomp.upcase
    until @computer.board.valid_coordinate?(player_input) && !@computer.board.cells[player_input].fired_upon?
      if @computer.board.valid_coordinate?(player_input) && @computer.board.cells[player_input].fired_upon?
        puts "You have already fired at #{player_input}"
      end
      puts "Please enter a valid coordinate: "
      player_input = gets.chomp.upcase
    end
    @computer.board.cells[player_input].fire_upon
    if @computer.board.cells[player_input].ship == nil
      puts "Your shot on #{player_input} was a miss."
    elsif @computer.board.cells[player_input].ship != nil
      puts "Your shot on #{player_input} was a hit."
      if @computer.board.cells[player_input].ship.sunk?
        puts "You sunk my #{@computer.board.cells[player_input].ship.name}!"
      end
    end
  end

  def computer_aim_fire
    if @computer.cruiser.sunk? && @computer.submarine.sunk?
      print "You won! \n"
      start
    end
    cell = @player.board.cells.values.sample
    while cell.fired_upon? do
      cell = @player.board.cells.values.sample
    end
    cell.fire_upon
    if cell.ship == nil
      puts "My shot on #{cell.coordinate} was a miss."
    elsif cell.ship != nil
      puts "My shot on #{cell.coordinate} was a hit."
      if cell.ship.sunk?
        puts "I sunk your #{cell.ship.name}!"
      end
    end
  end
end

