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

A: The problem occurs because the string literal "the value of 40 + 2" is a string, and when you try to concatenate a string using the `+` method, any argument passed to it must also be evaluated as a string. In this case, the result of the evaluation of the the expression (40 + 2) is an integer object, and the Ruby language will not allow it to be added to a string.

    One way to fix this would be to call the 'to_s' method on the result of (40 + 2). That would convert the result to a string which could be added to the other string. Another way would be to use string interpolation, as in `#{(40 + 2)}`
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

A: On `line 1`, the variable `limit` is initialized and set to refer to an integer object with a value of 15. On `line 4`, the programmer attempts to use this variable inside a method definition. However, since the variable was initialized outside the method definition, it is not visible inside it. The scope of the `fib` method's definition does not include the variable `limit`.

  One way to fix this would be to declare a constant and refer to that inside the method defnition instead, such as `LIMIT = 15`.

  A programmer could also define the `fib` method to take the limit variable as an argument, like `def fib(first_num, second_num, limit)`. This means that the value would have to be newly passed in to the `fib` method every time it was called.

  A third option would be to initialize the limit variable inside the method definition, making it local to the method definition. This is okay if you don't need access to the variable anywhere else in the program, because it will only be visible inside the method definition.

Question 6:

What is the output of the following code?

    answer = 42

    def mess_with_it(some_number)
      some_number += 8
    end

    new_answer = mess_with_it(answer)

    p answer - 8

A: On line 1, A local variable `answer` is initialized to refer to an integer object with a value of 42.

  On lines 3-5, the `mess_with_it` method is defined to accept one parameter, and a local variable `some_number` is initialized to refer to that parameter. On `line 4`, the local variable `some_number` is reassigned to its current value incremented by 8. The result of this expression's evaluation will be the return value of the `mess_with_it` method.

  On `line 7`, the local variable `new_answer` is initialized to refer to the return value of a call to the `mess_with_it` method with the local variable `answer` passed to it as an argument. The value of `answer` is 42 at this time, as set on `line 1`. So `new_answer` is set to the return value of that method call, which will be 50, or 42 incremented by 8.

  Throughout all this, the local variable `answer` has never been reassigned or mutated. It still points to the integer object 42. So on `line 9`, when the `p` method is called with the argument `answer - 8`, that expression evaluates to 34. Therefore, the output of this code will be 34.

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

Updated answer: Yes. The `mess_with_demographics` method was called, and the hash object `munsters` was passed to it as an argument. It was not a copy, it was the original object. The variable `demo_hash`, local to the `mess_with_demographics` method definition, refers to the `munsters` hash itself inside the method.

    When the `values` method is called on `demo_hash`, it returns an array with references to the objects that are the values of that hash; again, not copies of those objects, but the objects themselves. So when the resulting array calls the `each` method, the code in the block passed to the `each` method will be operating with references to the hash objects that were the values of `demo_hash`.

    Inside the block passed to the `each` method, the local variable `family_member` is assigned to each array member. The code on lines 11-12 mutates these members by reassigning the values associated with the keys `age` and `gender`. These are the same objects in the `munsters` hash, not copies of them. The `munsters` hash has been mutated.

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

The `foo` method always returns `yes`. When the `bar` method is called, the argument passed to it is the return value of the `foo` method, which is always `yes`.

The default value of `param` in the `bar` method is `no`, but in this instance it is called with an argument of `yes`. Therefore, the conditional statement `param == "no"` will evaluate to `false`. Because this conditional is used with a ternary operator, and the condition evaluates to `false`, the code after the colon will be executed. After the colon is simply the string `"no"`, which will be the return value of this call to the `bar` method.
=end
