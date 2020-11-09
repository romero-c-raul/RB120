class Board
  def initialize
    # we need some way to model the 3x3 grid. Maybe squares?
    # what data structure should we use?
    # - array/hash of square objects?
    # - array/hash of strings or integers
  end
end

class Square
  def initialize
    # maybe a "status" to keep track of this square's mark?
  end
end

class Player
  def initialize
    # maybe marker to keep track of this player's symbol (x or o)
  end
  
  def mark
    
  end
  
  def play
    
  end
end

class TTTGame
  def play
    display_welcome_message
    loop do
      display_board
      first_player_moves
      break if someone_won? || board_full?
      
      second_player_moves
      break if someone_won? || board_full?
    end
    display_result
    display_goodbye_message
  end
end

game = TTTGame.new
game.play