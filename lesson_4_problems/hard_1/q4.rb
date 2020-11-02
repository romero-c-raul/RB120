=begin
- The designers of the vehicle management system now want to make an adjustment for
  how the range of vehicles is calculated. For the seaborne vehicles, due to 
  prevailing ocean currents, they want to add an additional 10km of range even if 
  the vehicle is out of fuel.

- Alter the code related to vehicles so that the range for autos and motorcycles 
  is still calculated as before, but for catamarans and motorboats, the range 
  method will return an additional 10km.
=end

module Moveable
  attr_accessor :speed, :heading
  attr_writer :fuel_capacity, :fuel_efficiency

  def range
    @fuel_capacity * @fuel_efficiency
  end
end

class WheeledVehicle
  include Moveable

  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
  end

  def tire_pressure(tire_index)
    @tires[tire_index]
  end

  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end
end

class Boat
  include Moveable
  
  attr_reader :propeller_count, :hull_count
  
  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
  end
  
  def range
    super + 10
  end
end


class Catamaran < Boat; end

class Motorboat < Boat
  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    super(1, 1, km_traveled_per_liter, liters_of_fuel_capacity)
    # ... other code to track motorboat-specific data omitted ...
  end
end
  
Catamaran.new(1,1,1,1)
Motorboat.new(5, 20)