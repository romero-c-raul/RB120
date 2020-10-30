module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end

#What is the lookup chain for Orange and HotSauce?

p Orange.ancestors
# We first look at the Orange class, then the Taste module, then Object, Kernel, 
# BasicObject