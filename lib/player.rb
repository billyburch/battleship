class Player
  attr_reader :board, :cruiser, :submarine
  def initialize
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def valid_cruiser_placement
    puts "Enter the squares for the Cruiser (3 spaces):"
    player_input = gets.chomp.upcase.split(" ").to_a 
    until board.valid_placement?(@cruiser, player_input)
      puts "Those are invalid coordinates. Please try again:" unless board.valid_placement?(@cruiser, player_input)
      puts "Enter the squares for the Cruiser (3 spaces):"
      player_input = gets.chomp.upcase.split(" ").to_a
    end
    print "You have placed your Cruiser on #{player_input}.\n"
    player_input
  end

  def valid_submarine_placement
    puts "Enter the squares for the Submarine (2 spaces):"
    player_input = gets.chomp.upcase.split(" ").to_a 
    until board.valid_placement?(@submarine, player_input)
      puts "Those are invalid coordinates. Please try again:" unless board.valid_placement?(@submarine, player_input)
      puts "Enter the squares for the Submarine (2 spaces):"
      player_input = gets.chomp.upcase.split(" ").to_a
    end
    print "You have placed your Submarine on #{player_input}.\n"
    player_input
  end

  def place_cruiser 
    coords = valid_cruiser_placement
    coords.each do |coord|
      board.cells[coord].place_ship(@cruiser)
    end
  end

  def place_submarine 
    coords = valid_submarine_placement
    coords.each do |coord|
      board.cells[coord].place_ship(@submarine)
    end
  end

  def ready_aim_fire
    puts "\nEnter the coordinate for your shot:"
    player_input = gets.chomp.upcase
    until @board.valid_coordinate?(player_input) && @board.cells[player_input].fired_upon? == false
      if @board.valid_coordinate?(player_input) && @board.cells[player_input].fired_upon?
        puts "You have already fired at #{player_input}"
      end
      puts "Please enter a valid coordinate: "
      player_input = gets.chomp.upcase
    end
    @board.cells[player_input].fire_upon
    if @board.cells[player_input].ship == nil
      puts "Your shot on #{player_input} was a miss."
    elsif @board.cells[player_input].ship != nil
      puts "Your shot on #{player_input} was a hit."
      if @board.cells[player_input].ship.sunk?
        puts "You sunk my #{@board.cells[player_input].ship.name}!"
      end
    end
  end


end