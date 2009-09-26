require File.expand_path(File.dirname(__FILE__) + "/turing_machine.rb")

class State

  attr_reader :name
  
  def initialize(name, machine)
    @name, @machine = name, machine
    @behaviors = {}
  end

  def add(symbols, next_state_name, actions)
    symbols.each do |symbol|
      @behaviors[symbol] = { :action => actions, :next => next_state_name }
    end
    self
  end

  def runnable?
    @behaviors.keys.any? { |symbol| symbol == @machine.tape.scanned_symbol }
  end
  
  def execute!
    raise "state not runnable" unless runnable?
    behavior = @behaviors[@machine.tape.scanned_symbol]
    behavior[:action].call(@machine.tape)
    @machine.state = behavior[:next]
  end

end
