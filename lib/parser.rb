require File.expand_path(File.dirname(__FILE__) + "/turing_machine.rb")

class Parser
  
  def parse(program)
    commands = program.strip.split("\n")
    state_descriptions = commands.map { |command| parse_state(command) }
    machine = TuringMachine.new(state_descriptions[0][:name])
    add_states(machine, state_descriptions)
    machine
  end
  
  protected
  
  def parse_state(command_text)
    parts = command_text.split
    { :name => parts[0], :symbols => parts[1], :commands => parts[2], :next => parts[3] }
  end
  
  def add_states(machine, state_descriptions)
    state_descriptions.each do |state_description|
      machine.add_state(state_description[:name]) do |state|
        state.add symbols(state_description[:symbols]), state_description[:next], actions(state_description[:commands])
      end
    end
  end
  
  # 1. Get all symbols (in symbols part, and after P commands)
  # 2. Allow Any = universe of symbols; None = nil
  def symbols(list)
    list.split(',').map do |symbol|
      if symbol == "None"
        nil
      else
        symbol
      end
    end
  end
  
  def actions(command_text)
    commands = command_text.split(',')
    proc { |tape|
      commands.each do |command|
        case command 
        when 'R':   tape.right
        when 'L':   tape.left
        when /^P.$/: tape.print(command[1..1])
        else raise "Invalid command: <#{command}>"
        end
      end
    }
  end
end
