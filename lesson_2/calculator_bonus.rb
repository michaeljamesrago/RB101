# ask the user for two numbers
# ask the user for operation to perform
# perform the operation on the two numbers
# output the result
require "yaml"
require "pry"
MESSAGES = YAML.load_file('calculator_messages.yml')

def prompt(message, lang = 'en')
  Kernel.puts("=> #{message}")
end

def set_language
  lang_hash = {'1' => 'en', '2' => 'es', '3' => 'fr'}
  lang_choice = ''
  loop do
    prompt 'Enter 1 for English, 2 for Spanish, or 3 for French.'
    lang_choice = Kernel.gets().chomp()
    break if %w(1 2 3).include?(lang_choice)
    prompt(MESSAGES['en']['invalid_entry'])
  end
  lang_hash[lang_choice]
end

LANGUAGE = set_language

def get_message(message_label)
  msg = MESSAGES[LANGUAGE][message_label]
end

def integer? (num)
  num == num.to_i.to_s
end

def float? (num)
  num == num.to_f.to_s
end

def valid_number?(num)
  integer?(num) || float?(num)
end

def calculating_message(s)
  msg = case s
        when '1'
          "Adding"
        when '2'
          "Subtracting"
        when '3'
          "Multiplying"
        when '4'
          "Dividing"
        end

  msg
end

def get_operand(question)
  number = ''
  loop do
    prompt question
    number = Kernel.gets().chomp()
    break if valid_number?(number)
    prompt(get_message('invalid_entry'))
  end
  number
end

op_prompt = <<-MSG
What operation would you like to perform?
  1) Add
  2) Subtract
  3) Multiply
  4) Divide
MSG

number1 = ""
number2 = ""

prompt(get_message('welcome'))

loop do
  number1 = get_operand('What is the first number?')
  number2 = get_operand('What is the second number?')

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
              number1.to_f() + number2.to_f()
            when "2"
              number1.to_f() - number2.to_f()
            when "3"
              number1.to_f() * number2.to_f()
            else
              number1.to_f() / number2.to_f()
            end

  prompt("The result is #{result}")
  prompt("Again?")
  answer = Kernel.gets.chomp()
  break unless answer.downcase.start_with?('y')
end

prompt("Goodbye")
