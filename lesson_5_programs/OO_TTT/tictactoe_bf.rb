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

  def [](key)
    @squares[key].marker
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
  attr_accessor :score, :name

  def initialize(marker)
    @marker = marker
    @score = 0
    @name = "Player"
  end
end

class Computer < Player
  attr_reader :game_board
  attr_accessor :turn

  def initialize(marker, game_board)
    super(marker)
    @game_board = game_board
    @turn = 0
    @name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
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

  def turn_reset
    self.turn = 0
  end
end

class TTTGame
  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'
  FIRST_TO_MOVE = 'choose'
  WINNING_ROUNDS = 1

  attr_reader :board, :human, :computer, :turn

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Computer.new(COMPUTER_MARKER, @board)
    @turn = FIRST_TO_MOVE
  end

  def play
    setup
    main_game
    end_game
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
    end
  end

  def setup
    set_human_name
    clear
    display_welcome_message
    player_picks_marker?
    choose_who_goes_first? if FIRST_TO_MOVE == 'choose'
    clear
  end

  def end_game
    display_grand_winner_and_final_score
    display_goodbye_message
  end

  def player_picks_marker?
    answer = nil
    loop do
      puts "The default marker is X. Would you like to use the default marker?"
      answer = gets.chomp.downcase
      break if %w(y yes n no).include? answer
      puts "Invalid answer, please try again"
    end

    change_player_marker if answer.start_with?('n')
    puts ''
  end

  def change_player_marker
    answer = nil
    loop do
      puts "Please input desired marker (only 1 character long)"
      answer = gets.chomp
      break if answer.size == 1
      puts "Invalid input, please try again."
    end

    HUMAN_MARKER.replace(answer)
    puts ""
  end

  def choose_who_goes_first?
    answer = nil
    loop do
      puts "Would you like to go first? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n yes no).include? answer
      puts "That is not a valid option, please try again."
    end

    replace_first_to_move(answer)
    puts ""
  end

  def replace_first_to_move(answer)
    if answer == 'y' || answer == 'yes'
      FIRST_TO_MOVE.replace(HUMAN_MARKER)
    else
      FIRST_TO_MOVE.replace(COMPUTER_MARKER)
    end
  end

  def display_grand_winner_and_final_score
    puts "***Final Score***".center(34)
    display_current_score
    puts ''

    if human.score >= WINNING_ROUNDS
      puts "You are the grand winner, congrats #{human.name}!"
    else
      puts "#{computer.name} is the grand winner, better luck next time!"
    end
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
    puts "Hello #{human.name}, welcome to Tic Tac Toe!"
    puts "First player to win #{WINNING_ROUNDS} rounds wins the game!"
    puts "Your opponent today is #{computer.name}."
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe!"
  end

  def display_board
    puts "You're a(n) #{human.marker}. Computer is a(n) #{computer.marker}"
    display_current_score
    puts ""
    board.draw
    puts ""
  end

  def display_current_score
    puts "Player score: #{human.score}; Computer score: #{computer.score}"
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
      squares_available << [first_to_second_last_numbers] << array[-1]
      squares_available.join("#{punctuation} #{conjunction} ")
    elsif array.size == 2
      array.join(" #{conjunction} ")
    else
      array.join
    end
  end

  def computer_moves
    if computer.turn == 2 && board[5] == ' ' && FIRST_TO_MOVE == HUMAN_MARKER
      board[5] = computer.marker
      return
    end

    launch_computer_ai
    computer.turn += 1
  end

  def launch_computer_ai
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

  def computer_marks_middle_square?; end

  def display_result_and_update_score
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker
      puts "You won this round!!"
    when computer.marker
      puts "Computer won this round!!"
    else
      puts "It's a tie!"
    end

    update_score
  end

  def update_score
    case board.winning_marker
    when human.marker
      human.score += 1
    when computer.marker
      computer.score += 1
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
    computer.turn_reset
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

  def set_human_name
    system 'clear'
    n = nil
    loop do
      puts "What is your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value"
    end
    human.name = n
  end
end

game = TTTGame.new
game.play
