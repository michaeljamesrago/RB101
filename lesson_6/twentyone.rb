FACECARD_LABELS = { "a" => "Ace",
                    "b" => "Ten",
                    "c" => "Jack",
                    "d" => "Queen",
                    "e" => "King" }

SUITS = ["Hearts", "Diamonds", "Clubs", "Spades"]
GAME_VALUE = 21
DEALER_STAYS_AT = 17

def prompt(str)
  puts "=>#{str}"
end

# rubocop:disable Metrics/AbcSize, MethodLength, LineLength
def initialize_deck
  deck = []
  card_arr = Array.new(52) { |i| "#{format('%1x', ((i / 4) + 2))}#{SUITS[i % 4]}" }
  card_arr.each do |crd|
    card = {}
    val = crd.chr
    suit = crd.slice(1..-1)
    if val.to_i > 0
      card[:label] = "#{val} of #{suit}"
      card[:value] = val.to_i
    else
      card[:label] = "#{FACECARD_LABELS[val]} of #{suit}"
      card[:value] = val == 'a' ? 11 : 10
    end
    deck << card
  end
  deck.shuffle!
end
# rubocop:enable Metrics/AbcSize, MethodLength, LineLength

def deal(deck)
  deck.shift(2)
end

def get_score(hand)
  devalue_aces!(hand)
  hand.reduce(0) { |acc, elem| acc + elem[:value] }
end

def bust?(hand)
  hand.reduce(0) { |acc, elem| acc + elem[:value] } > GAME_VALUE
end

def devalue_aces!(hand)
  while bust?(hand)
    aces = hand.select { |crd| crd[:value] == 11 }
    !!aces[0] ? aces[0][:value] = 1 : break
  end
end

def hit(deck, data)
  new_card = deck.shift
  hand = data[:hand]
  hand << new_card
  data[:score] = get_score(hand)
end

def initialize_game
  deck = initialize_deck
  player_hand = deal(deck)
  dealer_hand = deal(deck)
  participants = { player: { hand:  player_hand,
                             score: get_score(player_hand) },
                   dealer: { hand:  dealer_hand,
                             score: get_score(dealer_hand) } }
  [deck, participants]
end

# rubocop:disable Metrics/AbcSize, MethodLength
def display_game(game, show_dealer_hand = false)
  system "cls"
  player_hand = game[:player][:hand]
  dealer_hand = game[:dealer][:hand]
  player_score = game[:player][:score]
  dealer_score = game[:dealer][:score]
  if show_dealer_hand
    puts "\nDealer hand:\n\n"
    dealer_hand.each { |card| puts card[:label] }
    puts "\nDealer has #{dealer_score}.\n"
    (7 - dealer_hand.size).times { puts "\n" }
  else
    puts "\nDealer showing #{dealer_hand[0][:label]}"
    (12 - dealer_hand.size).times { puts "\n" }
  end
  puts "Player hand:\n\n"
  player_hand.each { |card| puts card[:label] }
  (5 - player_hand.size).times { puts "\n" }
  puts "\nPlayer has #{player_score}."
end
# rubocop:enable Metrics/AbcSize, MethodLength

loop do
  deck, game = initialize_game
  player_data = game[:player]
  dealer_data = game[:dealer]
  player_hand = game[:player][:hand]
  dealer_hand = game[:dealer][:hand]

  display_game(game)

  loop do
    prompt("Hit? ('y')")
    answer = gets.chomp.downcase
    hit(deck, player_data) if answer == 'y'
    display_game(game)
    break if bust?(player_hand) || answer != 'y'
  end

  if bust?(player_hand)
    prompt("Player bust. Dealer wins.")
    prompt("Play again? ('y')")
    gets.chomp.downcase == 'y' ? next : break
  end

  loop do
    break if bust?(dealer_hand) || dealer_data[:score] >= DEALER_STAYS_AT
    hit(deck, dealer_data)
  end

  display_game(game, true)

  if bust?(dealer_hand)
    prompt("Dealer bust. Player wins.")
    prompt("Play again? ('y')")
    gets.chomp.downcase == 'y' ? next : break
  end

  case player_data[:score] <=> dealer_data[:score]
  when -1
    prompt("Dealer wins.")
  when 0
    prompt("It's a push.")
  when 1
    prompt("Player wins.")
  end
  prompt("Play again? ('y')")
  break if gets.chomp.downcase != 'y'
end

prompt("Thank you for playing.")
