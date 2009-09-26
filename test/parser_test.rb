require 'test/unit'
require File.expand_path(File.dirname(__FILE__) + "/../lib/parser.rb")

class ParserTest < Test::Unit::TestCase

	def test_first_line_is_start_state
    machine = Parser.new.parse %Q{
      zero    None    P0,R   one
      one     None    P1,R   zero}
    assert_equal "zero", machine.state
	end
	
	def test_sets_next_state
    machine = Parser.new.parse %Q{
      zero    None    P0,R   one
      one     None    P1,R   zero}
    machine.next!
    assert_equal "one", machine.state
	end
	
	def test_recognizes_None_as_nil_and_executes_commands
    machine = Parser.new.parse %Q{
      zero    None    P0,R   one
      one     None    P1,R   zero}
    machine.next!
    assert_equal ["0"], machine.sequence
	end
	
	def test_runs_correctly
	  machine = Parser.new.parse %Q{
      zero    None    P0,R   one
      one     None    P1,R   zero}
    machine.run(5)
    assert_equal ["0", "1", "0", "1", "0"], machine.sequence
	end
	
end

__END__

con(E, a)   -A    R,R     con(E, a)
            A     L,Pa,R  con1(E, a)
con1(E, a)  A     R,Pa,R  con1(E, a)
            D     R,Pa,R  con2(E, a)
con2(E, a)  C     R,Pa,R  con2(E, a)
            -C    R,R     E
            
BNF:
m-config -> name | m-function
m-function -> name ( )