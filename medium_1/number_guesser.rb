class GuessingGame
  attr_accessor :guesses_remaining, :target, :current_guess

  def initialize
    @guesses_remaining = 0
    @target = nil
    @current_guess = nil
  end

  def play
    self.guesses_remaining = 7
    self.target = (1..100).to_a.sample

    while guesses_remaining > 0
      display_guesses
      get_guess
      break if correct_guess?
      self.guesses_remaining -= 1
    end
    display_result
  end

  private

  def display_guesses
    puts "You have #{@guesses_remaining} guesses remaining."
  end

  def get_guess
    choice = nil
    loop do
      print "Enter a number between 1 and 100: "
      choice = gets.chomp.to_i
      break if (1..100) === choice
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

game = GuessingGame.new
game.play