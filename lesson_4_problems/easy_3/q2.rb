class Greeting
  def greet(message)
    puts message
  end
  
  def self.greet(message)
    puts message
  end
  
end

class Hello < Greeting
  def self.hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

# If we call Hello.hi we get an error message. How would you fix this?

# change method name to self.hi, and define a greet class method

Hello.hi
