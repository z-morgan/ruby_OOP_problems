### did not do further exploration

class Card
  include Comparable
  
  FACE_VALUES = {"Jack" => 11, "Queen" => 12, "King" => 13, "Ace" => 14}
  
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end
  
  def numeric(rank)
    return rank if rank.class == Integer
    FACE_VALUES[rank]
  end
  
  def <=>(other_card)
      numeric(rank) <=> other_card.numeric(other_card.rank)
  end
  
  def to_s
    "#{rank} of #{suit}"
  end
end

cards = [Card.new(2, 'Hearts'),
         Card.new(10, 'Diamonds'),
         Card.new('Ace', 'Clubs')]
puts cards
puts cards.min == Card.new(2, 'Hearts')
puts cards.max == Card.new('Ace', 'Clubs')

cards = [Card.new(5, 'Hearts')]
puts cards.min == Card.new(5, 'Hearts')
puts cards.max == Card.new(5, 'Hearts')

cards = [Card.new(4, 'Hearts'),
         Card.new(4, 'Diamonds'),
         Card.new(10, 'Clubs')]
puts cards.min.rank == 4
puts cards.max == Card.new(10, 'Clubs')

cards = [Card.new(7, 'Diamonds'),
         Card.new('Jack', 'Diamonds'),
         Card.new('Jack', 'Spades')]
puts cards.min == Card.new(7, 'Diamonds')
puts cards.max.rank == 'Jack'

cards = [Card.new(8, 'Diamonds'),
         Card.new(8, 'Clubs'),
         Card.new(8, 'Spades')]
puts cards.min.rank == 8
puts cards.max.rank == 8