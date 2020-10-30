class KrispyKreme
  attr_reader :filling_type, :glazing
  
  def initialize(filling_type, glazing)
    @filling_type = filling_type
    @glazing = glazing
  end
  
  def to_s
    if filling_type == nil && glazing == nil
      "Plain"
    elsif glazing == nil
      filling_type
    elsif filling_type == nil
      "Plain with #{glazing}"
    else
      "#{filling_type} with #{glazing}"
    end
  end
end

donut1 = KrispyKreme.new(nil, nil)
donut2 = KrispyKreme.new("Vanilla", nil)
donut3 = KrispyKreme.new(nil, "sugar")
donut4 = KrispyKreme.new(nil, "chocolate sprinkles")
donut5 = KrispyKreme.new("Custard", "icing")

puts donut1
  #=> "Plain"

puts donut2
  #=> "Vanilla"

puts donut3
  #=> "Plain with sugar"

puts donut4
  #=> "Plain with chocolate sprinkles"

puts donut5
  #=> "Custard with icing"