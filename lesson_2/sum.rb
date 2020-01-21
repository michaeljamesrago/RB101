# START
# PRINT prompt for user to enter first number
# GET response and save it in a variable
# PRINT prompt for user to enter second number
# GET response and save it into a variable
# READ first variable and second variable and save sum into a new variable
# PRINT message showing the sum of the two numbers

puts("Please enter the first number:")
a = gets.chomp()
puts("Please enter the second number:")
b = gets.chomp()
c = a.to_i() + b.to_i()
puts("The sum of " + a + " and " + b + " is #{c}.")
