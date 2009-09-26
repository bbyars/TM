require 'test/unit'
require File.expand_path(File.dirname(__FILE__) + "/../lib/turing_machine.rb")

class TuringMachineTest < Test::Unit::TestCase

  def test_exception_thrown_if_states_not_added
    machine = TuringMachine.new(:start)
    assert_raise RuntimeError, "no states added" do
       machine.next!
    end
  end
  
  def test_single_state_with_alternating_zeros_and_ones
    machine = TuringMachine.new(:start)
    machine.add_state(:start) do |state|
      state.add [nil], :start, proc { |tape| tape.print(0) }
      state.add [0], :start, proc { |tape| tape.right; tape.right; tape.print(1) }
      state.add [1], :start, proc { |tape| tape.right; tape.right; tape.print(0) }
    end
    
    machine.next!
    assert_equal [0], machine.sequence
    
    machine.next!
    assert_equal [0, 1], machine.sequence
    
    machine.next!
    assert_equal [0, 1, 0], machine.sequence
  end
  
  def test_multiple_states_with_alternating_zeros_and_ones
    machine = TuringMachine.new(:zero)
    machine.add_state(:zero) do |state|
      state.add [nil], :goto_one, proc { |tape| tape.print(0); tape.right }
    end
    machine.add_state(:goto_one) do |state|
      state.add [nil], :one, proc { |tape| tape.right }
    end
    machine.add_state(:one) do |state|
      state.add [nil], :goto_zero, proc { |tape| tape.print(1); tape.right }
    end
    machine.add_state(:goto_zero) do |state|
      state.add [nil], :zero, proc { |tape| tape.right }
    end
    
    machine.next!
    assert_equal [0], machine.sequence
    
    machine.next!
    machine.next!
    assert_equal [0, 1], machine.sequence
    
    machine.next!
    machine.next!
    assert_equal [0, 1, 0], machine.sequence
  end

  def test_run
    machine = TuringMachine.new(:start)
    machine.add_state(:start) do |state|
      state.add [nil], :start, proc { |tape| tape.print(0) }
      state.add [0], :start, proc { |tape| tape.right; tape.right; tape.print(1) }
      state.add [1], :start, proc { |tape| tape.right; tape.right; tape.print(0) }
    end
    
    machine.run(5)
    assert_equal [0, 1, 0, 1, 0], machine.sequence
  end

end

