class Light
  attr_accessor :brightness, :color # These are not neede in out current code

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    "I want to turn on the light with a brightness level of super high and a color of green"
  end

end

# What is used in this class but doesn't add any value?
# Delete return keyword on line 10
# of the light

p Light.information