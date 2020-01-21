require "pry"

def prompt(str)
  puts "=> #{str}"
end

def valid_number(num)
  num.to_f != 0
end

principal = 0.0
apr = 0.0
loan_duration = 0

prompt "Welcome to the car payment calculator."
loop do
  prompt "Please enter the original loan amount:"
  principal = gets.chomp
  break if valid_number(principal)
  prompt "That is not a valid loan amount."
end

principal = principal.to_f

loop do
  prompt "Please enter the APR:"
  apr = gets.chomp
  break if valid_number(apr)
  prompt "That is not a valid APR."
end

apr = apr.to_f
monthly_interest = apr / 1200

loop do
  prompt "Please enter the loan duration in months:"
  loan_duration = gets.chomp
  break if valid_number(loan_duration)
  prompt "That is not a valid number of months."
end
loan_duration = loan_duration.to_f

monthly_payment = principal * (monthly_interest / (1 - (1 + monthly_interest)**(
  0 - loan_duration)))

prompt("Your monthly payment is $#{format('%02.2f', monthly_payment)}")
