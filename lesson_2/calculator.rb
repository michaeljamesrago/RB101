# ask the user for two numbers
# ask the user for operation to perform
# perform the operation on the two numbers
# output the result

def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(num)
  num.to_i != 0
end

def calculating_message(s)
  case s
  when '1'
    "Adding"
  when '2'
    "Subtracting"
  when '3'
    "Multiplying"
  when '4'
    "Dividing"
  end
end

number1 = ""
number2 = ""

prompt("Welcome to Calculator!")
loop do
  loop do
    prompt "What's the first number?"
    number1 = Kernel.gets().chomp()

    if valid_number?(number1)
      break
    else
      prompt("That is not a valid entry.")
    end
  end

  loop do
    prompt("What's the second number?")
    number2 = Kernel.gets().chomp()

    if valid_number? number2
      break
    else
      prompt("That is not a valid entry.")
    end
  end

  op_prompt = <<-MSG
What operation would you like to perform?
    1) Add
    2) Subtract
    3) Multiply
    4) Divide
  MSG

  operator = ""

  prompt(op_prompt)
  loop do
    operator = Kernel.gets().chomp()
    break if %w(1 2 3 4).include?(operator)
    prompt("Must be 1, 2, 3, or 4")
  end

  prompt("#{calculating_message(operator)} the numbers")

  result =  case operator
            when "1"
              number1.to_i() + number2.to_i()
            when "2"
              number1.to_i() - number2.to_i()
            when "3"
              number1.to_i() * number2.to_i()
            else
              number1.to_f() / number2.to_f()
            end

  prompt("The result is #{result}")
  prompt("Again?")
  answer = Kernel.gets.chomp()
  break unless answer.downcase.start_with?('y')
end
prompt("Goodbye")
