require 'test/unit'
require File.expand_path(File.dirname(__FILE__) + "/../lib/tape.rb")

class TapeTest < Test::Unit::TestCase

  def test_empty_machine
    assert_equal [], Tape.new.sequence    
  end
  
  def test_print_single_symbol
    assert_equal [0], Tape.new.print(0).sequence
  end
  
  def test_print_does_not_move_head
    assert_equal [0], Tape.new.print(0).print(0).sequence
  end

  def test_move_right
    assert_equal [0, 1], Tape.new.print(0).right.print(1).sequence
  end

  def test_move_left
    assert_equal [1, 1], Tape.new.print(0).right.print(1).left.print(1).sequence
  end

  def test_scanned_symbol_before_moving
    assert_equal 0, Tape.new.print(0).scanned_symbol
  end

  def test_scanned_symbol_after_moving
    assert_equal 1, Tape.new.print(0).right.print(1).scanned_symbol
  end
  
end

