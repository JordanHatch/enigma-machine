require_relative '../lib/rotor'

describe Rotor do

  before do
    @mappings = [ ["L", "V"], ["M", "Z"] ]
    @io = %w{ A B C D }
  end

  it "should convert the correct character when inbound" do
    r = Rotor.new(@mappings, 0)
    r.convert("A", @io, r.outer).should == "V"
  end

  it "should convert the correct character when outbound" do
    r = Rotor.new(@mappings, 0)
    r.convert("V", r.outer, @io).should == "A"
  end

  it "should accept a default position" do
    r = Rotor.new(@mappings, 5)
    r.position.should == 5
  end

end