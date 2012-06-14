class Rotor

  attr_accessor :position

  def initialize(mappings,position)
    @mappings = mappings
    @position = position
    @original_position = position
  end

  def convert(character, source, matches, return_index = false)
    index = source.index(character)
    raise "No match for #{index} in #{matches.join(',')}." unless matches[index]
    return_index ? index : matches[index]
  end

  def reset_position!
    @position = @original_position
  end

  def advance_position!
    @position += 1
  end

  def outer
    array = @mappings.map {|a| a[1] }
    array.shift(position)
    array
  end

  def inner
    array = @mappings.map {|a| a[0] }
    array.shift(position)
    array
  end

end