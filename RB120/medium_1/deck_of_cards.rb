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

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
puts drawn.count { |card| card.rank == 5 } == 4
puts drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
puts drawn != drawn2 # Almost always.