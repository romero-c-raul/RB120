class Player
  def initialize
    # What would the "data" or "states" of a Player object entail?
    # Maybe cards? a name?
  end
  
  def hit
    
  end
  
  def stay
    
  end
  
  def busted?
    
  end
  
  def total
    
  end
end

class Dealer
  def initialize
    # seems very similar to Player... do we even need this?
    # Probably not, maybe we can create a module or subclass that gives
    # dealing functionality
  end
  
  def deal
    # does the dealer or the deck deal
  end
  
  def hit
  end
  
  def stay
  end
  
  def busted?
  end
  
  def total
  end
end

class Participant
  # Might be for all redundant behaviours from Player and Dealer
end

class Deck
  def initalize
    # need data structure to keep track of cards
    # array or hash?
  end
  
  def deal
    # does the dealer or the deck deal?
  end
end

class Card
  def initialize
    # what are the "states" of a card?
  end
end

class Game
  def start
    # What's the sequence of steps to execute the game play?
    deal_cards
    show_initial_cards
    player_turn
    dealer_turn
    show_result
  end
end

Game.new.start