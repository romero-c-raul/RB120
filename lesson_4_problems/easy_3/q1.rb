class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

# Case 1
hello = Hello.new # instantiating new object from Hello class
hello.hi # calling method hi, which in turn calls methodgreet and passing 
         # "Hello" as an argument. 
         # Output is "Hello"

# Case 2
hello = Hello.new # instantiating new object from Hello class
hello.bye # calling method bye which in turn calls method greet and passing 
          # "Goodbye" as an argument. 
          # Output is "Goodbye"
          # WRONG -> did not read program correctly, Hello class or its superclass do not
          # have a method bye

# Case 3
hello = Hello.new # instantiating new object from Hello class
hello.greet       # calling method greet with no argument, this will give us an exception

# Case 4
hello = Hello.new       # instantiating new object from Hello class
hello.greet("Goodbye")  #calling method greet and passing "Goodbye" as an argument
                        # Output is "Goodbye"

# Case 5
Hello.hi # This will give us an exception, since there is no class method hi