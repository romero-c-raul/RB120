class Move
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']

  def initialize(value)
    @value = value
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end
  
  def lizard?
    @value == 'lizard'
  end
  
  def spock?
    @value == 'spock'
  end

  def >(other_move)
    rock? && (other_move.scissors? || other_move.lizard?) ||
      paper? && (other_move.rock? || other_move.spock?) ||
      scissors? && (other_move.paper? || other_move.lizard?) ||
      lizard? && (other_move.paper? || other_move.spock?) ||
      spock? && (other_move.rock? || other_move.scissors?)
  end

  def <(other_move)
    rock? && (other_move.paper? || other_move.spock?) ||
      paper? && (other_move.scissors? || other_move.lizard?) ||
      scissors? && (other_move.rock? || other_move.spock?) ||
      lizard? && (other_move.rock? || other_move.scissors?) ||
      spock? && (other_move.paper? || other_move.lizard?)
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name, :wins

  def initialize
    set_name
    @wins = 0
  end
end

class Human < Player
  def set_name
    n = nil
    loop do
      puts "What is your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value"
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissors, lizard, or spock:"
      choice = gets.chomp
      break if Move::VALUES.include? choice.downcase
      puts "Sorry, invalid choice"
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

# Game Orchestration Engine
class RPSGame
  attr_accessor :human, :computer, :score

  WINNING_SCORE = 3

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Goodbye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_round_winner
    if human.move > computer.move
      puts "#{human.name} won this round!"
    elsif human.move < computer.move
      puts "#{computer.name} won this round!"
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil

    loop do
      puts "Would you like to play again (y/n)?"
      answer = gets.chomp
      break if ['y', 'n'].include?(answer.downcase)
      puts "Sorry, answer must be 'y' or 'n'"
    end

    answer == 'y'
  end

  def game_over?
    true if human.wins >= WINNING_SCORE || computer.wins >= WINNING_SCORE
  end

  def start_next_round
    puts "Press enter to start next round!"
    gets.chomp
    system 'clear'
  end

  def display_scoreboard
    puts "----------------"
    puts "#{human.name}'s score: #{human.wins}"
    puts "#{computer.name}'s score: #{computer.wins}"
    puts "----------------"
  end

  def update_scoreboard
    if human.move > computer.move
      human.wins += 1
    elsif human.move < computer.move
      computer.wins += 1
    else
      ''
    end
  end

  def display_game_winner
    if human.wins > computer.wins
      puts "#{human.name} is the grand winner!"
    else
      puts "#{computer.name} is the grand winner!"
    end
  end

  def play
    display_welcome_message

    loop do
      display_scoreboard
      human.choose; computer.choose
      display_moves
      display_round_winner; update_scoreboard
      break if game_over?
      start_next_round
    end

    display_scoreboard
    display_game_winner
    display_goodbye_message
  end
end

RPSGame.new.play

=begin
- Keeping score:
  - Create a new instance variable that keeps track of current player wins
    - Initialize instance variable for both human and computer
    - Break out of the loop when either of those variables is
      greater or equal to 10

- Add lizard and spock:
  - add lizard and spock to values, write a getter method for both of them
  - Implement comparison within '>' and '<'

=end
