class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

# Given the class below, how do we create two different instances of this class 
# with separate names and ages?

cat1 = AngryCat.new("5", "snickers")
cat2 = AngryCat.new("8", "mittens")