require 'pry'
INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                [[1, 5, 9], [3, 5, 7]]

def prompt(msg)
  puts "=> #{msg}"
end

def joinor(arr, delimiter = ', ', joining_word = 'or')
  joined = ''
  len = arr.length
  arr.each_with_index do |elem, ind|
    if ind == 0
      joined << "#{elem}"
    elsif len == 2
      joined << " #{joining_word} #{elem}"
    elsif ind != len - 1
      joined << "#{delimiter}#{elem}"
    else
      joined << "#{delimiter}#{joining_word} #{elem}"
    end
  end
  joined
end

# rubocop:disable Metrics/AbcSize
def display_board(brd)
  system "cls"
  puts "You're #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}"
  puts "Player: #{brd[:player_score]}   Computer: #{brd[:computer_score]}"
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----------------"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----------------"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end
# rubocop:enable Metrics/AbcSize

def initialize_board(computer_score, player_score)
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board[:computer_score] = computer_score
  new_board[:player_score] = player_score
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt("Choose a square (#{joinor(empty_squares(brd))}):")
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice."
  end
  brd[square] = PLAYER_MARKER
end

def winning_move(brd)
  smart_line = WINNING_LINES.find do |line|
    block = brd.values_at(*line)
    block.count(COMPUTER_MARKER) == 2 &&
    block.count(INITIAL_MARKER) == 1
  end
  return nil if !smart_line
  smart_line.find { |square| empty_squares(brd).include?(square) }
end

def block(brd)
  smart_line = WINNING_LINES.find do |line|
               block = brd.values_at(*line)
               block.count(PLAYER_MARKER) == 2 &&
               block.count(INITIAL_MARKER) == 1
  end
  return nil if !smart_line
  smart_line.find { |square| empty_squares(brd).include?(square) }
end


def computer_places_piece!(brd)
  square = winning_move(brd)
  square = block(brd) if !square
  square = empty_squares(brd).sample if !square
  brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def detect_series_winner(computer_score, player_score)
  return "Player" if player_score == 3
  return "Computer" if computer_score == 3
  false
end

loop do
  computer_score = 0
  player_score = 0
  loop do
    board = initialize_board(computer_score, player_score)
    winner = ''

    loop do
      display_board(board)

      player_places_piece!(board)
      break if someone_won?(board) || board_full?(board)

      computer_places_piece!(board)
      break if someone_won?(board) || board_full?(board)
    end

    display_board(board)

    if someone_won?(board)
      winner = detect_winner(board)
      prompt "#{winner} won!"
    else
      winner = ''
      prompt "It's a tie!"
    end

    if winner == "Player"
      player_score += 1
    elsif winner == "Computer"
      computer_score += 1
    end

    series_winner = detect_series_winner(computer_score, player_score)
    if series_winner
      board[:player_score] = player_score
      board[:computer_score] = computer_score
      display_board(board)
      prompt "Series winner is #{series_winner}!"
      break
    end
  end
  prompt "Play again? (y or n)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end
prompt "Thanks for playing Tic Tac Toe! Goodbye!"
