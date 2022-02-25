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
    # when royal_flush?     then 'Royal flush'
    # when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    # when full_house?      then 'Full house'
    # when flush?           then 'Flush'
    # when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  def royal_flush?

  end

  def straight_flush?
  end

  def four_of_a_kind?
    duplicate_ranks?(4)
  end

  def full_house?
  end

  def flush?
  end

  def straight?
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
