class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    @age += 1 # reference the instance variable directly instead of setter method
  end
end

# In the make_one_year_older method we have used self. 
# What is another way we could write this method so we don't have to 
# use the self prefix?

p snickers = Cat.new("tabby")
snickers.make_one_year_older
p snickers.age
p snickers