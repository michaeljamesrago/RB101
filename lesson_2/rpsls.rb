VALID_CHOICES = %w(rock paper scissors lizard Spock)

def win?(first, second)
  (first == 'rock' && ['scissors', 'lizard'].include?(second)) ||
    (first == 'paper' && ['rock', 'Spock'].include?(second)) ||
    (first == 'scissors' && ['paper', 'lizard'].include?(second)) ||
    (first == 'lizard' && ['Spock', 'paper'].include?(second)) ||
    (first == 'Spock' && ['scissors', 'rock'].include?(second))
end

def display_result(player, computer)
  if win?(player, computer)
    prompt("You Won!")
  elsif win?(computer, player)
    prompt("Computer Won!")
  else
    prompt("It's a tie!")
  end
end

def prompt(message)
  Kernel.puts("=>#{message}")
end

initials = VALID_CHOICES.map { |item| item[0] }
prompt_string = ''
VALID_CHOICES.each_with_index do |item, i|
  prompt_string << "#{item} (#{initials[i]}) \n"
end

loop do
  computer_score = 0
  player_score = 0

  while computer_score < 5 && player_score < 5
    choice = ''
    loop do
      prompt("Choose one:\n#{prompt_string}")
      choice = Kernel.gets().chomp()
      if initials.include?(choice)
        choice = VALID_CHOICES[initials.index(choice)]
        break
      elsif VALID_CHOICES.include?(choice)
        break
      else
        prompt('That is not a valid choice')
      end
    end

    computer_choice = VALID_CHOICES.sample()

    prompt("You chose #{choice}. Computer chose #{computer_choice}.")
    display_result(choice, computer_choice)

    if win?(choice, computer_choice)
      player_score += 1
    elsif win?(computer_choice, choice)
      computer_score += 1
    end
  end

  if computer_score == 5
    prompt("Computer has reached five first! Computer wins!")
  elsif player_score == 5
    prompt("You have reached five first! You win!")
  end

  prompt("Do you want to play again?")
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt("Thank you for playing. Goodbye!")
