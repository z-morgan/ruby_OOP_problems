class Person
  def first_name=(first)
    @first_name = first.capitalize
  end

  def last_name=(last)
    @last_name = last.capitalize
  end

  def initialize(first_name, last_name)
    @first_name = first_name.capitalize
    @last_name = last_name.capitalize
  end

  def to_s
    "#{@first_name} #{@last_name}"
  end
end

person = Person.new('john', 'doe')
puts person

person.first_name = 'jane'
person.last_name = 'smith'
puts person

# John Doe
# Jane Smith