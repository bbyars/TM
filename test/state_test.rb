require 'test/unit'
require File.expand_path(File.dirname(__FILE__) + "/../lib/state.rb")

class StateTest < Test::Unit::TestCase

  def test_does_not_match_empty_TuringMachine
    assert !State.new(:start, TuringMachine.new(:start)).runnable?
  end
  
  def test_matches_scanned_symbol
    machine = TuringMachine.new(:start)
    state = State.new(:start, machine).add([nil], :next, proc { |tape| })
    assert state.runnable?
  end
  
  def test_does_not_match_scanned_symbol
    machine = TuringMachine.new(:start)
    state = State.new(:second, machine).add([0], :next, proc { |tape| })
    assert !state.runnable?
  end
  
  def test_will_not_execute_if_not_runnable
    state = State.new(:start, TuringMachine.new(:start))
    assert_raise RuntimeError, "state not runnable" do
       state.execute!
    end
  end
  
  def test_simple_operation
    machine = TuringMachine.new(:start)
    state = State.new(:start, machine)
    state.add([nil], :next, proc { |tape| tape.print(0) })
    state.execute!
    assert_equal [0], machine.tape.sequence
  end
  
  def test_execute_changes_machine_state
    machine = TuringMachine.new(:start)
    state = State.new(:start, machine)
    state.add([nil], :next, proc { |tape| })
    state.execute!
    assert_equal :next, machine.state
  end

end

