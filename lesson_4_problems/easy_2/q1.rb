class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

oracle = Oracle.new
p oracle.predict_the_future

=begin

- On line 11, we are instantiating a new object from the Oracle class, and
  assigning it to local variable oracle
  
- On line 12, we are calling instance method #predict_the_future, defined in the
  Oracle class, on local variable oracle.
  - This will return "You will" plus any of the other string objects that are
    within the array object that instance method choices returns

=end