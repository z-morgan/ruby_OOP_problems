require 'pry'

class Pet
  def name
    @name
  end

  def initialize(n)
    @name = n.to_s        #this call to_s is the Kernal.to_s
  end

  def to_s
    "My name is #{@name.upcase}."
  end
end

# name = 'Fluffy'
# fluffy = Pet.new(name)
# puts fluffy.name         #calls to_s on the @name variable, so the .to_s is still the Kernal version
# puts fluffy
# puts fluffy.name
# puts name

name = 42
fluffy = Pet.new(name)
name += 1
puts fluffy.name
puts fluffy
puts fluffy.name
puts name