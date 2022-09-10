class GameBoard
  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]

  attr_accessor :content

  def initialize
    @content = ["1","2","3","4","5","6","7","8","9"]
  end

  def displayBoard(array = @content)
    puts ""
    puts " #{array[0]} | #{array[1]} | #{array[2]} "
    puts "---+---+---"
    puts " #{array[3]} | #{array[4]} | #{array[5]} "
    puts "---+---+---"
    puts " #{array[6]} | #{array[7]} | #{array[8]} "
    puts ""
  end

  def winStatus(marker)
    arr = @content.each_index.select {|i| content[i] == marker}
    WIN_COMBINATIONS.any? {|combination| (arr & combination) == combination}
  end

  def placeMarker(position, marker)
    @content[position.to_i - 1] = marker
  end

end

class Player
  attr_accessor :name
  attr_accessor :marker

  def initialize(name)
    @name = name
    @marker = ""
  end

  def selectMarker(marker)
    @marker = marker
  end

  def won?(board)
    board.winStatus(@marker)
  end
end


class Game

  attr_accessor :p1
  attr_accessor :p2

  def initialize
    @board = GameBoard.new
    @continue = true
    @playersSet = false
  end

  def startGame
    puts "Let's play tic tac toe!"
    if @playersSet == false
      puts "Player 1, what is your name?"
      @name = gets.chomp
      puts "Player 2, what is your name?"
      @name2 = loop do
        currentChoice = gets.chomp
        break currentChoice if currentChoice != @name
        puts "Please choose a different name from #{@name}"
      end
      createPlayers(@name, @name2)
    end
    while @continue
      turn(@p1)
      if !@continue 
        break
      else
        turn(@p2)
      end
    end
    playAgain
  end

  def createPlayers(name1, name2)
    @p1 = Player.new(name1)
    @p2 = Player.new(name2)
    puts "Player 1 is #{@p1.name} - choose X or O?"
    choice = loop do
      currentChoice = gets.chomp.upcase
      break currentChoice if['X','O'].include? currentChoice
      puts "Please choose X or O"
    end
    @p1.selectMarker(choice)
    puts "\n#{@p1.name} selects #{@p1.marker}"
    if (@p1.marker == "X")
      @p2.selectMarker("O")
    else
      @p2.selectMarker("X")
    end
    puts "\n#{@p2.name} will be #{@p2.marker}"
  end

  def turn(player)
    @board.displayBoard
    puts "#{player.name}, choose which position you would like to play"
    choice = loop do
      move = gets.chomp
      break move if (move.to_i.to_s == move && @board.content.include?(move))
      puts "Please choose a valid position"
    end
    @board.placeMarker(choice, player.marker)
    gameOver?(player)
  end

  def gameOver?(player)
    if (player.won?(@board))
      @continue = false
      @board.displayBoard
      puts "\n#{player.name} won!"
    elsif (@board.content - ["X","O"]).empty?
      @continue = false
      @board.displayBoard
      puts "\nNo winners this time :("
    else
      @continue
    end
  end

  def playAgain
    puts "Play again? [Y/N]"
    choice = loop do
      currentChoice = gets.chomp.upcase
      break currentChoice if['Y','N'].include? currentChoice
      puts "Please choose [Y]es or [N]o"
    end
    if choice == "Y"
      @continue = true
      @board.content = ["1","2","3","4","5","6","7","8","9"]
      puts "Change players? [Y/N]"
      choice = loop do
        currentChoice = gets.chomp.upcase
        break currentChoice if['Y','N'].include? currentChoice
        puts "Please choose [Y]es or [N]o"
      end
      if choice == "N"
        @playersSet = true
      else
        @playersSet = false
      end
      startGame
    else
      @continue = false
    end
  end

end


newGame = Game.new
newGame.startGame