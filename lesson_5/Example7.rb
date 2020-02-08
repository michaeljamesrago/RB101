require "pry"
arr = [['1', '8', '11'], ['2', '6', '13'], ['2', '12', '15'], ['1', '8', '9']]
puts "\n\n"
puts "arr = [['1', '8', '11'], ['2', '6', '13'], ['2', '12', '15'], ['1', '8', '9']]"
puts "\n\n"
p arr
puts "\n\n"
p arr.sort
puts "\n\n"
#p arr.sort_by { |sub_arr| sub_arr.map { |num| num.to_i } }

p arr.sort_by do |sub_arr|
  sub_arr.map do |num|
    num.to_i
  end
end

puts "\n\n"

x = arr.sort_by do |sub_arr|
  sub_arr.map do |num|
    num.to_i
  end
end

p x
