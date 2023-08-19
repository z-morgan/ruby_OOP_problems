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

class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    @cards = generate_new_deck
  end

  attr_accessor :cards

  def generate_new_deck
    cards_arr = SUITS.product(RANKS).map { |suit, rank| Card.new(rank, suit) }
    cards_arr.shuffle
  end

  def draw
    return cards.pop unless cards.size == 1
    last_card = cards.pop
    self.cards = generate_new_deck
    last_card
  end
end

class PokerHand
  def initialize(deck)
    @hand = []
    5.times { @hand << deck.pop }
  end

  attr_reader :hand

  def print
    puts hand
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  def royal_flush?
    straight_flush? && hand.any? { |card| card.rank == "Ace" }
  end

  def straight_flush?
    flush? && straight?
  end

  def four_of_a_kind?
    duplicate_ranks?(4)
  end

  def full_house?
    (hand.uniq(&:rank).size > 1) && three_of_a_kind? && pair?
  end

  def flush?
    test_suit = hand[0].suit
    hand.all? { |card| card.suit == test_suit }
  end

  def straight?
    rank_values = hand.map { |card| card.numeric(card.rank) }.sort
    (1..4).all? { |i| rank_values[i] - rank_values[i - 1] == 1 }
  end

  def three_of_a_kind?
    duplicate_ranks?(3)
  end

  def two_pair?
    count = 0
    arr = []
    hand.each { |card| arr << card.rank }
    2.times do
      dup_rank = arr.find { |rank| arr.count(rank) == 2 }
      count += 1 if dup_rank
      arr.delete(dup_rank)
    end
    true if count == 2
  end

  def pair?
    duplicate_ranks?(2)
  end

  def duplicate_ranks?(num)
    arr = []
    hand.each { |card| arr << card.rank }
    arr.any? { |rank| arr.count(rank) == num }
  end
end

# Test that we can identify each PokerHand type.
hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts hand.evaluate == 'Royal flush'

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight flush'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Four of a kind'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush'

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new('Queen', 'Clubs'),
  Card.new('King',  'Diamonds'),
  Card.new(10,      'Clubs'),
  Card.new('Ace',   'Hearts'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Three of a kind'

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Pair'

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card'