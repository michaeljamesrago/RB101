# Given an array of strings
# SET iterator i to 0
# SET variable return_value to empty string to accumulate string values
# WHILE i < number of items in given array
# SET return_value to its current value plus the value of the object at
# the index of i in the given array
# SET i to i + 1
# RETURNS return_value

def concatenator(strings)
  i = 0
  return_value = ""
  while i < strings.length
    return_value += strings[i]
    i += 1
  end
  return_value
end

puts concatenator(["hey", "GGG", "boo", "123456", "quack"])
