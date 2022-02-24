### did not do further exploration

class Card
  include Comparable
  
  FACE_VALUES = {"Jack" => 11, "Queen" => 12, "King" => 13, "Ace" => 14}
  SUIT_VALUE = {"Spades" => 4, "Hearts" => 3, "Clubs" => 2, "Diamonds" => 1}
  
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit  # -->> spades > hearts > clubs > diamonds
  end
  
  def numeric(rank)
    return rank if rank.class == Integer
    FACE_VALUES[rank]
  end
  
  def <=>(other_card)
      num = numeric(rank) <=> other_card.numeric(other_card.rank)
      return num unless num == 0
      SUIT_VALUE[suit] <=> SUIT_VALUE[other_card.suit]
  end
  
  def to_s
    "#{rank} of #{suit}"
  end
end

cards = [Card.new(7, 'Diamonds'),
         Card.new('Jack', 'Diamonds'),
         Card.new('Jack', 'Spades')]
puts cards.min == Card.new(7, 'Diamonds')
puts cards.max == Card.new('Jack', 'Spades')

cards = [Card.new(8, 'Diamonds'),
         Card.new(8, 'Clubs'),
         Card.new(8, 'Spades')]
puts cards.min == Card.new(8, 'Diamonds')
puts cards.max == Card.new(8, 'Spades')