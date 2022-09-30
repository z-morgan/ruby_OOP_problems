class EmptyStackError < StandardError; end
class InvalidCommandError < StandardError; end

class Stack
  def initialize
    @stack_arr = []
  end

  def pop
    return @stack_arr.pop unless @stack_arr.empty?
    raise EmptyStackError, "Empty stack!"
  end

  def push(item)
    @stack_arr.push(item)
  end
end

class Minilang
  COMMANDS = %w(PRINT PUSH MULT ADD SUB POP DIV MOD)

  attr_accessor :register, :commands, :stack

  def initialize(commands)
    @commands = commands.split
    @stack = Stack.new
    @register = 0
  end

  def eval
    @commands.each do |com|
      # p @stack
      if number?(com)
        self.register = com.to_i
      else
        interpret(com)
      end
    end
  end

  private

  def interpret(com)
    if COMMANDS.include?(com)
      send(com.downcase)
    elsif com =~ /\A[-+]?\d+\z/
      self.register = com.to_i
    else
      raise InvalidCommandError, "Invalid command: #{com}"
    end
  end

  def print
    puts register
  end

  def push
    stack.push(register)
  end

  def mult
    self.register = stack.pop * register
  end

  def div
    self.register = register / stack.pop
  end

  def add
    self.register += stack.pop
  end

  def sub
    self.register -= stack.pop
  end

  def pop
    self.register = stack.pop
  end

  def mod
    self.register = register % stack.pop
  end

  def number?(com)
    com.to_i.to_s == com
  end
end

Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)