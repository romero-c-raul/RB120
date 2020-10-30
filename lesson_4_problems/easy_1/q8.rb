class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end

# - You can see in the make_one_year_older method we have used self. 
#   What does self refer to here?

# self within an instance method refers to the object that the instance method
# was called on (the calling object)

