=begin
- What could you add to this class to simplify it and remove two 
  methods from the class definition while still maintaining the same 
  functionality?
=end

class BeesWax
  attr_accessor :type #Instead create a getter and setter method this way
  
  def initialize(type)
    @type = type
  end

  # def type # Remove these getter and setter methods
  #   @type
  # end

  # def type=(t)
  #   @type = t
  # end

  def describe_type
    puts "I am a #{type} of Bees Wax" #call the getter method instead of inst variable
  end
end