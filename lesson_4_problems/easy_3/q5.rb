class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

tv = Television.new # Television object instantiated and assigned to local var tv
tv.manufacturer # Throw an exception, there is no instance method manufacturer
tv.model # Execute instance method model

Television.manufacturer # Execute class method manufacturer
Television.model # Throw an exception, there is no class method model