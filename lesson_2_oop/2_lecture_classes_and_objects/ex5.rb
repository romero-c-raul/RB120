#Continuing with our Person class definition, what does the below print out?

class Person
  attr_accessor :first_name, :last_name
  
  def initialize(full_name)
    parse_full_name(full_name)
  end
  
  def name
    "#{first_name} #{last_name}".strip
  end
  
  def name=(new_name)
    parse_full_name(new_name)
  end
  
  private
  def parse_full_name(full_name)
    parts = full_name.split
    self.first_name = parts.first
    self.last_name = parts.size > 1 ? parts.last : ''
  end
  
  def to_s
    self.name
  end
end

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"

#This should return the class with the encoding of the object
