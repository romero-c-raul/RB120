class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end

=begin
- What would happen if we added a play method to the Bingo class, keeping in 
  mind that there is already a method of this name in the Game class that the 
  Bingo class inherits from.
  
- Our lookup path would first look for the 'play' method within the Bingo class and
  find it, so it would use it immediately. 
=end