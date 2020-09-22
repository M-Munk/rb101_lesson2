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
  integer?(num) || float?(num)
end

def format_money(num)
  format('%.2f', num)
end

loop do
  system("clear") || system("cls")
  prompt('Welcome to the loan calculator')
  prompt('This calculator can determine the monthly payment for a loan
     based on the APR, length of the loan, and amount borrowed.')

  loan_amt = ''
  loop do
    prompt('Please enter the amount borrowed:')
    loan_amt = gets.chomp
    if valid_number?(loan_amt)
      break
    else
      prompt('That doesn\'t look quite right')
    end
  end

  apr_rate = ''
  loop do
    prompt('Please enter the APR rate of your loan:')
    apr_rate = gets.chomp
    if valid_number?(apr_rate)
      break
    else
      prompt('That doesn\'t look quite right')
    end
  end

  loan_duration_months = ''
  loan_duration_years = ''
  prompt('Would you like to enter loan duration in years?
     y = years, n = months')
  answer = gets.chomp
  if answer.downcase == 'y'
    loop do
      prompt('please enter loan duration in years:')
      loan_duration_years = gets.chomp
      if integer?(loan_duration_years)
        loan_duration_months = 12 * loan_duration_years.to_i
        break
      else
        prompt('That doesn\'t look quite right')
      end
    end
  else
    loop do
      prompt('please enter the loan duration in months:')
      loan_duration_months = gets.chomp
      if integer?(loan_duration_months)
        break
      else
        prompt('That doesn\'t look quite right')
      end
    end
  end

  prompt('Calculating...')

  monthly_interest_rate = (apr_rate.to_f / 100) / 12
  monthly_payment = loan_amt.to_f * (monthly_interest_rate.to_f /
    (1 - (1 + monthly_interest_rate.to_f)**(-loan_duration_months.to_i)))
  total_payment = monthly_payment.to_f * loan_duration_months.to_i
  interest_payment = total_payment - loan_amt.to_f

  prompt("Your monthly payment is $#{format_money(monthly_payment)}")
  prompt("You have a total of #{loan_duration_months} monthly payments")
  prompt("The total amount you will pay is $#{format_money(total_payment)}")
  prompt("The total amount of interest is $#{format_money(interest_payment)}")

  prompt('Would you like to perform another calculation?')
  answer = gets.chomp
  break unless answer.downcase.start_with? 'y'
end
