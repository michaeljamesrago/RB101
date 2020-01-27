=begin
Question 1:
For this practice problem, write a one-line program that creates the following
output 10 times, with the subsequent line indented 1 space to the right:
=end

puts ("Question 1:")
str = "The Flintstones Rock!"
10.times do
  puts str
  str = ' ' + str
end
print "\n"

=begin
Question 2:

The result of the following statement will be an error:

    puts "the value of 40 + 2 is " + (40 + 2)

Why is this and what are two possible ways to fix this?

A: It's trying to add a string to an integer.
=end

puts "Question 2:"
puts "the value of 40 + 2 is " + (40 + 2).to_s
puts ("or").center(22)
puts "the value of 40 + 2 is #{40 + 2}."
print "\n"

=begin
Question 3:

Alan wrote the following method, which was intended to show all of the factors
of the input number. Alyssa noticed that this will fail if the input is 0, or a
negative number, and asked Alan to change the loop. How can you make this work
without using begin/end/until?
=end

puts "Question 3:"
def factors(number)
  return nil if number == 0
  factors = []
  (1..number.abs).each do |i|
    if number % i == 0
      factors << i
      factors << -i if number < 0
    end
  end
  factors
end
p factors(12)
p factors(0)
p factors(-16)

=begin
Question 4:

Alyssa was asked to write an implementation of a rolling buffer. Elements are
added to the rolling buffer and if the buffer becomes full, then new elements
that are added will displace the oldest elements in the buffer.

She wrote two implementations saying, "Take your pick. Do you like << or + for
modifying the buffer?". Is there a difference between the two, other than what
operator she chose to use to add an element to the buffer?

      def rolling_buffer1(buffer, max_buffer_size, new_element)
        buffer << new_element
        buffer.shift if buffer.size > max_buffer_size
        buffer
      end

      def rolling_buffer2(input_array, max_buffer_size, new_element)
        buffer = input_array + [new_element]
        buffer.shift if buffer.size > max_buffer_size
        buffer
      end

A: The first method destructively modifies the argument 'buffer' and returns it.
The second method returns a modified copy of 'input_array'. You can modify an
array using the first method by saying

    rolling_buffer1(my_buffer, 10, "hello")

but if you want to use the second method you'd have to say

    my_buffer = rolling_buffer2(my_buffer, 10, 'hello')

Question 5:

Ben coded up this implementation but complained that as soon as he ran it, he
got an error. Something about the limit variable. What's wrong with the code?

      limit = 15

      def fib(first_num, second_num)
        while first_num + second_num < limit
          sum = first_num + second_num
          first_num = second_num
          second_num = sum
        end
        sum
      end

      result = fib(0, 1)
      puts "result is #{result}"

A: The limit variable is not visible inside the method definition, because it
is declared in an outer scope.

Question 6:

What is the output of the following code?

    answer = 42

    def mess_with_it(some_number)
      some_number += 8
    end

    new_answer = mess_with_it(answer)

    p answer - 8

A: 34

Question 7:

    munsters = {
      "Herman" => { "age" => 32, "gender" => "male" },
      "Lily" => { "age" => 30, "gender" => "female" },
      "Grandpa" => { "age" => 402, "gender" => "male" },
      "Eddie" => { "age" => 10, "gender" => "male" },
      "Marilyn" => { "age" => 23, "gender" => "female"}
    }

    def mess_with_demographics(demo_hash)
      demo_hash.values.each do |family_member|
        family_member["age"] += 42
        family_member["gender"] = "other"
      end
    end

After writing this method, he typed the following...and before Grandpa could
stop him, he hit the Enter key with his tail:

    mess_with_demographics(munsters)

Did the family's data get ransacked? Why or why not?

A: Yes. mess_with_demographics(munsters) passed a reference to the munsters
object (not a copy of that object) which was assigned to the variable
demo_hash. Then, demo_hash.values returned an array of references to the values
in numsters (not copies of those values). That array called the #each method,
which passed each reference in the array to the block. Therefore, when the
block is executed, it is operating on references the data in the original
object, the munsters hash.

Question 8:

    def rps(fist1, fist2)
      if fist1 == "rock"
        (fist2 == "paper") ? "paper" : "rock"
      elsif fist1 == "paper"
        (fist2 == "scissors") ? "scissors" : "paper"
      else
        (fist2 == "rock") ? "rock" : "scissors"
      end
    end

What is the result of the following call?

    puts rps(rps(rps("rock", "paper"), rps("rock", "scissors")), "rock")

A: "paper"

Question 9:

def foo(param = "no")
  "yes"
end

def bar(param = "no")
  param == "no" ? "yes" : "no"
end
What would be the return value of the following method invocation?

bar(foo)

A: "no"
=end
