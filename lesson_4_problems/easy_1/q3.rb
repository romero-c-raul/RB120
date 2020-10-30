=begin
- In the last question we had a module called Speed which contained a go_fast 
  method. We included this module in the Car class as shown below.
  =end

module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed
  def go_slow
    puts "I am safe and driving slow."
  end
end

=begin
- When we called the go_fast method from an instance of the Car class (as 
  shown below) you might have noticed that the string printed when we go 
  fast includes the name of the type of vehicle we are using. How is this done?

- When we use self within an instance method definition, we are referring to the
  object that the method is being called on.
  So if we have:
  
  small_car.go_fast
  
  - We are actually, within the method def of #go_fast, calling method #class
    on local var small_car that is pointing to a Car class object. Since
    we are calling method #class on a Car object, the return value will be
    'Car' since this is the object's class.

=end

