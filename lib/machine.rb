class Machine

  attr_accessor :rotor_one, :rotor_two, :rotor_three

  ROTOR_I = [
    ["A", "E"],
    ["B", "K"],
    ["C", "M"],
    ["D", "F"],
    ["E", "L"],
    ["F", "G"],
    ["G", "D"],
    ["H", "Q"],
    ["I", "V"],
    ["J", "Z"],
    ["K", "N"],
    ["L", "T"],
    ["M", "O"],
    ["N", "W"],
    ["O", "Y"],
    ["P", "H"],
    ["Q", "X"],
    ["R", "U"],
    ["S", "S"],
    ["T", "P"],
    ["U", "A"],
    ["V", "I"],
    ["W", "B"],
    ["X", "R"],
    ["Y", "C"],
    ["Z", "J"],
    ["A", "E"],
    ["B", "K"],
    ["C", "M"],
    ["D", "F"],
    ["E", "L"],
    ["F", "G"],
    ["G", "D"],
    ["H", "Q"],
    ["I", "V"],
    ["J", "Z"],
    ["K", "N"],
    ["L", "T"],
    ["M", "O"],
    ["N", "W"],
    ["O", "Y"],
    ["P", "H"],
    ["Q", "X"],
    ["R", "U"],
    ["S", "S"],
    ["T", "P"],
    ["U", "A"],
    ["V", "I"],
    ["W", "B"],
    ["X", "R"],
    ["Y", "C"],
    ["Z", "J"]
  ]

  ROTOR_II = [
    ["A", "A"],
    ["B", "J"],
    ["C", "D"],
    ["D", "K"],
    ["E", "S"],
    ["F", "I"],
    ["G", "R"],
    ["H", "U"],
    ["I", "X"],
    ["J", "B"],
    ["K", "L"],
    ["L", "H"],
    ["M", "W"],
    ["N", "T"],
    ["O", "M"],
    ["P", "C"],
    ["Q", "Q"],
    ["R", "G"],
    ["S", "Z"],
    ["T", "N"],
    ["U", "P"],
    ["V", "Y"],
    ["W", "F"],
    ["X", "V"],
    ["Y", "O"],
    ["Z", "E"],
    ["A", "A"],
    ["B", "J"],
    ["C", "D"],
    ["D", "K"],
    ["E", "S"],
    ["F", "I"],
    ["G", "R"],
    ["H", "U"],
    ["I", "X"],
    ["J", "B"],
    ["K", "L"],
    ["L", "H"],
    ["M", "W"],
    ["N", "T"],
    ["O", "M"],
    ["P", "C"],
    ["Q", "Q"],
    ["R", "G"],
    ["S", "Z"],
    ["T", "N"],
    ["U", "P"],
    ["V", "Y"],
    ["W", "F"],
    ["X", "V"],
    ["Y", "O"],
    ["Z", "E"]
  ]

  ROTOR_III = [
    ["A", "B"],
    ["B", "D"],
    ["C", "F"],
    ["D", "H"],
    ["E", "J"],
    ["F", "L"],
    ["G", "C"],
    ["H", "P"],
    ["I", "R"],
    ["J", "T"],
    ["K", "X"],
    ["L", "V"],
    ["M", "Z"],
    ["N", "N"],
    ["O", "Y"],
    ["P", "E"],
    ["Q", "I"],
    ["R", "W"],
    ["S", "G"],
    ["T", "A"],
    ["U", "K"],
    ["V", "M"],
    ["W", "U"],
    ["X", "S"],
    ["Y", "Q"],
    ["Z", "O"],
    ["A", "B"],
    ["B", "D"],
    ["C", "F"],
    ["D", "H"],
    ["E", "J"],
    ["F", "L"],
    ["G", "C"],
    ["H", "P"],
    ["I", "R"],
    ["J", "T"],
    ["K", "X"],
    ["L", "V"],
    ["M", "Z"],
    ["N", "N"],
    ["O", "Y"],
    ["P", "E"],
    ["Q", "I"],
    ["R", "W"],
    ["S", "G"],
    ["T", "A"],
    ["U", "K"],
    ["V", "M"],
    ["W", "U"],
    ["X", "S"],
    ["Y", "Q"],
    ["Z", "O"]
  ]

  INPUT_OUTPUT = %w{A B C D E F G H I J K L M N O P Q R S T U V W X Y Z}

  REFLECTOR = %w{A B C D E F G D I J K G M K M I E B F T C V V J A T}

  def convert(character)
    character = rotor_three.convert(character, INPUT_OUTPUT, rotor_three.outer)
    character = rotor_two.convert(character, rotor_three.inner, rotor_two.outer)
    character = rotor_one.convert(character, rotor_two.inner, rotor_one.outer)

    reflector_index = rotor_one.convert(character, rotor_one.inner, REFLECTOR, true)
    character = REFLECTOR[reflector_index]
    reflector_array = REFLECTOR.dup
    reflector_array.delete_at(reflector_index)
    reflector_array.insert(reflector_index, nil)

    character = rotor_one.inner[reflector_array.index(character)]
    character = rotor_one.convert(character, rotor_one.outer, rotor_two.inner)
    character = rotor_two.convert(character, rotor_two.outer, rotor_three.inner)
    character = rotor_three.convert(character, rotor_three.outer, INPUT_OUTPUT)

    rotor_three.advance_position!
    character
  end

  def convert_string(string)
    string.split('').map {|char| convert(char) }.join('')
  end

  def reset!
    rotor_one.reset_position!
    rotor_two.reset_position!
    rotor_three.reset_position!
  end
end