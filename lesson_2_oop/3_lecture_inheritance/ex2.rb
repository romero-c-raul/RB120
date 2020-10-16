=begin
Create a new class called Cat, which can do everything a dog can, except 
swim or fetch. Assume the methods do the exact same thing. 

Hint: don't just copy and paste all methods in Dog into Cat; 
try to come up with some class hierarchy.
=end

class Animal
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end


class Dog
  def speak
    'bark!'
  end
  
  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end
end

class Cat < Animal
  def speak
    'meow'
  end
end

pete = Animal.new
kitty = Cat.new
dave = Dog.new

p pete.run                # => "running!"
#pete.speak              # => NoMethodError

p kitty.run               # => "running!"
p kitty.speak             # => "meow!"
#kitty.fetch             # => NoMethodError

p dave.speak              # => "bark!"
