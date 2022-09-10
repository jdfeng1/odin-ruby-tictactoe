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
    puts " #{array[0]} | #{array[1]} | #{array[2]} "
    puts "---+---+---"
    puts " #{array[3]} | #{array[4]} | #{array[5]} "
    puts "---+---+---"
    puts " #{array[6]} | #{array[7]} | #{array[8]} "
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
    puts "#{@name}, X or O?"
    while @marker == ""
      if ["x","X","o","O"].include? gets.chomp
        @marker = marker
      else
        puts "Invalid - please choose X or O"
      end
    end
  end

  def scoreChange
    @score += 1
  end

  
end


class Game

end

newBoard = GameBoard.new
puts newBoard.displayBoard
newBoard.board = ["1","2","3","4","5","6","7","8","9"]
puts newBoard.winStatus("X")
newBoard.placeMarker(5, "X")
puts newBoard.displayBoard

