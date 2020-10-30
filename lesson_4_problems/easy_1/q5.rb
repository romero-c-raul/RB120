#Which of these two classes has an instance variable and how do you know?

class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
  
end

# Only class pizza has an instance variable, since it has a variable that starts
# with an "@" symbol