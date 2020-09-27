VALID_CHOICES = %w(rock paper scissors spock lizard)
SHORT_CHOICES = %w(r p s k l)
WIN_CONDITIONS = {
  'rock' => ['scissors', 'lizard'],
  'paper' => ['rock', 'spock'],
  'scissors' => ['paper', 'lizard'],
  'spock' => ['scissors', 'rock'],
  'lizard' => ['spock', 'paper']
}

scoreboard = {
  player: 0,
  computer: 0,
  ties: 0
}

rounds_played = 5

def prompt(message)
  Kernel.puts("==> #{message}")
end

def clr_scn
  system("clear") || system("cls")
end

def display_greeting(rounds)
  clr_scn
  prompt("Welcome to Rock, Paper, Scissors, Spock, Lizard")
  prompt("Unless you quit early, first player to #{rounds} wins!")
  prompt("Good Luck!")
end

def win?(first, second, win_list)
  win_list[first].include?(second)
end

def convert_player_choice(answer)
  idx = SHORT_CHOICES.index(answer)
  VALID_CHOICES[idx]
end

def get_player_choice
  player_choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}.")
    prompt("Or use short form: #{SHORT_CHOICES.join(', ')}")
    player_choice = Kernel.gets.chomp.downcase
    if VALID_CHOICES.include?(player_choice)
      break
    elsif SHORT_CHOICES.include?(player_choice)
      player_choice = convert_player_choice(player_choice)
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
  prompt("Do you want to play again? (y/n)")
  answer = ''
  loop do
    answer = gets.chomp.downcase
    break if %w(n no y yes).include?(answer)
    prompt("Invalid input! Please type 'y/yes' or 'n/no'.")
  end
  %w(y yes).include?(answer)
end

def update_score(score, human, computer, win_list)
  if win?(human, computer, win_list)
    score[:player] += 1
  elsif win?(computer, human, win_list)
    score[:computer] += 1
  else
    score[:ties] += 1
  end
end

def game_over?(score, rounds)
  score[:player] == rounds || score[:computer] == rounds
end

def print_score(score)
  prompt("Player - #{score[:player]}")
  prompt("Computer - #{score[:computer]}")
  prompt("# of Ties - #{score[:ties]}")
end

def determine_winner(score)
  prompt("The final score is:")
  print_score(score)
  if score[:player] > score[:computer]
    prompt("You win this round!")
  elsif score[:player] == score[:computer]
    prompt("You are tied with the computer.")
  else
    prompt("Sorry, the computer wins this round.")
  end
end

def display_current_score(score)
  prompt("The current score is:")
  print_score(score)
end

# main program

display_greeting(rounds_played)
loop do
  choice = get_player_choice
  computer_choice = VALID_CHOICES.sample
  display_choices(choice, computer_choice)
  display_results(choice, computer_choice)
  update_score(scoreboard, choice, computer_choice, WIN_CONDITIONS)
  break if game_over?(scoreboard, rounds_played)
  break unless play_again?
  clr_scn
  display_current_score(scoreboard)
end
determine_winner(scoreboard)
