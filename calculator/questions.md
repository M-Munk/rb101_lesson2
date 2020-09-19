1. Is there a better way to validate that the user has input a number?

I would check if `number.to_i().to_s == number` which would allow for entering zero.  This would necessitate a check for a zero divisor on the divide operation, or you will get a DIVIDEBYZERO error.

2. It looks like you can call `to_i` or `to_f` to convert strings to integers and floats, respectively.  Look up the `String#to_i` and `String#to_f` documentation in Ruby docs and look at their various examples and use cases.

`to_i(base=10) -> integer`
Returns the result of interpreting leading characters in a string as an integer base *base*(between 2 and 36). Extraneous characters past the end of a valid number are ignored. If there is not a valid number at the start of string, 0 is returned. This method never raises an exception when *base* is valid.

`to_f -> float`
Returns the result of interpreting leading characters in string as a floating point number. Extraneous characters past the end of a valid number are ignored. If there is not a valid number at the start of string, 0.0 is returned. This method never raises an exception.

```Ruby
"123.45e1".to_f        #=> 1234.5
"45.67 degrees".to_f   #=> 45.67
"thx1138".to_f         #=> 0.0
```

```Ruby
"12345".to_i             #=> 12345
"99 red balloons".to_i   #=> 99
"0a".to_i                #=> 0
"0a".to_i(16)            #=> 10
"hello".to_i             #=> 0
"1100101".to_i(2)        #=> 101
"1100101".to_i(8)        #=> 294977
"1100101".to_i(10)       #=> 1100101
"1100101".to_i(16)       #=> 17826049
```

3. Our `operation_to_message` method is a little dangerous, because we're relying on the case statement being the last expression in the method. What if we needed to add some code after the case statement within the method? What changes would be needed to keep the method working with the rest of the program?

We could set a local variable 'result' just prior to the case statemnt with each `when` statement setting the local variable 'result' equal to the appropriate string for that case.  At the end of the code we need to add, we can insert a return statement and `return result` back to the method caller.

4.  Most Rubyists don't invoke methods with parenthesis, unless they're passing an argument. For example, we use `name.empty?()` but most Rubyists would write `name.empty?`  Some Rubyists even go so far as not putting parentheses around method calls even when passing in arguments.  For example, they would write `prompt "hi there"` as opposed to `prompt("hi there")`

Try removing some of the optional parentheses when calling methods to get your eyes acquanted to reading different styles of Ruby code. This will be expecially useful if you are using a DSL written in Ruby, like Rspec or Rails.

This was done in the `calculator_refactor.rb` file

5.  We're using `Kernel.puts()` and `Kernel.gets()` But the `Kernel.` is extraneous as well as the parentheses. Therefore, we can just call those methods by `gets` and `puts`. We already know that in Ruby we can omit the parentheses, but how come we can also omit the `Kernel.`?

According to the Ruby documentation: The Kernel module is included by class Object, so its methods are available in every Ruby Object.

The Kernel instance methods are documented in class Object while the module methods are documented here. These methods are called without a reciever and thus can be called in functional form.

6.  There are lots of messages sprinkled throughout the program. Could we move them into some configuration file and access by key? This would allow us to manage the messages much easier, and we could even internationalize the messages.  This is just a thought experiment, and no need to code this up.

You could probably create some type of hash in a file and import it into your calculator program, and then access the values of the text by the key in the hash.




