require 'minitest/autorun'

require_relative 'stack_machine.rb'

class MinilangTest < MiniTest::Test
  def test_eval_print
    assert_output("0") { Minilang.new('PRINT').eval }
  end

  def test_eval_mult
    commands = '5 PUSH 3 MULT PRINT'
    assert_output("15") { Minilang.new(commands).eval }
  end

  def test_eval_3
    
  end
end