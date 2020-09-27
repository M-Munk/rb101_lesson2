VALID_CHOICES = %w(rock paper scissors spock lizard)

WIN_CONDITIONS = {
  'rock' => ['scissors', 'lizard'],
  'paper' => ['rock', 'spock'],
  'scissors' => ['paper', 'lizard'],
  'spock' => ['scissors', 'rock'],
  'lizard' => ['spock', 'paper']
}

def prompt(message)
  Kernel.puts("==> #{message}")
end

def greeting
  prompt("Welcome to Rock, Paper, Scissors, Spock, Lizard")
  prompt("Good Luck!")
end

def win?(first, second, win_list)
  win_list[first].include?(second)
end

def get_player_choice
  player_choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}.")
    player_choice = Kernel.gets().chomp()
    if VALID_CHOICES.include?(player_choice)
      break
    else
      prompt("That's not a valid choice")
    end
  end
  player_choice
end

def display_choices(player, computer)
  Kernel.puts("You chose #{player}, computer chose #{computer}")
end

def display_results(player, computer)
  if win?(player, computer, WIN_CONDITIONS)
    prompt("You won!")
  elsif win?(computer, player, WIN_CONDITIONS)
    prompt("Computer won!")
  else
    prompt("You tied!")
  end
end

def play_again?
  prompt("Do you want to play again?")
  answer = Kernel.gets().chomp()
  answer.downcase.start_with?('y') ? true : false
end

# main program

loop do
  greeting
  choice = get_player_choice()
  computer_choice = VALID_CHOICES.sample()
  display_choices(choice, computer_choice)
  display_results(choice, computer_choice)
  break unless play_again?
end
prompt("Thank you for playing. Good bye!")
