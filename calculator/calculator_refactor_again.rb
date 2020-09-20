require 'yaml'
MESSAGES = YAML.load_file('messages.yml')

def prompt(message)
  Kernel.puts "=> #{message}"
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

def operation_to_message(op)
  word = case op
         when '1'
           'Adding'
         when '2'
           'Subtracting'
         when '3'
           'Multiplying'
         when '4'
           'Dividing'
         end
  word
end

prompt MESSAGES['welcome']

# would add language selection code here and move MESSAGES 
# declaration into this selection.

name = ''

loop do
  name = Kernel.gets.chomp
  if name.empty?
    prompt MESSAGES['valid_name']
  else
    break
  end
end

prompt "Welcome #{name}"

loop do
  number1 = ''
  loop do
    prompt MESSAGES['first_num']
    number1 = Kernel.gets.chomp
    if valid_number?(number1)
      break
    else
      prompt MESSAGES['invalid_num']
    end
  end

  number2 = ''
  loop do
    prompt MESSAGES['second_num']
    number2 = Kernel.gets.chomp
    if valid_number? number2
      break
    else
      prompt MESSAGES['invalid_num']
    end
  end
  operator = ''
  operator_prompt = <<-MSG
  What operation would you like to perform?
    1 - add
    2 - subtract 
    3 - multiply
    4 - divide
  MSG

  prompt operator_prompt

  loop do
    operator = Kernel.gets.chomp
    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt MESSAGES['valid_choice']
    end
  end
  prompt "#{operation_to_message(operator)} the two numbers..."
  result = case operator
           when '1'
             number1.to_f + number2.to_f
           when '2'
             number1.to_f - number2.to_f
           when '3'
             number1.to_f * number2.to_f
           when '4'
             if number2.to_f == 0
               MESSAGES['divide_by_zero']
             else
               number1.to_f / number2.to_f
             end
           end

  prompt "The result is #{result}"
  prompt(MESSAGES['again'])
  answer = Kernel.gets.chomp
  break unless answer.downcase.start_with? 'y'
  prompt MESSAGES['goodbye']
end
