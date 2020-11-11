class Participant
  attr_accessor :name, :hand, :score, :wins

  def initialize(name)
    @name = name
    @hand = []
    @wins = 0
  end

  def current_hand
    hand.map(&:value)
  end

  def reset_hand
    self.hand = []
  end

  def hit; end

  def stay; end

  def busted?
    hand_value > 21
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
        current_score << if (current_score.sum + 11) > 21
                           1
                         else
                           11
                         end
      end
    end

    current_score
  end

  def card_values
    hand.map(&:value)
  end
end

class Player < Participant
end

class Dealer < Participant
  def initialize
    super('Dealer')
  end

  def first_hand
    "#{hand[0].value} and unknown hand"
  end

  def stays?
    hand_value >= 17
  end

  def hits
    "Dealer hits!" if hand_value < 17
  end
end

class Deck
  attr_accessor :cards

  def initialize
    @cards = [
      create_cards('H'),
      create_cards('D'),
      create_cards('C'),
      create_cards('S')
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
  WINNING_ROUNDS = 3

  attr_accessor :player, :dealer, :deck

  def initialize
    @player = Player.new('Player')
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def start
    game_intro
    # Main Game
    loop do
      shuffle_deck
      deal_first_cards
      show_rounds_won
      show_initial_cards
      player_turn
      dealer_turn unless player.busted?
      show_round_result_and_update_wins
      break if someone_won_game?
      next_round_starting
      reset
    end
    puts "Game is over!"
  end

  def show_rounds_won
    puts "**Rounds Won: Player: #{player.wins}; Dealer: #{dealer.wins}**"
    puts ""
  end

  def reset
    player.reset_hand
    dealer.reset_hand
    self.deck = Deck.new
  end

  def next_round_starting
    prompt "Next round is starting..."
    press_enter_to_continue
    clear
  end

  def someone_won_game?
    player.wins >= WINNING_ROUNDS || dealer.wins >= WINNING_ROUNDS
  end

  def game_intro
    clear
    display_welcome_message
    display_instructions
    press_enter_to_continue
    clear
  end

  def dealer_turn
    puts ""
    prompt "Dealer's turn..."
    loop do
      break if dealer.stays?
      prompt dealer.hits
      deck.deal_card(dealer.hand)
      break if dealer.busted?
      display_dealer_hand_and_score
      press_enter_to_continue
    end

    prompt "Dealer stays!" unless dealer.busted?
    display_dealer_hand_and_score
  end

  def clear
    system 'clear'
  end

  def display_welcome_message
    puts "***** Welcome to Twenty-One! *****"
    puts ""
  end

  def display_instructions
    prompt "Try to get as close to 21 as possible!"
    prompt "But if you go over 21, you lose the round immediately. Be careful!"
    prompt "First to win #{WINNING_ROUNDS} rounds wins the game."
    # puts "(top score limit can be changed in source code)"
    puts ""
  end

  def show_initial_cards
    prompt "Dealer has: #{dealer.first_hand}"
    display_player_hand_and_score
  end

  def display_player_hand_and_score
    prompt "You have: #{joinor(player.current_hand)} (total of #{player.hand_value})"
  end

  def display_dealer_hand_and_score
    prompt "Dealer has: #{joinor(dealer.current_hand)} (total of #{dealer.hand_value})"
  end

  def press_enter_to_continue
    prompt "Press enter to continue"
    gets.chomp
  end

  def prompt(msg)
    puts "=> #{msg}"
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

  def ask_player_hit_or_stay
    answer = nil
    loop do
      prompt "Hit or Stay?"
      answer = gets.chomp.downcase
      break if %w(hit stay s h).include? answer
      prompt "Invalid input. Please try again!"
    end
    answer
  end

  def player_turn
    puts ""
    loop do
      answer = ask_player_hit_or_stay
      break if answer.start_with?('s')

      deck.deal_card(player.hand)
      break if player.busted?
      display_player_hand_and_score
    end
  end

  def joinor(array, punctuation=",", conjunction='and')
    squares_available = []
    if array.size >= 3
      first_to_second_last_numbers = array[0..-2].join("#{punctuation} ")
      squares_available << [first_to_second_last_numbers] << array[-1]
      squares_available.join("#{punctuation} #{conjunction} ")
    elsif array.size == 2
      array.join(" #{conjunction} ")
    else
      array.join
    end
  end

  def show_round_result_and_update_wins
    display_participant_busted? if someone_busted?
    display_round_winner unless someone_busted?
    update_overall_wins
    puts ""
    display_final_round_score
  end

  def display_participant_busted?
    puts ""
    prompt "Busted! You lost this round!" if player.busted?
    prompt "Dealer busted! You win this round!" if dealer.busted?
  end

  def display_final_round_score
    puts " Round Score ".center(45, '*')
    puts "Player's hand: [#{joinor(player.current_hand)}]; Total score: #{player.hand_value}"
    puts "Dealers's hand: [#{joinor(dealer.current_hand)}]; Total score: #{dealer.hand_value}"
    puts ""
  end

  def display_round_winner
    if player.hand_value > dealer.hand_value
      prompt "You won this round!"
    elsif dealer.hand_value > player.hand_value
      prompt "Dealer won this round!"
    else
      prompt "It's a tie!"
    end
  end

  def update_overall_wins
    update_wins_by_busted
    update_wins_by_hand_value unless someone_busted?
  end

  def update_wins_by_busted
    if dealer.busted?
      player.wins += 1
    elsif player.busted?
      dealer.wins += 1
    end
  end

  def update_wins_by_hand_value
    if player.hand_value > dealer.hand_value
      player.wins += 1
    elsif dealer.hand_value > player.hand_value
      dealer.wins += 1
    end
  end

  def someone_busted?
    dealer.busted? || player.busted?
  end
end

Game.new.start
