def dot_separated_ip_address?(input_string)
  #dot_separated_words = input_string.split(".")
  #while dot_separated_words.size > 0 do
  #  word = dot_separated_words.pop
  #  break unless is_an_ip_number?(word)
  #end
  #return true
  dot_separated_words = input_string.split(".")
  return false if dot_separated_words.length != 4
  return dot_separated_words.all?{ |n| n == n.to_i.to_s && n.to_i.between?(0, 255) }
end

puts dot_separated_ip_address?("1.255.67.99")
puts dot_separated_ip_address?("45.0.0.036")
puts dot_separated_ip_address?("0.255.0056.000100")
puts dot_separated_ip_address?("0.0.0.0")
puts dot_separated_ip_address?("0.20.30.40.50")
puts dot_separated_ip_address?("23.46.167.256")
puts dot_separated_ip_address?("poop.24.36.147")
puts dot_separated_ip_address?("255.255.255.-19")
