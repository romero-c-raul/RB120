require 'pry'

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  attr_accessor :squares

  def initialize
    @squares = {}
    reset
  end

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won_round?
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

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
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
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength
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
  attr_accessor :score

  def initialize(marker)
    @marker = marker
    @score = 0
  end
end

=begin
- Write a program that determines whether the computer acts offensively or
  defensively
  - Offensively: If there are two computer markers in a winning line,
    apply marker to the empty line (' ') to win.
  - Defensively: If there are two human markers in a winning line, apply
    marker to empty line (' ') to prevent losing.

- Board#winning_marker already obtains a collection of all the markers
  within a winning line
  - We can modify method by looking at the markers in the winning line
    - We first look at the lines with computer markers
      - If the winning line array has two computer markers, add a computer
        marker to the empty index
    - If none of the lines have two computer markers, then look at the lines
      with human markers
      - If the winning line has two human markers, add a computer marker to
        the empty index

=end

class Computer < Player
  attr_reader :game_board

  def initialize(marker, game_board)
    super(marker)
    @game_board = game_board
  end
  
  def defensive_ai_select_square
    Board::WINNING_LINES.each do |line|
      current_markers = []

      line.each { |key| current_markers << (game_board.squares[key]).marker }
      next if current_markers.all? ' '

      if current_markers.count(TTTGame::HUMAN_MARKER) == 2
        empty_square_index = current_markers.index(' ')
        return line[empty_square_index] unless empty_square_index.nil?
      end
    end
    nil
  end

  def offensive_ai_select_square
    Board::WINNING_LINES.each do |line|
      current_markers = []

      line.each { |key| current_markers << (game_board.squares[key]).marker }
      next if current_markers.all? ' '

      if current_markers.count(marker) == 2
        empty_square_index = current_markers.index(' ')
        return line[empty_square_index] unless empty_square_index.nil?
      end
    end
    nil
  end
end

class TTTGame
  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'
  FIRST_TO_MOVE = HUMAN_MARKER
  WINNING_ROUNDS = 3

  attr_reader :board, :human, :computer, :turn

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Computer.new(COMPUTER_MARKER, @board)
    @turn = FIRST_TO_MOVE
  end

  def play
    clear
    display_welcome_message
    main_game
    display_grand_winner
    display_goodbye_message
  end

  private

  def main_game
    loop do
      display_board
      player_move
      display_result_and_update_score
      press_enter_to_continue
      break if someone_won_game?
      reset
      display_next_round_starting_message
    end
  end

  def display_grand_winner
    if human.score >= WINNING_ROUNDS
      puts "You are the grand winner!"
    else
      puts "Computer is the grand winner!"
    end
  end

  def display_next_round_starting_message
    puts "Next round starting..."
    puts ''
  end

  def press_enter_to_continue
    puts "Press enter to continue"
    gets.chomp
  end

  def someone_won_game?
    human.score >= WINNING_ROUNDS || computer.score >= WINNING_ROUNDS
  end

  def player_move
    loop do
      current_player_moves
      break if board.someone_won_round? || board.full?
      clear_screen_and_display_board
    end
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts "First player to win #{WINNING_ROUNDS} rounds wins the game!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe!"
  end

  def display_board
    puts "You're an #{human.marker}. Computer is an #{computer.marker}"
    puts "Player score: #{human.score}; Computer score: #{computer.score}"
    puts ""
    board.draw
    puts ""
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def human_moves
    puts "Choose a square between (#{joinor(board.unmarked_keys)}): "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end
    board[square] = human.marker
  end

  def joinor(array, punctuation=",", conjunction='and')
    squares_available = []

    if array.size >= 3
      first_to_second_last_numbers = array[0..-2].join("#{punctuation} ")
      last_number = array[-1]
      squares_available << [first_to_second_last_numbers] << last_number
      squares_available.join("#{punctuation} #{conjunction} ")
    elsif array.size == 2
      array.join(" #{conjunction} ")
    else
      array.join
    end
  end

  def computer_moves
    offensive_tactic = computer.offensive_ai_select_square
    defensive_tactic = computer.defensive_ai_select_square
    
    if offensive_tactic
      board[offensive_tactic] = computer.marker
    elsif defensive_tactic
      board[defensive_tactic] = computer.marker
    else
      board[board.unmarked_keys.sample] = computer.marker
    end
  end

  def display_result_and_update_score
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker
      human.score += 1
      puts "You won this round!!"
    when computer.marker
      computer.score += 1
      puts "Computer won this round!!"
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
    @turn = FIRST_TO_MOVE
    clear
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ''
  end

  def current_player_moves
    if turn == HUMAN_MARKER
      human_moves
      @turn = COMPUTER_MARKER
    elsif turn == COMPUTER_MARKER
      computer_moves
      @turn = HUMAN_MARKER
    end
  end
end

game = TTTGame.new
game.play
