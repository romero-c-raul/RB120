class Participant
  attr_accessor :name, :hand, :score
  
  def initialize(name)
    @name = name
    @hand = []
  end
  
  def first_hand
   "#{hand[0].value} and #{hand[1].value}"
  end
  
  def hit
    
  end
  
  def stay
    
  end
  
  def busted?
    
  end
  
  def hand_value
    numerical_card_values.sum
  end
  
  def numerical_card_values
    current_score = []
    
    card_values.each do |current_value|
      if (2..10).include?(current_value)
        current_score << current_value
      elsif ['J', 'Q', 'K'].include?(current_value)
        current_score << 10
      elsif ['A'].include?(current_value)
        if (current_score.sum + 11) > 21
          current_score << 1
        else
          current_score << 11
        end
      end
    end
    
    current_score
  end
  
  def card_values
    hand.map { |current_card| current_card.value }
  end
  
end

class Player < Participant

end

class Dealer < Participant
  def initialize
    super('Dealer')
  end
  
  

end

class Deck
  attr_accessor :cards
  
  def initialize
    @cards = [
             create_cards('H'), 
             create_cards('D'), 
             create_cards('C'),  
             create_cards('S'),
            ].flatten
  end
  
  def create_cards(suit)
    stack = []
    
    (2..10).each { |value| stack << Card.new(suit, value) }
    ['J', 'Q', 'K'].each { |value| stack << Card.new(suit, value) }
    stack << Card.new(suit, 'A')
    
    stack
  end
  
  def deal_card(participant_hand)
    participant_hand << cards.pop
  end
  
  def shuffle
    cards.shuffle!
  end
  
  def to_s
    deck.values
  end
  
end

class Card
  attr_accessor :suit, :value
  
  def initialize(suit, value)
    @suit = suit
    @value = value
  end
  
  def to_s
    "[#{suit}, #{value}]"
  end
end

class Game
  attr_accessor :player, :dealer, :deck
  
  def initialize
    @player = Player.new('Player')
    @dealer = Dealer.new
    @deck = Deck.new
  end
  
  def start
    #display_welcome_message
    shuffle_deck
    deal_first_cards
    show_initial_cards
    return
    player_turn
    dealer_turn
    show_result
  end
  
  def show_initial_cards
    puts "=> Dealer has: #{dealer.first_hand} (total of #{dealer.hand_value})"
    puts "=> You have: #{player.first_hand} (total of #{player.hand_value})"
  end
  
  def deal_first_cards
    2.times do
      deck.deal_card(player.hand)
      deck.deal_card(dealer.hand)
    end
  end
  
  def shuffle_deck
    deck.shuffle
  end
end

Game.new.start
#puts Deck.new.cards
#puts new_game.deck.cards.size
# new_game = Game.new.start
# new_game.deal_first_cards
# new_game.show_initial_cards
