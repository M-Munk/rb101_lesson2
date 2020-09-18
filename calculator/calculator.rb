# ask the user for two numbers
# ask the user for an operation to perform
# perform the operation on the two numbers
# output the result

# answer = Kernel.gets()
# Kernel.puts(answer)

Kernel.puts("Welcome to the Calculator")

Kernel.puts("What's the first number?")

number1 = Kernel.gets().chomp()

# Kernel.puts(number1.inspect())
# Kernel.puts("The number is " +number1 + "!")

Kernel.puts("What's the second number?")
number2 = Kernel.gets().chomp()

# Kernel.puts(number1 + " " + number2)

Kernel.puts("What operation would you like to perform?")
Kernel.puts("1 - add, 2 - subtract, 3 - multiply, 4 - divide")
operator = Kernel.gets().chomp()

if operator == '1'
  result = number1.to_i() + number2.to_i()
elsif operator == '2'
  result = number1.to_i() - number2.to_i()
elsif operator == '3'
  result = number1.to_i() * number2.to_i()
else
  result = number1.to_f() / number2.to_f()
  #convert to f here to get the decimal division rather than integer division
end

Kernel.puts("The result is #{result}")