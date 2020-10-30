class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.light_status
    "I have a brightness level of #{brightness} and a color of #{color}"
  end

end

# How could you change the method name below so that the method name is more 
# clear and less repetitive?

# We can gave the method just be named 'status' or 'current_status'