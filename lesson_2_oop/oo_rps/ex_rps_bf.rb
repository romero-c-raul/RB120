class Move
  attr_reader :value

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

  def to_s
    @value
  end
end

class Rock < Move
  def initialize
    @value = 'rock'
  end

  def >(other_move)
    value && (other_move.scissors? || other_move.lizard?)
  end

  def <(other_move)
    value && (other_move.paper? || other_move.spock?)
  end
end

class Paper < Move
  def initialize
    @value = 'paper'
  end

  def >(other_move)
    value && (other_move.rock? || other_move.spock?)
  end

  def <(other_move)
    value && (other_move.scissors? || other_move.lizard?)
  end
end

class Scissors < Move
  def initialize
    @value = 'scissors'
  end

  def >(other_move)
    value && (other_move.paper? || other_move.lizard?)
  end

  def <(other_move)
    value && (other_move.rock? || other_move.spock?)
  end
end

class Lizard < Move
  def initialize
    @value = 'lizard'
  end

  def >(other_move)
    value && (other_move.paper? || other_move.spock?)
  end

  def <(other_move)
    value && (other_move.rock? || other_move.scissors?)
  end
end

class Spock < Move
  def initialize
    @value = 'spock'
  end

  def >(other_move)
    value && (other_move.rock? || other_move.scissors?)
  end

  def <(other_move)
    value && (other_move.paper? || other_move.lizard?)
  end
end

class Player
  attr_accessor :move, :name, :wins, :move_history

  def initialize
    set_name
    @move_history = []
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
      break if Move::VALUES.include? choice
      puts "Sorry, invalid choice"
    end
    self.move = Kernel.const_get(choice.capitalize).new
    move_history << move
  end
  puts ""
end

class Computer < Player
  ROBOTS = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number5']
end

class R2D2 < Computer
  def set_name
    self.name = 'R2D2'
  end

  def choose
    self.move = Rock.new
    move_history << move
  end
end

class Hal < Computer
  def set_name
    self.name = 'Hal'
  end

  def choose
    self.move = [Scissors.new, Scissors.new, Scissors.new, Rock.new].sample
    move_history << move
  end
end

class Chappie < Computer
  def set_name
    self.name = 'Chappie'
  end

  def choose
    self.move = Paper.new
    move_history << move
  end
end

class Sonny < Computer
  def set_name
    self.name = 'Sonny'
  end

  def choose
    self.move = [Lizard.new, Spock.new].sample
    move_history << move
  end
end

class Number5 < Computer
  @@round = 0

  def set_name
    self.name = 'Number 5'
  end

  def choose
    self.move = [Rock.new, Paper.new, Scissors.new,
                 Lizard.new, Spock.new][@@round]
    move_history << move
    @@round >= 4 ? @@round = 0 : @@round += 1
  end
end

# Game Orchestration Engine
class RPSGame
  attr_accessor :human, :computer, :score

  WINNING_SCORE = 3

  def initialize
    @human = Human.new
  end

  def display_welcome_message
    puts ""
    puts "#{human.name}! Welcome to Rock, Paper, Scissors, Lizard, Spock!"
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

    update_scoreboard
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

  def start_next_round
    puts "Press enter to start next round!"
    gets.chomp
    system 'clear'
    nil
  end

  def game_over?
    return true if human.wins >= WINNING_SCORE || computer.wins >= WINNING_SCORE
    start_next_round
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
    display_scoreboard

    if human.wins > computer.wins
      puts "#{human.name} is the grand winner!"
    else
      puts "#{computer.name} is the grand winner!"
    end
  end

  def players_choose
    human.choose
    computer.choose
  end

  def print_history
    puts ""
    puts "The following is #{human.name}'s move history:"
    puts human.move_history
    puts "-------------------"
    puts "The following is #{computer.name}'s move history:"
    puts computer.move_history
  end

  def set_initial_score_and_opponent
    system 'clear'
    self.computer = Kernel.const_get(Computer::ROBOTS.sample).new
    human.wins = 0
    computer.wins = 0
  end

  def play
    loop do
      set_initial_score_and_opponent
      display_welcome_message

      loop do
        display_scoreboard
        players_choose
        display_moves
        display_round_winner
        break if game_over?
      end

      display_game_winner
      print_history
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play

=begin

***Notes***
- Keeping score:
  - Create a new instance variable that keeps track of current player wins
    - Initialize instance variable for both human and computer
    - Break out of the loop when either of those variables is
      greater or equal to 10 (or chosen number)

- Add lizard and spock:
  - add lizard and spock to values, write a getter method for both of them
  - Implement comparison within '>' and '<'

- Add class for each move
  - Pros: It makes it easier to read which moves win/lose agains other moves
  - Cons: It is easier to make mistakes with the logic, and methods '<'/'>'
  are being repeated constantly

- Keep track of history moves
  - Have move history be stored in an instance variable within computer and
    human object

- Computer personalities
  - Make every robot into its own class that draws from Computer superclass
  - Within every robot class:
    - R2D2's move will always be rock
    - Hal will choose from an array where 4/5 options are scissors and
      the rest rock
    - Chappie selects only paper
    - Sonny chooses only lizard or spock
    - Number 5 chooses rock, paper, lizard, spock always in that order
=end
