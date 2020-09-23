def prompt(message)
  puts "=> #{message}"
end

def integer?(num)
  num.to_i.to_s == num
end

def float?(num)
  num.to_f.to_s == num
end

def valid_number?(num)
  (integer?(num) || float?(num)) && (num.to_f >= 0.0)
end

def format_money(num)
  format('%.2f', num)
end

def print_error
  prompt('That doesn\'t look quite right')
end

def calculate_monthly_payment(interest, duration, amount)
  if interest.to_f == 0.0
    amount.to_f / duration.to_i
  else
    amount.to_f * (interest.to_f / (1 - (1 + interest.to_f)**(-duration.to_i)))
  end
end

def display_welcome
  system("clear") || system("cls")
  prompt('Welcome to the loan calculator')
  prompt('This calculator can determine the monthly payment for a loan')
  prompt('based on the APR, length of the loan, and amount borrowed.')
end

def get_loan_amt
  loan = ''
  loop do
    prompt('Please enter the amount borrowed:')
    loan = gets.chomp
    if valid_number?(loan) && loan.to_f != 0.0
      break
    else
      print_error
    end
  end
  loan
end

def get_apr
  apr_rate = ''
  loop do
    prompt('Please enter the APR rate of your loan:')
    prompt('example: 5 for 5%, 0.5 for 0.5%')
    apr_rate = gets.chomp
    if valid_number?(apr_rate)
      break
    else
      print_error
    end
  end
  apr_rate
end

def print_dur_menu
  prompt('How would you like to enter loan duration?')
  prompt('1 => years')
  prompt('2 => months')
end

def get_duration
  duration = ''
  loop do
    print_dur_menu
    answer = gets.chomp
    if answer == '1'
      duration = calculate_loan_dur_years()
      break
    elsif answer == '2'
      duration = calculate_loan_dur_months()
      break
    else
      print_error
    end
  end
  duration
end

def calculate_loan_dur_months
  prompt('Please enter loan duration in months:')
  answer = ''
  loop do
    answer = gets.chomp
    if integer?(answer) && answer.to_i != 0
      break
    else
      print_error
    end
  end
  answer
end

def calculate_loan_dur_years
  prompt('Please enter loan duration in years:')
  answer = ''
  loop do
    answer = gets.chomp
    if integer?(answer) && answer.to_i != 0
      break
    else
      print_error
    end
  end
  answer.to_i * 12
end

def calculate_monthly_interest_rate(apr)
  (apr.to_f / 100) / 12
end

def calculate_total_payment(monthly_amt, num_months)
  monthly_amt.to_f * num_months.to_i
end

def calculate_total_interest(amt_borrowed, amt_paid)
  amt_paid.to_f - amt_borrowed.to_i
end

def print_results(payment, duration, total, interest)
  prompt('Calculating...')
  prompt("Your monthly payment is $#{format_money(payment)}")
  prompt("You have a total of #{duration} monthly payments")
  prompt("The total amount you will pay is $#{format_money(total)}")
  prompt("The total amount of interest is $#{format_money(interest)}")
end

def play_again?
  prompt('Would you like to perform another calculation? (y/n)')
  answer = gets.chomp
  answer.downcase == 'y' || answer.downcase == 'yes' ? true : false
end

loop do
  display_welcome
  loan_amt = get_loan_amt
  apr_rate = get_apr
  loan_duration = get_duration
  monthly_payment =
    calculate_monthly_payment(calculate_monthly_interest_rate(apr_rate),
                              loan_duration, loan_amt)
  total_payment = calculate_total_payment(monthly_payment, loan_duration)
  interest_payment = calculate_total_interest(loan_amt, total_payment)
  print_results(monthly_payment, loan_duration, total_payment, interest_payment)
  break unless play_again?
end
