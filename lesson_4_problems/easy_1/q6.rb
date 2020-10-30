# - What could we add to the class below to access the instance 
#   variable @volume?

class Cube
  attr_reader :volume # You can do this
  
  def initialize(volume)
    @volume = volume
  end
  
  # def volume # You can also define your own getter method
  #   @volume
  # end
  
end

# - We can create a getter method using attr_reader or defining the method 
#   ourselves

# - We can also use #instance_variable_get(instance_variable)