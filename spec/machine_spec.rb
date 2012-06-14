require_relative '../lib/machine'
require_relative '../lib/rotor'

describe Machine do

  before do
    @machine = Machine.new
    @machine.rotor_one = Rotor.new(Machine::ROTOR_I, 12)
    @machine.rotor_two = Rotor.new(Machine::ROTOR_II, 2)
    @machine.rotor_three = Rotor.new(Machine::ROTOR_III, 11)
  end

  it "should allow three rotors to be specified" do
    machine = Machine.new
    machine.rotor_one = Rotor.new(Machine::ROTOR_I, 12)
    machine.rotor_two = Rotor.new(Machine::ROTOR_II, 2)
    machine.rotor_three = Rotor.new(Machine::ROTOR_III, 11)
  end

  it "should convert a character" do
    @machine.convert("E").should == "Q"
  end

  it "should convert a character in reverse" do
    @machine.convert("Q").should == "E"
  end

  it "should convert the same character to a different cipher when the rotor has moved posititon" do
    @machine.convert("Q").should == "E"
    @machine.convert("Q").should == "D"
    @machine.convert("Q").should == "Y"
    @machine.convert("Q").should == "M"
  end

  it "should encode a string and then decode it back again" do
    cipher = @machine.convert_string("CIDER")
    @machine.reset!
    @machine.convert_string(cipher).should == "CIDER"
  end

end