class Tape
  
  def initialize
    @tape = []
    @head_position = 0
  end
  
  def print(symbol)
    @tape[@head_position] = symbol
    self
  end
  
  def left
    @head_position -= 1
    self
  end
  
  def right
    @head_position += 1
    self
  end
  
  def scanned_symbol
    @tape[@head_position]
  end
  
  def sequence
    @tape
  end
  
end
