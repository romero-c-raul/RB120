class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

# Explain what the @@cats_count variable does and how it works. 
# What code would you need to write to test your theory?

=begin
- The @@cats_count variable is a class variable and is there to keep track of how
  many Cat class instances have been created
- When we instantiante a new Cat object, the @@cats_count variable will increase by 1
- We can test this by invoking class method Cat.cats_count and looking and the number
  returned
=end

new_cat = Cat.new('small')
p Cat.cats_count

