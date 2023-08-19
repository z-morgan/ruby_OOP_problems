class GuessingGame
  attr_accessor :guesses_remaining, :target, :current_guess
  
  attr_reader :range

  def initialize(low, high)
    @range = (low..high)
    @guesses_remaining = max_guesses
    @target = nil
    @current_guess = nil
  end

  def play
    self.target = range.to_a.sample

    while guesses_remaining > 0
      display_guesses
      get_guess
      break if correct_guess?
      self.guesses_remaining -= 1
    end
    display_result
  end

  private
  
  def max_guesses
    Math.log2(range.size).to_i + 1
  end
  
  def display_guesses
    puts "You have #{@guesses_remaining} guesses remaining."
  end

  def get_guess
    choice = nil
    loop do
      print "Enter a number between #{range.first} and #{range.last}: "
      choice = gets.chomp.to_i
      break if range === choice
      print "Invalid guess. "
    end
    self.current_guess = choice
  end

  def correct_guess?
    return true if target == current_guess
    target > current_guess ? display_direction(:up) : display_direction(:down)
    false
  end

  def display_direction(direction)
    case direction
    when :up then puts "Your guess is too low."
    when :down then puts "Your guess is too high."
    end
    puts nil
  end

  def display_result
    puts (target == current_guess ? "You won!" : "You have no more guesses. You lost!")
  end
end

game = GuessingGame.new(1, 300)
game.play