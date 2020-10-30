class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game    # Add this to inherit play method from Bingo class
  def rules_of_play
    #rules of play
  end
end

# What can we add to the Bingo class to allow it to inherit the play 
# method from the Game class?

