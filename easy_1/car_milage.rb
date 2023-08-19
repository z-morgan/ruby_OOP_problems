require 'pry'

class Car
  attr_accessor :mileage

  def initialize
    @mileage = 0
  end

  def increment_mileage(miles)
    total = mileage + miles
    self.mileage = total
  end

  def print_mileage
    puts mileage
  end
end

car = Car.new
car.mileage = 5000
puts car.mileage
car.increment_mileage(678)
puts car.mileage
car.print_mileage  # should print 5678