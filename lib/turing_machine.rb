require File.expand_path(File.dirname(__FILE__) + "/tape.rb")
require File.expand_path(File.dirname(__FILE__) + "/state.rb")

class TuringMachine
  
  attr_reader :tape
  attr_accessor :state
  
  def initialize(start_state)
    @tape = Tape.new
    @state = start_state
    @states = []
  end
  
  def add_state(name)
    state = State.new(name, self)
    @states << yield(state)
  end
  
  def run(iterations=100)
    iterations.times do
      next!
    end
  end
  
  def next!
    raise "no states added" if @states.empty?
    current = @states.detect { |state| state.name == @state }
    current.execute!
  end
  
  def sequence
    tape.sequence.compact
  end
  
end