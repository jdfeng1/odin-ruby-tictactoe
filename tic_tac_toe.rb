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

  attr_accessor :board

  def initialize
    @board = ["1","2","3","4","5","6","7","8","9"]
  end

  def displayBoard(array = @board)
    puts ""
    puts " #{array[0]} | #{array[1]} | #{array[2]} "
    puts "---+---+---"
    puts " #{array[3]} | #{array[4]} | #{array[5]} "
    puts "---+---+---"
    puts " #{array[6]} | #{array[7]} | #{array[8]} "
    puts ""
  end

  def winStatus(marker)
    arr = @board.each_index.select {|i| board[i] == marker}
    WIN_COMBINATIONS.any? {|combination| (arr & combination) == combination}
  end

  def placeMarker(position, marker)
    @board[position - 1] = marker
  end

end

class Player
  attr_accessor :name
  attr_accessor :marker
  attr_accessor :score

  def initialize(name)
    @name = name
    @marker = ""
    @score = 0
  end

  def selectMarker(marker)
    @marker = marker
  end

  def scoreChange
    @score += 1
  end

end


class Game

  attr_accessor :p1
  attr_accessor :p2

  def initialize
    @board = GameBoard.new
  end

  def startGame
    puts "Let's play tic tac toe!"
    puts "Player 1, what is your name?"
    @name = gets.chomp
    puts "Player 2, what is your name?"
    @name2 = loop do
      currentChoice = gets.chomp
      break currentChoice if currentChoice != @name
      puts "Please choose a different name from #{@name}"
    end
    createPlayers(@name, @name2)
    gameLoop
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

  def gameLoop
    @board.displayBoard
    while 
  end

end


newGame = Game.new
newGame.startGame