require 'pry'

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                  [[1, 5, 9], [3, 5, 7]]              # diagonals
  def initialize
    @squares = {}
    reset
  end
  
  def []=(key, marker)
    @squares[key].marker = marker
  end
  
  def unmarked_keys
    @squares.keys.select{ |key| @squares[key].unmarked?}
  end
  
  def full?
    unmarked_keys.empty?
  end
  
  def someone_won?
    !!winning_marker
  end
  
  def winning_marker
    WINNING_LINES.each do |line|
      current_markers = []
      
      line.each { |key| current_markers << @squares[key].marker }

      next if current_markers.all? ' '
      return current_markers[0] if current_markers.uniq.size == 1
    end
    nil
  end
  
  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end
  
  def draw
    puts ""
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}  "
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}  "
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}  "
    puts "     |     |"
  end
end

class Square
  INITIAL_MARKER = ' '
  
  attr_accessor :marker
  
  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end
  
  def to_s
    @marker
  end
  
  def unmarked?
    marker == INITIAL_MARKER
  end
end

class Player
  attr_reader :marker
  
  def initialize(marker)
    @marker = marker
  end
end

class TTTGame
  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'
  
  attr_reader :board, :human, :computer
  
  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
  end
  
  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end
  
  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe!"
  end
  
  def display_board
    puts "You're an #{human.marker}. Computer is an #{computer.marker}"
    puts ""
    board.draw
    puts ""
  end
  
  def clear_screen_and_display_board
    clear
    display_board
  end
  
  
  def human_moves
    puts "Choose a square between (#{board.unmarked_keys.join(', ')}): "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end
    board[square] = human.marker
  end
  
  def computer_moves
    board[board.unmarked_keys.sample] = computer.marker
  end
  
  def display_result
    clear_screen_and_display_board
    
    case board.winning_marker
    when human.marker
      puts "You won!"
    when computer.marker
      puts "Computer won!"
    else
      puts "It's a tie!"
    end
  end
  
  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be y or n"
    end
    
    answer == 'y'
  end
  
  def clear
    system 'clear'
  end
  
  def reset
    board.reset
    clear
  end
  
  def display_play_again_message
    puts "Let's play again!"
    puts ''
  end
  
  def play
    clear
    display_welcome_message
    
    loop do
      display_board
      
      loop do
        human_moves
        break if board.full? || board.someone_won?
  
        computer_moves
        break if board.full? || board.someone_won?
  
        clear_screen_and_display_board
      end
      display_result
      break unless play_again?
      reset
      display_play_again_message
    end
    
    display_goodbye_message
  end
end

game = TTTGame.new
game.play